package model.data.deposit {
public class DepositInfo {


    public var depositId:int;

    public var questPrototypeId:int;

    public var addedGoldMoney:Number;

    public var bonusGoldMoney:Number;

    public var amount:Number;

    public function DepositInfo() {
        super();
    }

    public static function fromDto(param1:Object):DepositInfo {
        var _loc2_:DepositInfo = new DepositInfo();
        _loc2_.depositId = param1.i;
        _loc2_.questPrototypeId = param1.q;
        _loc2_.addedGoldMoney = param1.g;
        _loc2_.bonusGoldMoney = param1.b;
        _loc2_.amount = param1.v;
        return _loc2_;
    }
}
}
