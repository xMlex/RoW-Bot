package model.logic.robberyLimitData {
import configs.Global;

import model.data.User;
import model.data.locations.allianceCity.flags.enumeration.AllianceEffectBonusType;
import model.data.users.achievements.Achievement;
import model.data.users.achievements.AchievementTypeId;
import model.logic.AllianceManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.flags.BuffDebuffCalculate;
import model.logic.skills.SkillManager;
import model.logic.vip.VipManager;

public class RobberyCounterUtility {

    public static const HOURS_IN_PERIOD:int = 24;


    public function RobberyCounterUtility() {
        super();
    }

    public static function get robberyLimit():Number {
        var _loc2_:User = null;
        var _loc3_:int = 0;
        var _loc4_:Achievement = null;
        var _loc1_:Number = StaticDataManager.knownUsersData.userRobberyLimit;
        if (additionalRobberyEnabled) {
            _loc2_ = UserManager.user;
            if (_loc2_.gameData.vipData && robberyBonusEnabled(RobberyBonusSource.VIP)) {
                _loc1_ = _loc1_ + VipManager.getRobberyBonus(_loc2_);
            }
            if (_loc2_.gameData.skillData && robberyBonusEnabled(RobberyBonusSource.SKILLS)) {
                _loc1_ = _loc1_ + SkillManager.GetRobberyBonus(_loc2_.gameData);
            }
            if (robberyBonusEnabled(RobberyBonusSource.LOGISTICS_CENTER)) {
                _loc3_ = _loc2_.gameData.statsData.achievements.length - 1;
                while (_loc3_ >= 0) {
                    _loc4_ = _loc2_.gameData.statsData.achievements[_loc3_];
                    if (_loc4_.typeId == AchievementTypeId.FRIENDS_REGISTERED && !_loc4_.isPrizeAvailable && _loc4_.robberyLimit > 0) {
                        _loc1_ = _loc1_ + _loc4_.robberyLimit;
                        break;
                    }
                    _loc3_--;
                }
            }
            if (robberyBonusEnabled(RobberyBonusSource.ALLIANCE_TACTICS)) {
                _loc1_ = _loc1_ + tacticEffectRobberyBonus;
            }
        }
        return _loc1_;
    }

    private static function get tacticEffectRobberyBonus():Number {
        var _loc1_:Number = 0;
        if (AllianceManager.currentAlliance && AllianceManager.currentAlliance.gameData.tacticsData && AllianceManager.currentAlliance.gameData.tacticsData.hasActiveEffects && !AllianceManager.isAllianceTrialPeriod()) {
            _loc1_ = BuffDebuffCalculate.getBonusValueByType(AllianceManager.currentAlliance.gameData.tacticsData.activeEffects, AllianceEffectBonusType.EXTRA_DAILY_ROBBERIES);
        }
        return _loc1_;
    }

    public static function incRobberyCounter(param1:Date):void {
        if (!additionalRobberyEnabled) {
            UserManager.user.gameData.worldData.IncRobberyCounter(param1);
            return;
        }
        var _loc2_:Number = robberyLimit;
        UserManager.user.gameData.worldData.robberyCounter++;
        if (UserManager.user.gameData.worldData.robberyCounter < _loc2_) {
            UserManager.user.gameData.worldData.nextAvailableRobberyDate = new Date(UserManager.user.gameData.worldData.nextAvailableRobberyDate.time + HOURS_IN_PERIOD / _loc2_ * 60 * 60 * 1000);
        }
        else {
            UserManager.user.gameData.worldData.nextAvailableRobberyDate = null;
            UserManager.user.gameData.worldData.robberyCounter = _loc2_;
        }
    }

    public static function decRobberyCounter(param1:Date):Boolean {
        var _loc2_:Number = NaN;
        if (!additionalRobberyEnabled) {
            return UserManager.user.gameData.worldData.DecRobberyCounter(param1);
        }
        if (UserManager.user.gameData.worldData.robberyCounter <= 0) {
            if (UserManager.user.gameData.worldData.nextAvailableRobberyDate != null) {
                return false;
            }
            UserManager.user.gameData.worldData.robberyCounter = robberyLimit;
        }
        _loc2_ = robberyLimit;
        UserManager.user.gameData.worldData.robberyCounter--;
        UserManager.user.gameData.worldData.dirtyRobberyCounter = true;
        if (UserManager.user.gameData.worldData.nextAvailableRobberyDate == null && UserManager.user.gameData.worldData.robberyCounter < _loc2_) {
            UserManager.user.gameData.worldData.nextAvailableRobberyDate = new Date(param1.time + HOURS_IN_PERIOD / _loc2_ * 1000 * 60 * 60);
        }
        return true;
    }

    public static function updateNextAvailableRobberyDate(param1:Date):void {
        var _loc2_:Number = robberyLimit;
        if (UserManager.user.gameData.worldData.nextAvailableRobberyDate == null && UserManager.user.gameData.worldData.robberyCounter < _loc2_) {
            UserManager.user.gameData.worldData.nextAvailableRobberyDate = new Date(param1.time + HOURS_IN_PERIOD / _loc2_ * 1000 * 60 * 60);
        }
    }

    private static function robberyBonusEnabled(param1:int):Boolean {
        if (Global.ADDITIONAL_ROBBERY_ENABLED) {
            return true;
        }
        return (Global.serverSettings.unit.bonusRobberiesStateMask & param1) == param1;
    }

    private static function get additionalRobberyEnabled():Boolean {
        if (Global.ADDITIONAL_ROBBERY_ENABLED) {
            return true;
        }
        return Global.serverSettings.unit.bonusRobberiesStateMask != RobberyBonusSource.NONE;
    }
}
}
