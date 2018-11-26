package model.data.units.payloads {
public class TradingOfferPayload {


    public var offerOwnerId:Number;

    public var offerId:Number;

    public function TradingOfferPayload() {
        super();
    }

    public static function fromDto(param1:*):TradingOfferPayload {
        var _loc2_:TradingOfferPayload = new TradingOfferPayload();
        _loc2_.offerOwnerId = param1.i;
        _loc2_.offerId = param1.o;
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.offerOwnerId,
            "o": this.offerId
        };
        return _loc1_;
    }
}
}
