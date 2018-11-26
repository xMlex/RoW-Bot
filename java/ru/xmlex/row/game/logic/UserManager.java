package ru.xmlex.row.game.logic;

import ru.xmlex.row.game.common.DateUtil;
import ru.xmlex.row.game.data.User;
import ru.xmlex.row.game.data.units.Unit;
import ru.xmlex.row.game.data.users.troops.TroopsOrderId;

import java.util.Date;

/**
 * Created by xMlex on 06.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserManager {
    public int segmentId;

    public static Unit getOccupantUnit(User param1) {
        for (Unit _loc2_ : param1.gameData.worldData.units) {
            if ((_loc2_.StateInTargetSector != null && _loc2_.TargetUserId == param1.id) &&
                    _loc2_.troopsPayload != null && _loc2_.troopsPayload.order == TroopsOrderId.Occupation) {
                return _loc2_;
            }
        }
        return null;
    }

    public static int getOccupantUserId(User param1) {
        Unit _loc2_ = getOccupantUnit(param1);
        return _loc2_ == null ? -1 : _loc2_.OwnerUserId;
    }

    public boolean isNewPlayerProtection(int level, long registrationTime, Date loc4_) {
        return false;
    }

    public static boolean isNewPlayerProtection(int param1, Date param2, Date param3) {
        int _loc4_ = (int) ((param3.getTime() - param2.getTime()) / DateUtil.MILLISECONDS_PER_DAY);
        return param1 <= StaticDataManager.skilledUserLevel && _loc4_ <= StaticDataManager.skilledUserDays;
    }
}
