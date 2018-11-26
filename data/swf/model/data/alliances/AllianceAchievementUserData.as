package model.data.alliances {
import common.ArrayCustom;

import flash.utils.Dictionary;

import model.logic.StaticDataManager;

public class AllianceAchievementUserData {


    public var typeId:int;

    public var activeLevel:Number;

    public var levelsInfo:Dictionary;

    public function AllianceAchievementUserData() {
        super();
    }

    public static function fromDto(param1:*):AllianceAchievementUserData {
        var _loc2_:AllianceAchievementUserData = new AllianceAchievementUserData();
        _loc2_.typeId = param1.t;
        _loc2_.activeLevel = param1.l;
        _loc2_.levelsInfo = AllianceAchievementUserLevelInfo.fromDtos(param1.i);
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public function getActiveBonusLevel(param1:AllianceAchievementUserData):int {
        var _loc2_:* = undefined;
        for (_loc2_ in this.levelsInfo) {
            if (this.levelsInfo[_loc2_].bonusState == AllianceAchievementBonusState.ACTIVE && StaticDataManager.allianceData.getAchievementType(param1.typeId).levelInfos[_loc2_ - 1].bonusInfo.hasUserBonus()) {
                return _loc2_;
            }
        }
        return -1;
    }
}
}
