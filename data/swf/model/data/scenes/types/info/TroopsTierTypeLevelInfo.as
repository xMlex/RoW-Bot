package model.data.scenes.types.info {
import common.ArrayCustom;

public class TroopsTierTypeLevelInfo {


    public var upgradePoints:int;

    public var constructionSeconds:int;

    public var battleExperienceRequired:Number;

    public var levelUpPointsRequired:int;

    public var requiredObjects:ArrayCustom;

    public function TroopsTierTypeLevelInfo() {
        super();
    }

    public static function fromDto(param1:*):TroopsTierTypeLevelInfo {
        var _loc2_:TroopsTierTypeLevelInfo = new TroopsTierTypeLevelInfo();
        _loc2_.upgradePoints = param1.u;
        _loc2_.constructionSeconds = param1.s;
        _loc2_.battleExperienceRequired = param1.e;
        _loc2_.levelUpPointsRequired = param1.l;
        _loc2_.requiredObjects = RequiredObject.fromDtos(param1.r);
        return _loc2_;
    }

    public static function fromDtos(param1:*):Array {
        var _loc3_:* = undefined;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
