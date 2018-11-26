package model.data.users.bonuses {
import common.ArrayCustom;

import model.data.Resources;

public class BonusType {


    public var id:int;

    public var reward:Resources;

    public function BonusType() {
        super();
    }

    public static function fromDto(param1:*):BonusType {
        var _loc2_:BonusType = new BonusType();
        _loc2_.id = param1.i;
        _loc2_.reward = Resources.fromDto(param1.r);
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
