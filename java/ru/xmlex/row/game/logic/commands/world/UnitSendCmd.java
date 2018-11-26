package ru.xmlex.row.game.logic.commands.world;

import com.google.gson.JsonObject;
import ru.xmlex.row.game.data.User;
import ru.xmlex.row.game.data.commands.BaseCommand;
import ru.xmlex.row.game.data.commands.UserRefreshCmd;
import ru.xmlex.row.game.data.map.MapPos;
import ru.xmlex.row.game.data.units.payloads.TradingPayload;
import ru.xmlex.row.game.data.units.payloads.TroopsPayload;
import ru.xmlex.row.game.data.users.UserNote;
import ru.xmlex.row.game.data.users.troops.Troops;

import java.util.Date;

/**
 * Created by xMlex on 05.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UnitSendCmd extends BaseCommand {

    private JsonObject r;
    private final int userId;
    private final int targetId;
    private final TradingPayload tradingPayload;
    private final TroopsPayload troopsPayload;
    private final int param5;
    private final Troops troops;
    private final MapPos mapPos;
    private Object[] appliedItemsForBattle = null;

    public UnitSendCmd(int userId, int targetId, TradingPayload param3, TroopsPayload param4, int param5, Troops param6, MapPos param7) {
        this.userId = userId;
        this.targetId = targetId;
        this.tradingPayload = param3;
        this.troopsPayload = param4;
        this.param5 = param5;
        this.troops = param6;
        this.mapPos = param7;
    }

    public UnitSendCmd(int param1, int param2, TradingPayload param3, TroopsPayload param4, int param5, Troops param6) {
        this(param1, param2, param3, param4, param5, param6, null);
    }

    public UnitSendCmd(int param1, int param2, TradingPayload param3, TroopsPayload param4, int param5) {
        this(param1, param2, param3, param4, param5, null, null);
    }

    public UnitSendCmd(int param1, int param2, TradingPayload param3, TroopsPayload param4) {
        this(param1, param2, param3, param4, 0, null, null);
    }

    @Override
    public void onCommandInit() {
        setAction("SendUnit");

        r = new JsonObject();
        r.addProperty("o", userId);
        r.addProperty("t", targetId);
        r.addProperty("u", param5);
        r.add("di", getGsonWithoutExpose().toJsonTree(tradingPayload));
        r.add("ti", getGsonWithoutExpose().toJsonTree(troopsPayload));
        r.add("bt", getGsonWithoutExpose().toJsonTree(troops));
        r.add("k", getGsonWithoutExpose().toJsonTree(mapPos));
        r.add("b", getGsonWithoutExpose().toJsonTree(appliedItemsForBattle));

        setBody(getGsonWithoutExpose().toJson(UserRefreshCmd.makeRequestDto(getClient().getUser(), r)));
    }

    @Override
    public void onCommandResult(String result) {
        //log.info("answer: "+result);
//        String msg = "";
//
//        ша()
//        for (Map.Entry<Integer, Integer> el : troopsPayload.troops.countByType.entrySet()) {
//            msg = msg + StaticDataManager.getInstance().getObjectType(el.getKey()).name + " Кол-во: " + el.getValue() + "\n ";
//        }
//        getClient().logAction("Отправлено в сектор: " + msg.trim());
    }

    //
//    private static void updateEffects(Unit param1) {
//        Array effectShields = null;
//        Unit unit = param1;
//        if (unit == null || unit.troopsPayload == null) {
//            return;
//        }
//        List<Object> userEffects = UserManager.user.gameData.effectData.effectsList;
//        int troopsOrder = unit.troopsPayload.order;
//        if (boolean
//        (TroopsOrderId.isAggressive(troopsOrder)) && unit.TargetTypeId == MapObjectTypeId.USER_OR_LOCATION && !unit.TargetIsLocation)
//        {
//            effectShields = query(userEffects).where(function(EffectItem param1):boolean
//            {
//                return param1.activeState != null && param1.effectTypeId == EffectTypeId.UserFullProtection;
//            }).toArray();
//            EffectsManager.deleteEffects(effectShields);
//        }
//    }
//
//    private static void updateBlackMarketItems(Array param1) {
//        Dictionary _loc3_ = null;
//        BlackMarketItemsNode _loc4_ = null;
//        int _loc5_ = 0;
//        Array _loc2_ = param1;
//        if (_loc2_ != null) {
//            _loc3_ = UserManager.user.gameData.blackMarketData.boughtItems;
//            _loc5_ = 0;
//            while (_loc5_ < _loc2_.length) {
//                _loc4_ = _loc3_[_loc2_[_loc5_]];
//                if (_loc4_ != null) {
//                    if (_loc4_.freeCount + _loc4_.paidCount == 1) {
//                        delete _loc3_[ _loc2_[_loc5_]];
//                    } else if (_loc4_.freeCount != 0) {
//                        _loc4_.freeCount--;
//                    } else {
//                        _loc4_.paidCount--;
//                    }
//                }
//                _loc5_++;
//            }
//        }
//        TroopsSendHelper.appliedItemsForBattle = null;
//    }
//
    public static boolean canSendTroops(User param1, int param2) {
        if (param1.id == param2) {
            return true;
        }
        UserNote _loc3_ = param1.userNoteManager.getById(param2);
        if (_loc3_ == null) {
            return true;
        }
        Date _loc4_ = param1.getClient().serverTimeManager.getServerTimeNow();
        boolean _loc5_ = param1.userManager.isNewPlayerProtection(param1.gameData.account.level, param1.gameData.commonData.registrationTime, _loc4_);
        if (_loc5_) {
            return true;
        }
        return !param1.userManager.isNewPlayerProtection(_loc3_.level, _loc3_.registrationTime, _loc4_);
    }
//
//    private static boolean occupiedUser(int param1) {
//        Unit _loc2_ = null;
//        for (Object _loc2_ : UserManager.user.gameData.worldData.units) {
//            if (_loc2_.TargetUserId == param1 && _loc2_.troopsPayload != null && _loc2_.troopsPayload.order == TroopsOrderId.Occupation && _loc2_.StateInTargetSector != null) {
//                return true;
//            }
//        }
//        return false;
//    }
//
//    private static void removeUnitTroopsFromBunker(User param1, Troops param2) {
//        Unit _loc3_ = UnitUtility.FindInBunkerUnit(param1);
//        if (_loc3_ == null) {
//            return;
//        }
//        _loc3_.troopsPayload.troops.removeTroops(param2);
//        if (_loc3_.troopsPayload.troops.Empty) {
//            UnitUtility.RemoveUnit(param1, _loc3_);
//        }
//    }
}
