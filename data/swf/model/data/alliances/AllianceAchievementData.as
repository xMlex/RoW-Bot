package model.data.alliances {
import common.ArrayCustom;

import flash.utils.Dictionary;

import model.logic.StaticDataManager;

public class AllianceAchievementData {


    public var achievements:ArrayCustom;

    public var troopsTrainedByUser:Dictionary;

    public var raidLocationsCompletedByUser:Dictionary;

    public var resourcesRobbedByUser:Dictionary;

    public var dailyQuestsCompletedByUser:Dictionary;

    public var opponentLossesPowerPointsByUser:Dictionary;

    public function AllianceAchievementData() {
        super();
    }

    public static function fromDto(param1:*):AllianceAchievementData {
        var _loc2_:AllianceAchievementData = new AllianceAchievementData();
        _loc2_.achievements = AllianceAchievement.fromDtos(param1.a);
        _loc2_.troopsTrainedByUser = parseToDictionary(param1.tu);
        _loc2_.raidLocationsCompletedByUser = parseToDictionary(param1.lu);
        _loc2_.resourcesRobbedByUser = parseToDictionary(param1.ru);
        _loc2_.dailyQuestsCompletedByUser = parseToDictionary(param1.du);
        _loc2_.opponentLossesPowerPointsByUser = parseToDictionary(param1.ku);
        return _loc2_;
    }

    private static function parseToDictionary(param1:*):Dictionary {
        var _loc3_:* = undefined;
        var _loc2_:Dictionary = new Dictionary();
        if (param1 != null) {
            for (_loc3_ in param1) {
                _loc2_[_loc3_] = param1[_loc3_];
            }
        }
        return _loc2_;
    }

    public function getBonusAllianceRating():Number {
        var _loc2_:AllianceAchievementType = null;
        var _loc3_:AllianceAchievement = null;
        var _loc4_:AlianceAchievementBonusInfo = null;
        var _loc1_:Number = 0;
        for each(_loc3_ in this.achievements) {
            if (_loc3_.level != 0) {
                _loc4_ = StaticDataManager.allianceData.getAchievementType(_loc3_.typeId).getLevel(_loc3_.level).bonusInfo;
                _loc1_ = _loc1_ + _loc4_.bonusAllianceRatingK * 100;
            }
        }
        return int(_loc1_ * 10) * 0.1;
    }
}
}
