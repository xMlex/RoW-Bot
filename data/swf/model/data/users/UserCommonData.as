package model.data.users {
import common.ArrayCustom;
import common.DateUtil;

import gameObjects.observableObject.ObservableObject;

import model.data.SpecialOffer;
import model.data.User;
import model.data.normalization.INEvent;
import model.data.normalization.INormalizable;
import model.data.normalization.NEventUser;
import model.logic.ResourcesKitLimit;
import model.logic.StaticDataManager;

public class UserCommonData extends ObservableObject implements INormalizable {

    public static const CLASS_NAME:String = "UserCommonData";

    public static const KITS_CHANGED:String = CLASS_NAME + "KitsChanged";

    public static const SPECIAL_OFFERS_CHANGED:String = CLASS_NAME + "SpecialOffersChanged";

    public static const VIP_STATUS:String = "VipStatusChanged";

    public static const ELDER_PLAYER_RETURN_DAYS:int = 7;


    public var registrationTime:Date;

    public var lastVisitTime:Date;

    public var lastVisitTimePrev:Date;

    public var loyaltyProgramDaysLeft:int;

    public var currentLoyalityProgramDay:int;

    public var boughtTroopKitIds:ArrayCustom;

    public var boughtResourceKitIds:ArrayCustom;

    public var specialOffers:ArrayCustom;

    public var kitsDirty:Boolean = false;

    public var specialOffersDirty:Boolean = false;

    public var lastReturnDate:Date;

    public var inviterUserId:String;

    public var penultimateActivityTime:Date;

    public var lastLevelUpTime:Date;

    public var playedDays:Number;

    public var wallpostsCount:int;

    public var wallpostsLastTime:Date;

    public var nppNextPresentationTime:Date;

    public var isVip:Boolean = false;

    private var isVipPre:Boolean = false;

    public function UserCommonData() {
        super();
    }

    public static function fromDto(param1:*):UserCommonData {
        var _loc2_:UserCommonData = new UserCommonData();
        _loc2_.registrationTime = new Date(param1.r);
        _loc2_.lastVisitTime = new Date(param1.v);
        _loc2_.lastVisitTimePrev = new Date(param1.v2);
        _loc2_.loyaltyProgramDaysLeft = param1.l;
        _loc2_.currentLoyalityProgramDay = param1.lp;
        _loc2_.boughtTroopKitIds = param1.t == null ? new ArrayCustom() : new ArrayCustom(param1.t);
        _loc2_.boughtResourceKitIds = param1.y == null ? new ArrayCustom() : new ArrayCustom(param1.y);
        _loc2_.specialOffers = param1.o == null ? new ArrayCustom() : SpecialOffer.fromDtos(param1.o);
        _loc2_.playedDays = param1.d;
        _loc2_.wallpostsCount = param1.w == null ? 0 : int(param1.w);
        _loc2_.wallpostsLastTime = param1.x == null ? null : new Date(param1.x);
        _loc2_.nppNextPresentationTime = param1.nn == null ? null : new Date(param1.nn);
        _loc2_.lastReturnDate = !!param1.lr2 ? new Date(param1.lr2) : null;
        _loc2_.inviterUserId = !!param1.i ? param1.i : "";
        _loc2_.isVip = param1.vp;
        _loc2_.penultimateActivityTime = param1.pu == null ? null : new Date(param1.pu);
        _loc2_.lastLevelUpTime = param1.u == null ? null : new Date(param1.u);
        return _loc2_;
    }

    public function canBuyResourceKits(param1:int):Boolean {
        var _loc2_:ResourcesKitLimit = StaticDataManager.getResourcesKitLimit(param1);
        return this.boughtResourceKitIds.length < _loc2_.maxKitsBoughtPerDay;
    }

    public function getNextEvent(param1:User, param2:Date):INEvent {
        var _loc3_:Date = new Date(DateUtil.getDatePart(param1.gameData.normalizationTime).time + 1000 * 60 * 60 * 24);
        return param1.gameData.normalizationTime.time < _loc3_.time && _loc3_.time <= param2.time ? new NEventUser(_loc3_) : null;
    }

    public function dispatchEvents():void {
        if (this.kitsDirty) {
            this.kitsDirty = false;
            dispatchEvent(KITS_CHANGED);
        }
        if (this.specialOffersDirty) {
            this.specialOffersDirty = false;
            dispatchEvent(SPECIAL_OFFERS_CHANGED);
        }
        if (this.isVipPre != this.isVip) {
            this.isVipPre = this.isVip;
            dispatchEvent(VIP_STATUS);
        }
    }
}
}
