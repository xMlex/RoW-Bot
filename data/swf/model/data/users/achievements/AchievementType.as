package model.data.users.achievements {
import common.ArrayCustom;

public class AchievementType {


    public var typeId:int;

    public var kindId:int;

    public var name:String;

    public var description:String;

    public var levelInfos:ArrayCustom;

    public function AchievementType() {
        super();
    }

    public static function fromDto(param1:*):AchievementType {
        var _loc2_:AchievementType = new AchievementType();
        _loc2_.typeId = param1.i;
        _loc2_.kindId = param1.k;
        _loc2_.name = param1.n.c;
        _loc2_.description = param1.d.c;
        _loc2_.levelInfos = AchievementTypeLevelInfo.fromDtos(param1.l);
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
