package model.data.alliances {
import common.ArrayCustom;

public class TerminalDepositInfo {


    public var depositProxyId:Number;

    public var date:Date;

    public var amount:Number;

    public var goldMoney:Number;

    public var bonusGoldMoney:Number;

    public var isClosed:Boolean = false;

    public var serverMethodName:String;

    public function TerminalDepositInfo() {
        super();
    }

    public static function fromDto(param1:Object):TerminalDepositInfo {
        var _loc2_:TerminalDepositInfo = new TerminalDepositInfo();
        _loc2_.depositProxyId = param1.i;
        if (param1.d) {
            _loc2_.date = new Date(param1.d);
        }
        _loc2_.amount = param1.v;
        _loc2_.goldMoney = param1.g;
        _loc2_.bonusGoldMoney = param1.b;
        _loc2_.isClosed = param1.f;
        _loc2_.serverMethodName = !!param1.s ? param1.s : "";
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            if (!_loc3_.f) {
                _loc2_.addItem(fromDto(_loc3_));
            }
        }
        if (_loc2_.length > 0) {
            return _loc2_;
        }
        return null;
    }
}
}
