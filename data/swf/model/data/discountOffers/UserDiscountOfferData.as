package model.data.discountOffers {
import common.ArrayCustom;

import gameObjects.observableObject.ObservableObject;

import model.data.UserPrize;
import model.logic.discountOffers.UserDiscountOfferManager;

public class UserDiscountOfferData extends ObservableObject {

    public static const DATA_CHANGED:String = "UserDiscountOfferDataChanged";


    public var nextOfferId:int;

    public var lastDiscountOpenTime:Date;

    public var openingBonus:UserPrize;

    public var activeDiscountOffers:ArrayCustom;

    public var dirty:Boolean = false;

    public function UserDiscountOfferData() {
        this.lastDiscountOpenTime = new Date();
        super();
    }

    public static function fromDto(param1:*):UserDiscountOfferData {
        var _loc2_:UserDiscountOfferData = new UserDiscountOfferData();
        _loc2_.nextOfferId = param1.n == null ? 0 : int(param1.n);
        _loc2_.lastDiscountOpenTime = param1.d == null ? new Date() : new Date(param1.d);
        _loc2_.openingBonus = param1.b == null ? null : UserPrize.fromDto(param1.b);
        _loc2_.activeDiscountOffers = param1.a == null ? new ArrayCustom() : ActiveDiscountOffer.fromDtos(param1.a);
        UserDiscountOfferManager.lastDiscountOpenTime = _loc2_.lastDiscountOpenTime;
        UserDiscountOfferManager.activeDiscountOffers = _loc2_.activeDiscountOffers;
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(DATA_CHANGED);
        }
    }
}
}
