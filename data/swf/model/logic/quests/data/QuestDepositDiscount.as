package model.logic.quests.data {
import common.ArrayCustom;

public class QuestDepositDiscount {


    public var type:int;

    public var amountOld:Number;

    public var amountNew:Number;

    public var discountPercent:int;

    public var goldMoney:Number;

    public var goldMoneyBonus:Number;

    public var ogId:String;

    public var kabamSeconds:int;

    public var depositFlag:int;

    public var priceId:int;

    public var priceRefId:int;

    public var currency:String;

    public function QuestDepositDiscount() {
        super();
    }

    public static function fromDto(param1:*):QuestDepositDiscount {
        var _loc2_:QuestDepositDiscount = new QuestDepositDiscount();
        _loc2_.type = param1.t;
        _loc2_.amountOld = param1.o;
        _loc2_.amountNew = param1.n;
        _loc2_.goldMoney = param1.g;
        _loc2_.goldMoneyBonus = param1.b;
        _loc2_.kabamSeconds = param1.k;
        _loc2_.depositFlag = param1.d;
        _loc2_.priceId = param1.q;
        _loc2_.priceRefId = param1.s;
        _loc2_.currency = param1.c;
        _loc2_.discountPercent = _loc2_.amountOld == 0 ? 0 : int((_loc2_.amountOld - _loc2_.amountNew) / _loc2_.amountOld * 100);
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

    public function get totalGoldMoneyValue():Number {
        return this.goldMoney + this.goldMoneyBonus;
    }
}
}
