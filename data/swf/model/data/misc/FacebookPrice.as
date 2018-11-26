package model.data.misc {
public class FacebookPrice {


    public var credits:Number;

    public var goldMoney:Number;

    public var bonus:Number;

    public var availableForSms:Boolean;

    public function FacebookPrice(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Boolean = true) {
        super();
        this.credits = param1;
        this.goldMoney = param2;
        this.bonus = param3;
        this.availableForSms = param4;
    }

    public static function fromDto(param1:Object):FacebookPrice {
        if (param1 == null) {
            return null;
        }
        var _loc2_:FacebookPrice = new FacebookPrice();
        _loc2_.credits = param1.c;
        _loc2_.goldMoney = param1.g;
        _loc2_.bonus = param1.b;
        return _loc2_;
    }

    public static function fromDtos(param1:Array):Vector.<FacebookPrice> {
        var _loc3_:Object = null;
        var _loc2_:Vector.<FacebookPrice> = new Vector.<FacebookPrice>();
        if (param1 == null) {
            return _loc2_;
        }
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
