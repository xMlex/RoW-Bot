package model.data.units {
public class TroopsExperience {


    public var typeId:int;

    public var experience:Number;

    public function TroopsExperience() {
        super();
    }

    public static function fromDto(param1:*):TroopsExperience {
        var _loc2_:TroopsExperience = new TroopsExperience();
        _loc2_.typeId = param1.t;
        _loc2_.experience = param1.e;
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

    public function clone():TroopsExperience {
        var _loc1_:TroopsExperience = new TroopsExperience();
        _loc1_.typeId = this.typeId;
        _loc1_.experience = this.experience;
        return _loc1_;
    }
}
}
