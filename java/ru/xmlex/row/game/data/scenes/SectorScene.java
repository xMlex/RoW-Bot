package ru.xmlex.row.game.data.scenes;

import com.google.common.primitives.Ints;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.common.ConfigSystem;
import ru.xmlex.row.game.data.Resources;
import ru.xmlex.row.game.data.User;
import ru.xmlex.row.game.data.scenes.objects.GeoSceneObject;
import ru.xmlex.row.game.data.users.BuyStatus;
import ru.xmlex.row.game.data.users.UserBuyingData;
import ru.xmlex.row.game.logic.commands.sector.BuyCommand;
import ru.xmlex.row.game.logic.commands.sector.RepairBuildingCmd;
import ru.xmlex.row.instancemanager.listeners.UserListener;

import java.util.List;
import java.util.logging.Logger;

/**
 * Created by xMlex on 4/2/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class SectorScene implements UserListener {
    private static Logger log = Logger.getLogger(SectorScene.class.getName());
    @Expose
    @SerializedName("x")
    public int x;
    @Expose
    @SerializedName("y")
    public int y;
    @Expose
    @SerializedName("o")
    public List<GeoSceneObject> objects;

    private static final int[] BuildWishList = new int[]{
            104,// Титанитовый рудник lvl: 12/25
            102,// Урановая шахта lvl: 12/25
            100,// Сенат lvl: 20/22
            150,// Бункер lvl: 18/26
            // 109,// Банк lvl: 15/25
            // 127,// Исследовательский центр lvl: 19/22
            106,// Жилой комплекс lvl: 10/25
            // 110,// Командный центр lvl: 1/1
            // 112,// Бараки lvl: 1/1
            // 111,// Плац lvl: 1/1
            // 124,// Торговый шлюз lvl: 13/24
            // 101,// Консульство lvl: 9/22
            // 138,// Радар lvl: 12/20
            // 144,// Центр улучшений lvl: 1/1
            // 108,// Склад lvl: 19/25
            // 200,// Стена 1 ур. lvl: 1/1
            // 201,// Башня 1 ур. lvl: 1/1
            // 137,// Промышленный синдикат lvl: 4/7
            // 202,// Ворота 1 ур. lvl: 1/1
            // 118,// Авиабаза lvl: 1/1
            // 121,// Детектор 1 ур. lvl: 1/1
            // 122,// Пушка 1 ур. lvl: 1/1
            // 800,// Бур lvl: 2/6
            // 151,// Нексус lvl: 5/10
            // 506,// PD-13 «Кукарача» lvl: 1/1
            // 114,// Завод мотопехоты lvl: 1/1
            // 600,// Лаборатория киборгов lvl: 1/1
            // 509,// Бочка Мутагена lvl: 1/1
            // 152,// Ремонтная база lvl: 11/16
            // 139,// Арсенал lvl: 1/1
            // 140,// Лаборатория чертежей lvl: 1/1
            // 125,// Торговая палата lvl: 15/24
            // 126,// Транспортная служба lvl: 11/24
            //149,// Биореактор lvl: 1/1
            107,// Финансовая корпорация lvl: 3/7
            // 116,// Завод артиллерии lvl: 1/1
            109,// Банк lvl: 15/25
            105,// Металлургический комбинат lvl: 3/7
            103,// Лаборатория обогащения урана lvl: 1/5
            108,// Склад lvl: 15/25
    };

    public GeoSceneObject getBestForUpgrade(User user) {
        GeoSceneObject forUpgrade = null;
        for (GeoSceneObject el : user.gameData.sector.scene.objects) {
            UserBuyingData.updateObjectStatus(el, user);
            //log.info("B: "+el.getName() + " L: "+el.isBuilding());
            if (el.isBuilding() && el.buyStatus == BuyStatus.OBJECT_CAN_BE_BOUGHT && !el.canBeBroken()
                    && Ints.contains(BuildWishList, el.type)) {
                //log.info("B: " + el.getName() + " lvl: " + el.getLevel() + " statusBuy: " + el.buyStatus);
                if (forUpgrade == null) {
                    forUpgrade = el;
                } else {
                    if (el.getTimeForNextLevelUpgrade() < forUpgrade.getTimeForNextLevelUpgrade())
                        forUpgrade = el;
                }
            }
        }
        log.fine("Building for upgrade: " + forUpgrade);
        return forUpgrade;
    }

    @Override
    public void processUser(User user) {
        // Восстанавливаем, или улучшаем здания которые могут быть повреждены
        for (GeoSceneObject el : user.gameData.sector.scene.objects) {
            if (ConfigSystem.DEBUG)
                log.info("Building: " + el.objectType().name + " cb: " + el.canBeBroken() + " br: " + el.isBroken());
            if (!el.canBeBroken())
                continue;
            if (el.isBroken()) {
                log.fine("Восстанавливаем здание: " + el.objectType().name);
                user.getClient().executeCmd(new RepairBuildingCmd(el));
            } else {
                UserBuyingData.updateObjectStatus(el, user);
                if (el.buyStatus == BuyStatus.OBJECT_CAN_BE_BOUGHT && !el.constructionInfo.isInProgress()) {
                    log.fine("Улучшаем здание: " + el.objectType().name);
                    user.getClient().executeCmd(new BuyCommand(el));
                }
            }
        }

        GeoSceneObject object = getBestForUpgrade(user);
        if (object == null)
            return;

        Resources price = object.getNextLevelInfo().price;
        user.getClient().executeCmd(new BuyCommand(object));
        user.gameData.account.resources.substract(price);
    }

    public void packScene() {

    }


//    public boolean checkBuildingCanBePositioned(GeoSceneObject param1) {
//        return !this.checkTileIsForBuildings(param1.right, param1.top) || !this.checkTileIsForBuildings(param1.right, param1.bottom) || !this.checkTileIsForBuildings(param1.left, param1.top) || !this.checkTileIsForBuildings(param1.left, param1.bottom) || this.getGeoObjectsByPosition(param1.column, param1.row, param1.sizeX, param1.sizeY, param1.isRoad).length > 1;
//    }
}
