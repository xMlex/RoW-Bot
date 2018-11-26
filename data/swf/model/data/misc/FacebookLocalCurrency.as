package model.data.misc {
public class FacebookLocalCurrency {

    public static var FB_Credits:FacebookLocalCurrency = new FacebookLocalCurrency("", 1);

    public static var USD:FacebookLocalCurrency = new FacebookLocalCurrency("$", 100);

    public static var EUR:FacebookLocalCurrency = new FacebookLocalCurrency("€", 101);

    public static var GBP:FacebookLocalCurrency = new FacebookLocalCurrency("£", 102);

    public static var CAD:FacebookLocalCurrency = new FacebookLocalCurrency("CAD", 104);


    private var _value:String;

    private var _intValue:int;

    public function FacebookLocalCurrency(param1:String, param2:int = 100) {
        super();
        this._value = param1;
        this._intValue = param2;
    }

    public static function toClientKey(param1:String):int {
        return getFbCurrencyByCurrency(param1).rawValueInt;
    }

    public static function getFbCurrencyByCurrency(param1:String):FacebookLocalCurrency {
        var _loc2_:FacebookLocalCurrency = USD;
        if (param1 == "USD") {
            _loc2_ = USD;
        }
        else if (param1 == "EUR") {
            _loc2_ = EUR;
        }
        else if (param1 == "GBP") {
            _loc2_ = GBP;
        }
        else if (param1 == "CAD") {
            _loc2_ = CAD;
        }
        return _loc2_;
    }

    public static function getFbCurrency(param1:int):FacebookLocalCurrency {
        var _loc2_:FacebookLocalCurrency = USD;
        if (param1 == 100) {
            _loc2_ = USD;
        }
        else if (param1 == 101) {
            _loc2_ = EUR;
        }
        else if (param1 == 102) {
            _loc2_ = GBP;
        }
        else if (param1 == 104) {
            _loc2_ = CAD;
        }
        return _loc2_;
    }

    public function get rawValue():String {
        return this._value;
    }

    public function get rawValueInt():int {
        return this._intValue;
    }
}
}
