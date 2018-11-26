package model.data {
import common.ArrayCustom;

import model.data.users.troops.Troops;

public class TroopsTransfer {


    public var userId:Number;

    public var transferDate:Date;

    public var orderId:int;

    public var troops:Troops;

    public function TroopsTransfer() {
        super();
    }

    public static function fromDto(param1:*):TroopsTransfer {
        var _loc2_:TroopsTransfer = new TroopsTransfer();
        _loc2_.userId = param1.i;
        _loc2_.transferDate = param1.d == null ? null : new Date(param1.d);
        _loc2_.orderId = param1.o;
        _loc2_.troops = Troops.fromDto(param1.t);
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
