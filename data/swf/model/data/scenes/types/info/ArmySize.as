package model.data.scenes.types.info {
public class ArmySize {


    public var singleLimit:int;

    public var cooperativeMineLimit:int;

    public var emitterLimits:Array;

    public function ArmySize() {
        super();
    }

    public static function fromDto(param1:*):ArmySize {
        var _loc2_:ArmySize = new ArmySize();
        _loc2_.singleLimit = param1.s;
        _loc2_.cooperativeMineLimit = param1.c;
        _loc2_.emitterLimits = !!param1.e ? param1.e : new Array();
        return _loc2_;
    }
}
}
