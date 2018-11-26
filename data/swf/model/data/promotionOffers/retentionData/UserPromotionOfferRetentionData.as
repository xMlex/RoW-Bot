package model.data.promotionOffers.retentionData {
public class UserPromotionOfferRetentionData {


    public var prizeReceivedDates:Array;

    public var retentionPackageId:int;

    public var closed:Boolean;

    public var prizeMerged:Boolean;

    public function UserPromotionOfferRetentionData() {
        super();
    }

    public static function fromDto(param1:*):UserPromotionOfferRetentionData {
        var _loc3_:* = undefined;
        var _loc2_:UserPromotionOfferRetentionData = new UserPromotionOfferRetentionData();
        _loc2_.retentionPackageId = param1.p;
        if (param1.d != null) {
            _loc2_.prizeReceivedDates = [];
            for each(_loc3_ in param1.d) {
                _loc2_.prizeReceivedDates.push(new Date(_loc3_));
            }
        }
        _loc2_.closed = param1.c;
        _loc2_.prizeMerged = param1.m == null ? false : Boolean(param1.m);
        return _loc2_;
    }
}
}
