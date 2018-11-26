package model.data.scenes.types.info {
public class MovingUnitCount {


    public var attackCount:int;

    public var caravansCount:int;

    public var reconCount:int;

    public function MovingUnitCount() {
        super();
    }

    public static function fromDto(param1:*):MovingUnitCount {
        var _loc2_:MovingUnitCount = new MovingUnitCount();
        _loc2_.attackCount = param1.a;
        _loc2_.caravansCount = param1.c;
        _loc2_.reconCount = param1.r;
        return _loc2_;
    }
}
}
