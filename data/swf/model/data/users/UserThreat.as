package model.data.users {
import common.ArrayCustom;

public class UserThreat {


    public var userId:Number;

    public var strength:Number;

    public function UserThreat() {
        super();
    }

    public static function fromDto(param1:*):UserThreat {
        var _loc2_:UserThreat = new UserThreat();
        _loc2_.userId = param1.i;
        _loc2_.strength = Math.abs(param1.s);
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
