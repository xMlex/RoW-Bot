package model.data.promotionOffers {
import gameObjects.observableObject.ObservableObject;

import model.data.UserPrize;
import model.data.promotionOffers.bankPackageData.UserPromotionOfferBankPackageData;
import model.data.promotionOffers.conditions.UpgradeBuildingsPromotionCondition;
import model.data.promotionOffers.contexts.PromotionContext;
import model.data.promotionOffers.retentionData.UserPromotionOfferRetentionData;
import model.data.promotionOffers.triggerData.UserPromotionOfferTriggerData;
import model.data.specialOfferTriggers.TriggerEventTypeEnum;
import model.logic.ServerTimeManager;
import model.logic.UserManager;

public class UserPromotionOffer extends ObservableObject {

    public static const CLASS_NAME:String = "UserTriggerPromotion";

    public static const STATE_CHANGED:String = CLASS_NAME + "_StateChanged";

    public static const PURCHASED:String = CLASS_NAME + "_Purchased";

    public static const BOUGHT_COUNT_CHANGED:String = CLASS_NAME + "_AvailableCountChanged";

    public static const PRIZE_CHANGED:String = CLASS_NAME + "_PrizeChanged";

    public static const CONDITIONAL_TRIGGERS:Array = [TriggerEventTypeEnum.DISTRIBUTING_SKILL_TREE, TriggerEventTypeEnum.JOINED_ALLIANCE, TriggerEventTypeEnum.BOOST_RESEARCH];

    public static const DELAYED_TRIGGERS:Array = [TriggerEventTypeEnum.GOLD_RUNNING_LOW, TriggerEventTypeEnum.NEGATIVE_MONEY_PRODUCTION, TriggerEventTypeEnum.OUT_OF_WORKERS, TriggerEventTypeEnum.RESURRECTION, TriggerEventTypeEnum.VIP_LEVEL_UP, TriggerEventTypeEnum.EXTRACTOR_RIG, TriggerEventTypeEnum.BUILDING_UPGRADE_TO_ADDITIONAL_LEVEL];

    public static const HIDDEN_TRIGGERS:Array = CONDITIONAL_TRIGGERS.concat(DELAYED_TRIGGERS);


    public var offerId:Number;

    public var promotionId:int;

    public var packageId:int;

    public var promotionRunId:int;

    public var typeId:int;

    public var givenTime:Date;

    public var validTill:Date;

    public var prize:UnitedPrize;

    private var _isStateDirty:Boolean;

    private var _isPurchaseDirty:Boolean;

    private var _isBoughtCountDirty:Boolean;

    private var _isPrizeDirty:Boolean;

    public var prizes:Array;

    public var substractedPrize:UserPrize;

    public var givenPrize:UserPrize;

    public var stateId:int;

    public var showPurchaseDetails:Boolean;

    public var promotionExposureId:Object;

    public var usageCount:int;

    public var boughtCount:int;

    public var priceId:int;

    public var settings:PromotionOfferInterfaceSettings;

    public var generalGoldMoneyPrize:int;

    public var triggerData:UserPromotionOfferTriggerData;

    public var bankPackageData:UserPromotionOfferBankPackageData;

    public var retentionData:UserPromotionOfferRetentionData;

    private var _upgradeBuildingsCondition:UpgradeBuildingsPromotionCondition;

    private var _promotionContext:PromotionContext;

    public function UserPromotionOffer() {
        this._upgradeBuildingsCondition = new UpgradeBuildingsPromotionCondition();
        this._promotionContext = new PromotionContext();
        super();
    }

    public static function fromDto(param1:*):UserPromotionOffer {
        var _loc3_:* = undefined;
        var _loc4_:UnitedPrize = null;
        var _loc2_:UserPromotionOffer = new UserPromotionOffer();
        _loc2_.offerId = param1.i == null ? Number(0) : Number(param1.i);
        _loc2_.promotionId = param1.y;
        _loc2_.packageId = param1.h;
        _loc2_.promotionRunId = param1.d;
        _loc2_.typeId = param1.t;
        _loc2_.givenTime = param1.g == null ? null : new Date(param1.g);
        _loc2_.validTill = param1.v == null ? null : new Date(param1.v);
        _loc2_.prize = param1.p == null ? null : UnitedPrize.fromDto(param1.p);
        if (param1.l != null) {
            _loc2_.prizes = [];
            for each(_loc3_ in param1.l) {
                _loc4_ = UnitedPrize.fromDto(_loc3_);
                _loc2_.prizes.push(_loc4_);
            }
        }
        _loc2_.substractedPrize = param1.sp == null ? new UserPrize() : UserPrize.fromDto(param1.sp);
        _loc2_.givenPrize = param1.np == null ? null : UserPrize.fromDto(param1.np);
        _loc2_.stateId = param1.s;
        _loc2_.showPurchaseDetails = param1.n;
        _loc2_.promotionExposureId = param1.e;
        _loc2_.usageCount = param1.u;
        _loc2_.boughtCount = param1.b;
        _loc2_.priceId = param1.z;
        _loc2_.settings = param1.isj == null ? new PromotionOfferInterfaceSettings() : PromotionOfferInterfaceSettings.fromDto(param1.isj);
        _loc2_.triggerData = param1.r == null ? null : UserPromotionOfferTriggerData.fromDto(param1.r);
        _loc2_.bankPackageData = param1.q == null ? null : UserPromotionOfferBankPackageData.fromDto(param1.q);
        _loc2_.retentionData = param1.a == null ? null : UserPromotionOfferRetentionData.fromDto(param1.a);
        _loc2_.generalGoldMoneyPrize = getGeneralGoldMoneyPrize(_loc2_);
        return _loc2_;
    }

    private static function getGeneralGoldMoneyPrize(param1:UserPromotionOffer):int {
        var _loc4_:UserPrize = null;
        var _loc5_:UserPrize = null;
        var _loc2_:int = 0;
        var _loc3_:UnitedPrize = param1.prize;
        if (_loc3_ != null) {
            _loc4_ = _loc3_.primaryPrize;
            _loc5_ = _loc3_.secondaryPrize;
            if (_loc4_ != null && _loc4_.resources != null) {
                _loc2_ = _loc2_ + _loc4_.resources.goldMoney;
            }
            if (_loc5_ != null && _loc5_.resources != null) {
                _loc2_ = _loc2_ + _loc5_.resources.goldMoney;
            }
        }
        return _loc2_;
    }

    public function get isActive():Boolean {
        return this.stateId == PromotionOfferStateId.NEW || this.stateId == PromotionOfferStateId.IS_READ;
    }

    public function get isNew():Boolean {
        return this.stateId == PromotionOfferStateId.NEW;
    }

    public function get isBought():Boolean {
        return this.stateId == PromotionOfferStateId.BOUGHT;
    }

    public function isHidden():Boolean {
        return this.isNew && this.triggerData != null && HIDDEN_TRIGGERS.indexOf(this.triggerData.triggerType) != -1;
    }

    public function isInvalid():Boolean {
        this._promotionContext.promotion = this;
        var _loc1_:Boolean = this._upgradeBuildingsCondition.context(this._promotionContext).check();
        return _loc1_;
    }

    public function markRead():void {
        if (this.stateId != PromotionOfferStateId.NEW) {
            return;
        }
        this.stateId = PromotionOfferStateId.IS_READ;
        this._isStateDirty = true;
    }

    public function markReadPurchaseInfo():void {
        if (this.showPurchaseDetails) {
            this.showPurchaseDetails = false;
        }
    }

    public function updateStatus():void {
        if (this.isActive && this.validTill != null && this.validTill.time <= ServerTimeManager.serverTimeNow.time || this.retentionData != null && this.retentionData.prizeReceivedDates != null && this.retentionData.prizeReceivedDates.length >= this.prizes.length) {
            this.stateId = PromotionOfferStateId.CLOSED;
            this._isStateDirty = true;
        }
    }

    public function update(param1:UserPromotionOffer):void {
        if (this.stateId != param1.stateId) {
            this.stateId = param1.stateId;
            this._isStateDirty = true;
        }
        if (!this.showPurchaseDetails && param1.showPurchaseDetails) {
            this.showPurchaseDetails = true;
            this._isPurchaseDirty = true;
        }
        if (this.validTill != null && this.validTill.time != param1.validTill.time) {
            this.validTill.time = param1.validTill.time;
        }
        if (this.boughtCount != param1.boughtCount) {
            this.boughtCount = param1.boughtCount;
            this._isBoughtCountDirty = true;
        }
        if (this.retentionData != null && param1.retentionData != null) {
            this.retentionData.prizeReceivedDates = param1.retentionData.prizeReceivedDates;
            this.retentionData.closed = param1.retentionData.closed;
        }
        else {
            this.prize = param1.prize;
            this._isPrizeDirty = true;
        }
        this.substractedPrize = param1.substractedPrize;
        this.givenPrize = param1.givenPrize;
    }

    public function dispatchEvents():void {
        if (this._isStateDirty) {
            this._isStateDirty = false;
            if (hasEventHandler(STATE_CHANGED)) {
                dispatchEvent(STATE_CHANGED);
            }
        }
        if (this._isPurchaseDirty) {
            this._isPurchaseDirty = false;
            if (hasEventHandler(PURCHASED)) {
                dispatchEvent(PURCHASED);
            }
        }
        if (this._isBoughtCountDirty) {
            this._isBoughtCountDirty = false;
            dispatchEvent(BOUGHT_COUNT_CHANGED);
        }
        if (this._isPrizeDirty) {
            this._isPrizeDirty = false;
            if (hasEventHandler(PRIZE_CHANGED)) {
                dispatchEvent(PRIZE_CHANGED);
            }
        }
    }

    public function calculatePrizeFromList():void {
        var _loc1_:Object = null;
        var _loc2_:UnitedPrize = null;
        var _loc3_:UnitedPrize = null;
        if (this.prizes != null) {
            _loc1_ = UserManager.user.gameData.promotionOfferData.promotionOfferPrizesById;
            if (_loc1_[this.offerId] != undefined) {
                this.prize = _loc1_[this.offerId];
            }
            else {
                _loc2_ = new UnitedPrize();
                for each(_loc3_ in this.prizes) {
                    _loc2_.sourceMerge(_loc3_);
                }
                if (this.prize == null) {
                    this.prize = _loc2_;
                }
                else {
                    this.prize.sourceMerge(_loc2_);
                }
                _loc1_[this.offerId] = this.prize;
            }
        }
    }

    public function calculateUncollectedReward():void {
        if (this.prizes == null) {
            return;
        }
        this.prize = new UnitedPrize();
        var _loc1_:int = this.retentionData.prizeReceivedDates == null ? 0 : int(this.retentionData.prizeReceivedDates.length);
        while (_loc1_ < this.prizes.length) {
            this.prize.sourceMerge(this.prizes[_loc1_]);
            _loc1_++;
        }
    }
}
}
