package model.data.promotionOffers {
import common.queries.util.query;

import gameObjects.observableObject.ObservableObject;

public class UserPromotionOfferData extends ObservableObject {

    public static const CLASS_NAME:String = "UserPromotionOfferData";

    public static const PROMOTION_ADDED:String = CLASS_NAME + "_AddedPromotion";

    public static const PROMOTION_REMOVED:String = CLASS_NAME + "_RemovedPromotion";

    public static const PROMOTION_EXPIRED:String = CLASS_NAME + "_PromotionExpired";

    public static const PROMOTION_BOUGHT:String = CLASS_NAME + "_PromotionBought";

    public static const PROMOTION_CLOSED:String = CLASS_NAME + "_PromotionClosed";

    public static const PROMOTION_HIDDEN:String = CLASS_NAME + "_PromotionHidden";

    public static const RETENTION_REWARD_TAKEN:String = CLASS_NAME + "_RewardTaken";


    public var hiddenPromotionOffers:Array;

    public var promotionOfferPrizesById:Object;

    public var isRewardTaken:Boolean;

    private var _promotionOffersByOfferId:Object;

    private var _isPromotionBought:Boolean;

    private var _isPromotionExpired:Boolean;

    private var _isPromotionAdded:Boolean;

    private var _isPromotionHidden:Boolean;

    private var _isPromotionRemoved:Boolean;

    public var lastBoughtPromotionId:int;

    private var _availablePromotionOffers:Vector.<UserPromotionOffer>;

    private var _isPromotionClosed:Boolean;

    public function UserPromotionOfferData() {
        this.hiddenPromotionOffers = [];
        this.promotionOfferPrizesById = {};
        super();
        this._availablePromotionOffers = new Vector.<UserPromotionOffer>();
        this._promotionOffersByOfferId = {};
    }

    public static function fromDto(param1:*):UserPromotionOfferData {
        var _loc3_:UserPromotionOffer = null;
        var _loc4_:* = undefined;
        var _loc2_:UserPromotionOfferData = new UserPromotionOfferData();
        if (param1.e != null) {
            for each(_loc4_ in param1.e) {
                _loc3_ = UserPromotionOffer.fromDto(_loc4_);
                _loc2_.addPromotion(_loc3_);
            }
        }
        return _loc2_;
    }

    public function get availablePromotionOffers():Vector.<UserPromotionOffer> {
        return this._availablePromotionOffers;
    }

    public function getPromotionOfferByOfferId(param1:int):UserPromotionOffer {
        return this._promotionOffersByOfferId[param1];
    }

    public function getHiddenOfferByTriggerTypeId(param1:int):UserPromotionOffer {
        var typeId:int = param1;
        if (this.hiddenPromotionOffers.length == 0) {
            return null;
        }
        return query(this.hiddenPromotionOffers).firstOrDefault(function (param1:UserPromotionOffer):Boolean {
            return param1.isNew && param1.triggerData != null && param1.triggerData.triggerType == typeId;
        });
    }

    public function dispatchEvents():void {
        var _loc2_:UserPromotionOffer = null;
        if (this._isPromotionAdded) {
            this._isPromotionAdded = false;
            dispatchEvent(PROMOTION_ADDED);
        }
        if (this._isPromotionHidden) {
            this._isPromotionHidden = false;
            dispatchEvent(PROMOTION_HIDDEN);
        }
        if (this._isPromotionRemoved) {
            this._isPromotionRemoved = false;
            dispatchEvent(PROMOTION_REMOVED);
        }
        if (this._isPromotionBought) {
            this._isPromotionBought = false;
            dispatchEvent(PROMOTION_BOUGHT);
        }
        if (this._isPromotionExpired) {
            this._isPromotionExpired = false;
            dispatchEvent(PROMOTION_EXPIRED);
        }
        if (this._isPromotionClosed) {
            this._isPromotionClosed = false;
            dispatchEvent(PROMOTION_CLOSED);
        }
        if (this.isRewardTaken) {
            this.isRewardTaken = false;
            dispatchEvent(RETENTION_REWARD_TAKEN);
        }
        var _loc1_:int = this._availablePromotionOffers == null ? 0 : int(this._availablePromotionOffers.length);
        var _loc3_:int = 0;
        while (_loc3_ < _loc1_) {
            _loc2_ = this._availablePromotionOffers[_loc3_];
            _loc2_.dispatchEvents();
            _loc3_++;
        }
    }

    public function set isPromotionClosed(param1:Boolean):void {
        this._isPromotionClosed = param1;
    }

    public function forEach(param1:Function):void {
        this._availablePromotionOffers.forEach(param1);
    }

    public function every(param1:Function):void {
        this._availablePromotionOffers.every(param1);
    }

    public function unHideTriggerByOfferId(param1:int):void {
        var _loc2_:int = this.hiddenPromotionOffers.length - 1;
        while (_loc2_ >= 0) {
            if (this.hiddenPromotionOffers[_loc2_].offerId != param1) {
                _loc2_--;
                continue;
            }
            this.addPromotionFromHidden(this.hiddenPromotionOffers[_loc2_]);
            this.hiddenPromotionOffers.splice(_loc2_, 1);
            this._isPromotionAdded = true;
            break;
        }
    }

    public function updateStatus():void {
        var _loc2_:UserPromotionOffer = null;
        var _loc4_:int = 0;
        var _loc1_:int = this._availablePromotionOffers != null ? int(this._availablePromotionOffers.length) : 0;
        var _loc3_:int = 0;
        while (_loc3_ < _loc1_) {
            _loc2_ = this._availablePromotionOffers[_loc3_];
            _loc4_ = _loc2_.stateId;
            _loc2_.updateStatus();
            if (_loc4_ <= PromotionOfferStateId.IS_READ && _loc2_.stateId == PromotionOfferStateId.CLOSED) {
                this._isPromotionExpired = true;
            }
            else if (_loc4_ == PromotionOfferStateId.BOUGHT && _loc2_.stateId == PromotionOfferStateId.CLOSED) {
                this._isPromotionClosed = true;
            }
            _loc3_++;
        }
    }

    public function update(param1:UserPromotionOfferData):void {
        var _loc3_:UserPromotionOffer = null;
        var _loc5_:UserPromotionOffer = null;
        var _loc2_:int = this._availablePromotionOffers.length;
        var _loc4_:int = _loc2_ - 1;
        while (_loc4_ >= 0) {
            _loc3_ = this._availablePromotionOffers[_loc4_];
            if (param1._promotionOffersByOfferId[_loc3_.offerId] == undefined) {
                this.removePromotion(_loc3_, _loc4_);
                this._isPromotionRemoved = true;
            }
            _loc4_--;
        }
        _loc2_ = param1._availablePromotionOffers.length;
        _loc4_ = 0;
        while (_loc4_ < _loc2_) {
            _loc5_ = param1._availablePromotionOffers[_loc4_];
            _loc3_ = this._promotionOffersByOfferId[_loc5_.offerId];
            if (_loc3_ != null) {
                if (!_loc3_.showPurchaseDetails && _loc5_.showPurchaseDetails) {
                    this.lastBoughtPromotionId = _loc5_.offerId;
                    this._isPromotionBought = true;
                }
                if (_loc3_.stateId <= PromotionOfferStateId.IS_READ && _loc5_.stateId == PromotionOfferStateId.CLOSED) {
                    this._isPromotionExpired = true;
                }
                if (_loc3_.stateId == PromotionOfferStateId.BOUGHT && _loc5_.stateId == PromotionOfferStateId.CLOSED) {
                    this._isPromotionClosed = true;
                }
                _loc3_.update(_loc5_);
            }
            else {
                this.addOrHide(_loc5_);
            }
            _loc4_++;
        }
    }

    public function hideInvalidPromotions():void {
        var _loc1_:UserPromotionOffer = null;
        var _loc2_:int = this._availablePromotionOffers.length - 1;
        while (_loc2_ >= 0) {
            _loc1_ = this._availablePromotionOffers[_loc2_];
            if (!(!_loc1_.isNew || !_loc1_.isInvalid())) {
                this.hidePromotion(_loc1_);
                this.removePromotion(_loc1_, _loc2_);
            }
            _loc2_--;
        }
    }

    private function addOrHide(param1:UserPromotionOffer):void {
        if (param1.isInvalid() || param1.isHidden()) {
            this.hidePromotion(param1);
        }
        else {
            this.addPromotion(param1);
            this._isPromotionAdded = true;
            this.dispatchEvents();
        }
    }

    private function hidePromotion(param1:UserPromotionOffer):void {
        var _loc2_:Boolean = false;
        var _loc3_:int = 0;
        while (_loc3_ < this.hiddenPromotionOffers.length) {
            if (param1.offerId == this.hiddenPromotionOffers[_loc3_].offerId) {
                this.hiddenPromotionOffers[_loc3_] = param1;
                _loc2_ = true;
                break;
            }
            _loc3_++;
        }
        if (!_loc2_) {
            this.hiddenPromotionOffers.push(param1);
        }
        this._isPromotionHidden = true;
    }

    private function addPromotion(param1:UserPromotionOffer):void {
        var _loc2_:Boolean = false;
        var _loc3_:int = 0;
        while (_loc3_ < this._availablePromotionOffers.length) {
            if (param1.offerId == this._availablePromotionOffers[_loc3_].offerId) {
                this._availablePromotionOffers[_loc3_] = param1;
                _loc2_ = true;
                break;
            }
            _loc3_++;
        }
        if (!_loc2_) {
            this._availablePromotionOffers.push(param1);
        }
        this._promotionOffersByOfferId[param1.offerId] = param1;
    }

    private function addPromotionFromHidden(param1:UserPromotionOffer):void {
        var _loc2_:Boolean = false;
        var _loc3_:int = 0;
        while (_loc3_ < this._availablePromotionOffers.length) {
            if (param1.offerId == this._availablePromotionOffers[_loc3_].offerId) {
                this._promotionOffersByOfferId[param1.offerId] = this._availablePromotionOffers[_loc3_];
                _loc2_ = true;
                break;
            }
            _loc3_++;
        }
        if (!_loc2_) {
            this._availablePromotionOffers.push(param1);
            this._promotionOffersByOfferId[param1.offerId] = param1;
        }
    }

    private function removePromotion(param1:UserPromotionOffer, param2:int = -1):void {
        delete this._promotionOffersByOfferId[param1.offerId];
        if (param2 == -1) {
            param2 = this._availablePromotionOffers.indexOf(param1);
        }
        if (param2 >= 0) {
            this._availablePromotionOffers.splice(param2, 1);
        }
    }
}
}
