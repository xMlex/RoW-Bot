package model.data.users.bonuses {
import common.ArrayCustom;

import model.data.Resources;

public class Bonus {


    public var bonusTypeId:int;

    public var date:Date;

    public var reward:Resources;

    public function Bonus() {
        super();
    }

    public static function fromDto(param1:*):Bonus {
        var _loc2_:Bonus = new Bonus();
        _loc2_.bonusTypeId = param1.i;
        _loc2_.date = new Date(param1.d);
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
