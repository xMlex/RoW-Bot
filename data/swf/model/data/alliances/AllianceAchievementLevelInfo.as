package model.data.alliances {
import common.ArrayCustom;

public class AllianceAchievementLevelInfo {


    public var value:Number;

    public var bonusInfo:AlianceAchievementBonusInfo;

    public var goldLevel:Boolean;

    public function AllianceAchievementLevelInfo() {
        super();
    }

    public static function fromDto(param1:*):AllianceAchievementLevelInfo {
        if (param1 == null) {
            return null;
        }
        var _loc2_:AllianceAchievementLevelInfo = new AllianceAchievementLevelInfo();
        _loc2_.value = param1.v;
        _loc2_.bonusInfo = param1.b == null ? null : AlianceAchievementBonusInfo.fromDto(param1.b);
        _loc2_.goldLevel = param1.g;
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
}
}
