package model.data.locations {
import common.ArrayCustom;
import common.ObjectUtil;

public class Location {


    public var id:Number;

    public var gameData:LocationGameData;

    public function Location() {
        super();
    }

    public static function fromDto(param1:*):Location {
        var _loc2_:Location = new Location();
        _loc2_.id = param1.i;
        _loc2_.gameData = LocationGameData.fromDto(param1.g);
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

    public function clone():Location {
        return ObjectUtil.trueClone(this) as Location;
    }
}
}
