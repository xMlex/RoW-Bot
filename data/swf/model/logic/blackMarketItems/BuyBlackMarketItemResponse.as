package model.logic.blackMarketItems {
import model.data.Resources;

public class BuyBlackMarketItemResponse {


    public var price:Resources;

    public var activationResult:ActivateItemResponse;

    public function BuyBlackMarketItemResponse() {
        super();
    }

    public static function fromDto(param1:*):BuyBlackMarketItemResponse {
        var _loc2_:BuyBlackMarketItemResponse = new BuyBlackMarketItemResponse();
        _loc2_.price = param1.p == null ? null : Resources.fromDto(param1.p);
        _loc2_.activationResult = param1.r == null ? null : ActivateItemResponse.fromDto(param1.r);
        return _loc2_;
    }
}
}
