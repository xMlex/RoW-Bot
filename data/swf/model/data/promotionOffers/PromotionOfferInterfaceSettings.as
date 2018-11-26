package model.data.promotionOffers {
import json.JSONDecoder;

public class PromotionOfferInterfaceSettings {


    private var _layoutId:int;

    private var _titleId:int;

    private var _ctaId:int;

    private var _imageId:int;

    private var _discount:Number;

    public function PromotionOfferInterfaceSettings() {
        super();
    }

    public static function fromDto(param1:String):PromotionOfferInterfaceSettings {
        var _loc2_:PromotionOfferInterfaceSettings = new PromotionOfferInterfaceSettings();
        var _loc3_:* = new JSONDecoder(param1, false).getValue();
        _loc2_._layoutId = _loc3_.l;
        _loc2_._titleId = _loc3_.t;
        _loc2_._ctaId = _loc3_.c;
        _loc2_._imageId = _loc3_.i;
        _loc2_._discount = _loc3_.d;
        return _loc2_;
    }

    public function get layoutId():int {
        return this._layoutId;
    }

    public function get titleId():int {
        return this._titleId;
    }

    public function get ctaId():int {
        return this._ctaId;
    }

    public function get imageId():int {
        return this._imageId;
    }

    public function get discount():Number {
        return this._discount;
    }
}
}
