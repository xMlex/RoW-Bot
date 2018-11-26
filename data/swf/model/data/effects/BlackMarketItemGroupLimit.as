package model.data.effects {
import common.ArrayCustom;

public class BlackMarketItemGroupLimit {


    public var totalLimit:int;

    public var blackMarketItemIds:ArrayCustom;

    public function BlackMarketItemGroupLimit() {
        super();
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function fromDto(param1:*):BlackMarketItemGroupLimit {
        var _loc4_:* = undefined;
        var _loc2_:BlackMarketItemGroupLimit = new BlackMarketItemGroupLimit();
        _loc2_.totalLimit = param1.l;
        var _loc3_:ArrayCustom = new ArrayCustom();
        for each(_loc4_ in param1.i) {
            _loc3_.addItem(_loc4_);
        }
        _loc2_.blackMarketItemIds = _loc3_;
        return _loc2_;
    }
}
}
