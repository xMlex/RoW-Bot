package model.data.alliances {
import flash.utils.Dictionary;

public class AllianceAchievementUserLevelInfo {


    public var bonusState:int;

    public var appendAllianceId:Number;

    public var completedAllianceId:Number;

    public var appliedBonusAllianceId:Number;

    public function AllianceAchievementUserLevelInfo() {
        super();
    }

    public static function fromDto(param1:*):AllianceAchievementUserLevelInfo {
        var _loc2_:AllianceAchievementUserLevelInfo = new AllianceAchievementUserLevelInfo();
        _loc2_.bonusState = param1.b;
        _loc2_.appendAllianceId = param1.c;
        _loc2_.completedAllianceId = param1.w;
        _loc2_.appliedBonusAllianceId = param1.u;
        return _loc2_;
    }

    public static function fromDtos(param1:*):Dictionary {
        var _loc3_:* = undefined;
        var _loc2_:Dictionary = new Dictionary();
        for (_loc3_ in param1) {
            _loc2_[_loc3_] = fromDto(param1[_loc3_]);
        }
        return _loc2_;
    }
}
}
