package model.data.users.trading {
import common.ArrayCustom;

import gameObjects.observableObject.ObservableObject;

import model.data.Resources;

public class TradingCenter extends ObservableObject {

    public static const CLASS_NAME:String = "TradingCenter";

    public static const OFFERS_CHANGED:String = CLASS_NAME + "OffersChanged";

    public static const RESOURCES_PER_CARAVAN:int = 1000;

    public static const OUTDATED_OFFER_HOURS:int = 72;


    public var offers:ArrayCustom;

    public var offersDirty:Boolean = true;

    public var maxResourcesTransfer:Resources;

    public function TradingCenter() {
        this.maxResourcesTransfer = new Resources(0, 5000, 5000, 5000);
        super();
    }

    public static function fromDto(param1:*):TradingCenter {
        if (param1 == null) {
            return null;
        }
        var _loc2_:TradingCenter = new TradingCenter();
        _loc2_.offers = param1.o == null ? null : TradingOffer.fromDtos(param1.o);
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.offersDirty) {
            this.offersDirty = false;
            dispatchEvent(OFFERS_CHANGED);
        }
    }
}
}
