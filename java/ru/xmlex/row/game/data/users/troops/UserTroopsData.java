package ru.xmlex.row.game.data.users.troops;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;
import ru.xmlex.row.game.data.User;
import ru.xmlex.row.game.data.scenes.objects.GeoSceneObject;
import ru.xmlex.row.game.data.scenes.types.info.SaleableLevelInfo;
import ru.xmlex.row.game.data.units.Unit;
import ru.xmlex.row.game.data.units.payloads.TroopsPayload;
import ru.xmlex.row.game.data.users.BuyStatus;
import ru.xmlex.row.game.data.users.UserBuyingData;
import ru.xmlex.row.game.logic.StaticDataManager;
import ru.xmlex.row.game.logic.commands.sector.BuyCommand;
import ru.xmlex.row.game.logic.commands.world.UnitSendCmd;
import ru.xmlex.row.game.logic.units.UnitUtility;
import ru.xmlex.row.instancemanager.listeners.UserListener;
import xmlex.vk.row.model.data.scenes.types.GeoSceneObjectType;

import java.util.Map;

/**
 * Created by xMlex on 29.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserTroopsData implements UserListener {
    @Expose
    @SerializedName("r")
    public Troops troops;
    @Expose
    @SerializedName("f")
    public TroopsFactory troopsFactory;
    @Expose
    @SerializedName("m")
    public Troops missileStorage;
    @Expose
    @SerializedName("o")
    public TroopsLosses[] troopsLosses = new TroopsLosses[]{};
    @Expose
    @SerializedName("e")
    public TroopsLosses[] freeTroopsLosses = new TroopsLosses[]{};

    @Override
    public void processUser(User user) {

        int targetCount = 100;
        int[] autoTroops = new int[]{1, 2};

        for (int troopId : autoTroops) {
            int totalCount = user.gameData.troopsData.getTroopCountById(troopId, user);

            if (user.gameData.troopsData.troopsFactory != null)
                totalCount += user.gameData.troopsData.troopsFactory.getTotalCountByTypeId(troopId);

            if (totalCount >= targetCount)
                continue;

            Resources price = getTroopPrice(troopId);
            if (price != null) {
                int count = user.gameData.account.resources.getCount(price);
                price.scale(count);
                if (price.isTitaniteMoreUranium() && !user.gameData.account.resources.isTitaniteMoreUranium())
                    continue;
                GeoSceneObject object = GeoSceneObject.createBuyTroops(troopId, count);
                UserBuyingData.updateObjectStatus(object, user, true, false);
                if (object.buyStatus == BuyStatus.OBJECT_CAN_BE_BOUGHT) {
                    if (object.troopsInfo.countForBuy > 0 && user.gameData.account.resources.canSubstract(price)) {
                        user.getClient().executeCmd(new BuyCommand(object));
                        user.gameData.account.resources.substract(price);
                    }
                }
            }
        }
    }

    /**
     * Получаем цену отного юнита
     *
     * @param type
     * @param count
     * @return
     */
    public Resources getTroopPrice(int type, int count) {
        Resources res = null;
        GeoSceneObjectType objectType = StaticDataManager.getInstance().getObjectType(type);
        if (objectType != null && objectType.isTroops()) {
            SaleableLevelInfo levelInfo = objectType.saleableInfo.getLevelInfo(1);
            if (levelInfo != null) {
                res = levelInfo.price.clone();
                res.scale(count);
                return res;
            }
        }
        return res;
    }

    public Resources getTroopPrice(int type) {
        return getTroopPrice(type, 1);
    }

    public int getTroopCountById(int id) {
        return getTroopCountById(id, null);
    }

    public int getTroopCountById(int id, User user) {
        int r = 0;
        for (Map.Entry<Integer, Integer> el : troops.countByType.entrySet()) {
            if (el.getKey() == id)
                r += el.getValue();
        }
        // Считаем войска в бункере
        r += getTroopInBunkerCountById(id, user);
        return r;
    }

    public int getTroopInBunkerCountById(int id, User user) {
        int r = 0;
        // Считаем войска в бункере
        if (user != null) {
            Unit bunker = UnitUtility.FindInBunkerUnit(user);
            if (bunker != null) {
                for (Map.Entry<Integer, Integer> el : bunker.troopsPayload.troops.countByType.entrySet()) {
                    if (el.getKey() == id)
                        r += el.getValue();
                }
            }
        }
        return r;
    }

    public boolean isAviable(User user, Troops troops) {
        for (Map.Entry<Integer, Integer> el : troops.countByType.entrySet()) {
            int count = user.gameData.troopsData.getTroopCountById(el.getKey(), user);
            if (el.getValue() > count || count <= 0) {
                return false;
            }
        }
        return true;
    }

    public boolean sendRobberyTroops(User user, int toId, Troops troops) {
        return sendTroops(user, toId, troops, TroopsOrderId.Robbery, 1);
    }

    public boolean sendReinforcementTroops(User user, int toId, Troops troops) {
        return sendTroops(user, toId, troops, TroopsOrderId.Reinforcement, 1);
    }

    public boolean sendTroopsToBunker(User user, Troops troops) {
        return sendTroops(user, user.id, troops, TroopsOrderId.Bunker, 0);
    }

    public boolean sendTroops(User user, int toId, Troops troops, int order, int self) {
        if (!isAviable(user, troops))
            return false;
        TroopsPayload troopsPayload = new TroopsPayload();
        troopsPayload.order = order;
        Troops troopsBunker = null;

        int currentCount = 0, tmp = 0;

        for (Map.Entry<Integer, Integer> el : troops.countByType.entrySet()) {
            currentCount = el.getValue();
            int sectorCount = getTroopCountById(el.getKey());
            if (sectorCount > 0) {
                if (troopsPayload.troops == null)
                    troopsPayload.troops = new Troops();
                if (sectorCount > el.getValue())
                    tmp = el.getValue();
                else
                    tmp = sectorCount;
                troopsPayload.troops.countByType.put(el.getKey(), tmp);
                currentCount -= tmp;
                troops.removeTroops(troopsPayload.troops);
                user.gameData.troopsData.troops.removeTroops(troopsPayload.troops);
            }
            // Войска в бункере
            if (order != TroopsOrderId.Bunker) {
                int bunkerCount = getTroopInBunkerCountById(el.getKey(), user);
                if (currentCount > 0 && bunkerCount > 0) {
                    if (troopsBunker == null)
                        troopsBunker = new Troops();
                    if (bunkerCount < currentCount)
                        tmp = bunkerCount;
                    else
                        tmp = currentCount;
                    troopsBunker.countByType.put(el.getKey(), tmp);
                    Unit unit = UnitUtility.FindInBunkerUnit(user);
                    if (unit != null)
                        unit.troopsPayload.troops.removeTroops(troopsBunker);
                }
            }
        }
        if (troopsBunker != null || troopsPayload.troops != null) {
            user.getClient().executeCmd(new UnitSendCmd(user.id, toId, null, troopsPayload, self, troopsBunker));
        } else {
            //System.out.println("ERROR! Incorrect calc unit send");
            //Thread.dumpStack();
        }
        return true;
    }
}
