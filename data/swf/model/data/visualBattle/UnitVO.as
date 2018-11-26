package model.data.visualBattle {
public class UnitVO {


    public var type:int;

    public var count:int;

    public var losses:int;

    public var force:int;

    public function UnitVO() {
        super();
    }

    public static function fromDto(param1:*):UnitVO {
        var _loc2_:UnitVO = new UnitVO();
        _loc2_.type = param1.t;
        _loc2_.count = param1.c;
        _loc2_.losses = param1.l;
        _loc2_.force = param1.f;
        return _loc2_;
    }

    public static function fromDtos(param1:*):Vector.<UnitVO> {
        var _loc3_:* = undefined;
        var _loc2_:Vector.<UnitVO> = new Vector.<UnitVO>();
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public function getDto():* {
        var _loc1_:* = undefined;
        _loc1_ = {
            "t": this.type,
            "c": this.count,
            "l": this.losses,
            "f": this.force
        };
        return _loc1_;
    }
}
}
