package model.data.alliances {
import common.GameType;

import model.logic.ServerManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;

public class AllianceAchievementManager {


    public function AllianceAchievementManager() {
        super();
    }

    public static function getImageUrl(param1:int, param2:Boolean):String {
        var _loc3_:* = null;
        var _loc4_:* = null;
        if (GameType.isNords) {
            _loc4_ = "ui/clans/achievementsWithLevel_02/";
            _loc3_ = param1 < 10 ? _loc4_ + "0" + param1 + "_" : _loc4_ + param1 + "_";
        }
        else {
            _loc4_ = "ui/clans/achievementsWithLevel";
            if (GameType.isSparta) {
                _loc4_ = _loc4_ + "1";
            }
            _loc3_ = param1 < 10 ? _loc4_ + "/0" + param1 + "_" : _loc4_ + "/" + param1 + "_";
        }
        _loc3_ = _loc3_ + (!!param2 ? "big" : "small");
        if (GameType.isMilitary && (param1 == 9 || param1 == 10)) {
            _loc3_ = _loc3_ + "_01";
        }
        if (GameType.isTotalDomination && !param2 && (param1 == 9 || param1 == 10)) {
            _loc3_ = _loc3_ + "_01";
        }
        return ServerManager.buildContentUrl(_loc3_ + ".swf");
    }

    public static function getCurrentFrameForImage(param1:int, param2:int):int {
        var _loc3_:int = 0;
        if (param2 <= 5) {
            _loc3_ = param1 + 1;
        }
        else {
            switch (param1) {
                case 1:
                    _loc3_ = 2;
                    break;
                case 2:
                    _loc3_ = 2;
                    break;
                case 3:
                    _loc3_ = 3;
                    break;
                case 4:
                    _loc3_ = 3;
                    break;
                case 5:
                    _loc3_ = 4;
                    break;
                case 6:
                    _loc3_ = 4;
                    break;
                case 7:
                    _loc3_ = 5;
                    break;
                case 8:
                    _loc3_ = 5;
                    break;
                case 9:
                    _loc3_ = 5;
                    break;
                case 10:
                    _loc3_ = 6;
            }
        }
        return _loc3_;
    }

    public static function getAntigenBonus():Number {
        return sumBonus(function (param1:AlianceAchievementBonusInfo):Number {
            return param1.antigenBonus;
        });
    }

    public static function getAttackBonus():Number {
        return sumBonus(function (param1:AlianceAchievementBonusInfo):Number {
            return param1.attackBonus;
        });
    }

    public static function getDefenseBonus():Number {
        return sumBonus(function (param1:AlianceAchievementBonusInfo):Number {
            return param1.defenseBonus;
        });
    }

    private static function sumBonus(param1:Function):Number {
        var _loc3_:AllianceAchievementUserData = null;
        var _loc4_:AlianceAchievementBonusInfo = null;
        var _loc2_:Number = 0;
        for each(_loc3_ in UserManager.user.gameData.statsData.allianceAchievements) {
            if (!isNaN(_loc3_.activeLevel)) {
                _loc4_ = StaticDataManager.allianceData.getAchievementType(_loc3_.typeId).getLevel(_loc3_.activeLevel).bonusInfo;
                _loc2_ = _loc2_ + param1(_loc4_);
            }
        }
        return _loc2_;
    }
}
}
