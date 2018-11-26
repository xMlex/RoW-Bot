package model.data.scenes.types.info.troops {
import common.ArrayCustom;

public class DefenseItem {


    public var troopsGroupId:int;

    public var defense:Number;

    public function DefenseItem() {
        super();
    }

    public static function fromDto(param1:*):DefenseItem {
        if (param1 == null) {
            return null;
        }
        var _loc2_:DefenseItem = new DefenseItem();
        _loc2_.troopsGroupId = param1.g;
        _loc2_.defense = param1.d;
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
