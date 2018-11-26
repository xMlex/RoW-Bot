package model.data.promotionOffers {
import common.queries.util.query;

import flash.events.Event;

import model.data.DiscountPricePackManager;
import model.data.temporarySkins.TemporarySkinBox;
import model.logic.ServerTimeManager;
import model.logic.UserManager;
import model.logic.commands.promotionOffers.GetPromotionContentInfoCmd;
import model.logic.commands.promotionOffers.GetPromotionPricesCmd;

public class PromotionOfferManager {

    {
        subscribe();
        promotionsPricesUpdate();
        promotionsContentUpdate();
    }

    public function PromotionOfferManager() {
        super();
    }

    public static function get promotionOfferData():UserPromotionOfferData {
        return UserManager.user.gameData.promotionOfferData;
    }

    public static function getPromotionByOfferId(param1:int):UserPromotionOffer {
        return promotionOfferData.getPromotionOfferByOfferId(param1);
    }

    public static function getFirstPromotionByType(param1:int):UserPromotionOffer {
        var result:UserPromotionOffer = null;
        var offerTypeId:int = param1;
        promotionOfferData.every(function (param1:UserPromotionOffer, param2:int, param3:Vector.<UserPromotionOffer>):Boolean {
            if (param1.typeId == offerTypeId) {
                result = param1;
            }
            return result == null;
        });
        return result;
    }

    public static function getActivePromotionByPackageId(param1:int):UserPromotionOffer {
        var result:UserPromotionOffer = null;
        var packageId:int = param1;
        if (packageId <= 0) {
            return result;
        }
        promotionOfferData.every(function (param1:UserPromotionOffer, param2:int, param3:Vector.<UserPromotionOffer>):Boolean {
            if (param1.packageId == packageId && param1.isActive) {
                result = param1;
            }
            return result == null;
        });
        return result;
    }

    public static function hasActivePromotion():Boolean {
        var result:Boolean = false;
        promotionOfferData.every(function (param1:UserPromotionOffer, param2:int, param3:Vector.<UserPromotionOffer>):Boolean {
            if (param1.isActive) {
                result = true;
            }
            return !result;
        });
        return result;
    }

    public static function getFirstNewAvailablePromotionByType(param1:int):UserPromotionOffer {
        var result:UserPromotionOffer = null;
        var type:int = param1;
        promotionOfferData.every(function (param1:UserPromotionOffer, param2:int, param3:Vector.<UserPromotionOffer>):Boolean {
            if (param1.typeId == type && param1.isNew && !param1.isHidden()) {
                result = param1;
            }
            return result == null;
        });
        return result;
    }

    public static function getFirstNewDelayedTrigger():UserPromotionOffer {
        if (promotionOfferData.hiddenPromotionOffers == null || promotionOfferData.hiddenPromotionOffers.length == 0) {
            return null;
        }
        var result:UserPromotionOffer = query(promotionOfferData.hiddenPromotionOffers).firstOrDefault(function (param1:UserPromotionOffer):Boolean {
            return param1.isHidden() && !param1.isInvalid();
        });
        return result;
    }

    public static function getValidPromotions():Vector.<UserPromotionOffer> {
        var result:Vector.<UserPromotionOffer> = null;
        result = new Vector.<UserPromotionOffer>();
        promotionOfferData.forEach(function (param1:UserPromotionOffer, param2:int, param3:Vector.<UserPromotionOffer>):void {
            if (param1.isActive) {
                result.push(param1);
            }
        });
        return result;
    }

    public static function getFirstBoughtPromotion():UserPromotionOffer {
        var result:UserPromotionOffer = null;
        promotionOfferData.every(function (param1:UserPromotionOffer, param2:int, param3:Vector.<UserPromotionOffer>):Boolean {
            if (param1.showPurchaseDetails) {
                result = param1;
            }
            return result == null;
        });
        return result;
    }

    public static function retentionPacksWithReward():Array {
        var _loc1_:Array = boughtRetentionPacks();
        return query(_loc1_).where(hasUntakenReward).select(offerSelector).toArray();
    }

    public static function boughtRetentionPacks():Array {
        var boughtPacks:Array = null;
        boughtPacks = [];
        promotionOfferData.forEach(function (param1:UserPromotionOffer, param2:int, param3:Vector.<UserPromotionOffer>):void {
            if (param1.isBought && param1.retentionData != null && !param1.retentionData.prizeMerged) {
                boughtPacks.push(param1);
            }
        });
        return boughtPacks;
    }

    public static function hasUntakenReward(param1:UserPromotionOffer):Boolean {
        var _loc2_:Array = param1.retentionData.prizeReceivedDates;
        if (_loc2_ == null || _loc2_.length == 0) {
            return true;
        }
        return !ServerTimeManager.isToday(_loc2_[_loc2_.length - 1]);
    }

    private static function offerSelector(param1:UserPromotionOffer):UserPromotionOffer {
        return param1;
    }

    public static function firstPromotionToExpire():UserPromotionOffer {
        var result:UserPromotionOffer = null;
        promotionOfferData.forEach(function (param1:UserPromotionOffer, param2:int, param3:Vector.<UserPromotionOffer>):void {
            if (result == null && param1.isActive || param1.isActive && compareValidTills(param1.validTill, result.validTill)) {
                result = param1;
            }
        });
        return result;
    }

    public static function firstPromotionToExpireWithItem(param1:int):UserPromotionOffer {
        var result:UserPromotionOffer = null;
        var prize:UnitedPrize = null;
        var hasItem:Boolean = false;
        var itemId:int = param1;
        promotionOfferData.forEach(function (param1:UserPromotionOffer, param2:int, param3:Vector.<UserPromotionOffer>):void {
            prize = param1.prize;
            hasItem = prize != null && prize.hasBMI(itemId);
            if (result == null && hasItem && param1.isActive || hasItem && param1.isActive && compareValidTills(param1.validTill, result.validTill)) {
                result = param1;
            }
        });
        return result;
    }

    public static function hasAnyAvailablePromotionWithItem(param1:int):Boolean {
        var _loc2_:UserPromotionOffer = null;
        for each(_loc2_ in promotionOfferData.availablePromotionOffers) {
            if (_loc2_.isActive && _loc2_.prize != null && _loc2_.prize.hasBMI(param1)) {
                return true;
            }
        }
        return false;
    }

    public static function getFirstPromotionToExpireWithTemporarySkin(param1:int, param2:int):UserPromotionOffer {
        var result:UserPromotionOffer = null;
        var prize:UnitedPrize = null;
        var hasNeededTemplate:Boolean = false;
        var primaryTemporarySkins:Array = null;
        var secondaryTemporarySkins:Array = null;
        var temporarySkins:Array = null;
        var skinsLength:int = 0;
        var skinTypeId:int = param1;
        var skinTemplateId:int = param2;
        promotionOfferData.forEach(function (param1:UserPromotionOffer, param2:int, param3:Vector.<UserPromotionOffer>):void {
            var _loc4_:int = 0;
            if (result != null && !compareValidTills(param1.validTill, result.validTill) || !param1.isActive) {
                return;
            }
            prize = param1.prize;
            if (prize != null) {
                primaryTemporarySkins = prize.primaryPrize == null ? null : prize.primaryPrize.getAllTemporarySkins();
                secondaryTemporarySkins = prize.secondaryPrize == null ? null : prize.secondaryPrize.getAllTemporarySkins();
                temporarySkins = [];
                if (primaryTemporarySkins == null && secondaryTemporarySkins != null) {
                    temporarySkins = secondaryTemporarySkins;
                }
                else if (secondaryTemporarySkins == null && primaryTemporarySkins != null) {
                    temporarySkins = primaryTemporarySkins;
                }
                else if (primaryTemporarySkins != null && secondaryTemporarySkins != null) {
                    temporarySkins = temporarySkins.concat(primaryTemporarySkins, secondaryTemporarySkins);
                }
                skinsLength = temporarySkins.length;
                _loc4_ = 0;
                while (_loc4_ < skinsLength) {
                    hasNeededTemplate = skinTemplateId < 0 || skinTemplateId == temporarySkins[_loc4_].skinTemplateId;
                    if (temporarySkins[_loc4_].skinTypeId == skinTypeId && hasNeededTemplate) {
                        if (result == null || compareValidTills(param1.validTill, result.validTill)) {
                            result = param1;
                        }
                    }
                    _loc4_++;
                }
            }
        });
        return result;
    }

    public static function getPromotionTemporarySkinBoxes():Object {
        var promotionTempSkinsBoxes:Object = null;
        var prize:UnitedPrize = null;
        var primaryTemporarySkins:Array = null;
        var secondaryTemporarySkins:Array = null;
        var temporarySkins:Array = null;
        promotionTempSkinsBoxes = {};
        promotionOfferData.forEach(function (param1:UserPromotionOffer, param2:int, param3:Vector.<UserPromotionOffer>):void {
            var _loc4_:int = 0;
            var _loc5_:int = 0;
            if (!param1.isActive) {
                return;
            }
            if (param1.typeId == PromotionOfferTypeId.RETENTION_PACK) {
                param1.calculatePrizeFromList();
            }
            prize = param1.prize;
            if (prize != null) {
                primaryTemporarySkins = prize.primaryPrize == null ? null : prize.primaryPrize.getAllTemporarySkins();
                secondaryTemporarySkins = prize.secondaryPrize == null ? null : prize.secondaryPrize.getAllTemporarySkins();
                temporarySkins = [];
                if (primaryTemporarySkins == null && secondaryTemporarySkins != null) {
                    temporarySkins = secondaryTemporarySkins;
                }
                else if (secondaryTemporarySkins == null && primaryTemporarySkins != null) {
                    temporarySkins = primaryTemporarySkins;
                }
                else if (primaryTemporarySkins != null && secondaryTemporarySkins != null) {
                    temporarySkins = temporarySkins.concat(primaryTemporarySkins, secondaryTemporarySkins);
                }
                _loc4_ = temporarySkins.length;
                _loc5_ = 0;
                while (_loc5_ < _loc4_) {
                    if (promotionTempSkinsBoxes[temporarySkins[_loc5_].skinTemplateId] == null) {
                        promotionTempSkinsBoxes[temporarySkins[_loc5_].skinTemplateId] = new TemporarySkinBox();
                        promotionTempSkinsBoxes[temporarySkins[_loc5_].skinTemplateId].count = 0;
                        promotionTempSkinsBoxes[temporarySkins[_loc5_].skinTemplateId].skin = temporarySkins[_loc5_];
                    }
                    promotionTempSkinsBoxes[temporarySkins[_loc5_].skinTemplateId].count++;
                    _loc5_++;
                }
            }
        });
        return promotionTempSkinsBoxes;
    }

    public static function compareValidTills(param1:Date, param2:Date):Boolean {
        var _loc3_:* = false;
        if (param1 == null && param2 == null) {
            _loc3_ = false;
        }
        else if (param1 == null && param2 != null) {
            _loc3_ = false;
        }
        else if (param1 != null && param2 == null) {
            _loc3_ = true;
        }
        else {
            _loc3_ = param1 < param2;
        }
        return _loc3_;
    }

    private static function subscribe():void {
        promotionOfferData.addEventHandler(UserPromotionOfferData.PROMOTION_ADDED, promotionAdded_eventHandler);
    }

    private static function promotionsPricesUpdate():void {
        promotionOfferData.every(function (param1:UserPromotionOffer, param2:int, param3:Vector.<UserPromotionOffer>):Boolean {
            var _loc4_:Boolean = true;
            var _loc5_:Boolean = param1.isActive || param1.showPurchaseDetails;
            if (_loc5_ && !DiscountPricePackManager.hasPricePack(param1.priceId)) {
                new GetPromotionPricesCmd().execute();
                _loc4_ = false;
            }
            return _loc4_;
        });
    }

    private static function promotionsContentUpdate():void {
        var localizationIds:Array = null;
        var imagesIds:Array = null;
        localizationIds = [];
        imagesIds = [];
        promotionOfferData.forEach(function (param1:UserPromotionOffer, param2:int, param3:Vector.<UserPromotionOffer>):void {
            var _loc4_:Boolean = param1.isActive || param1.showPurchaseDetails;
            if (_loc4_) {
                if (!PromotionContentManager.hasLocalizationById(param1.settings.titleId) && localizationIds.indexOf(param1.settings.titleId) == -1) {
                    localizationIds.push(param1.settings.titleId);
                }
                if (!PromotionContentManager.hasLocalizationById(param1.settings.ctaId) && localizationIds.indexOf(param1.settings.ctaId) == -1) {
                    localizationIds.push(param1.settings.ctaId);
                }
                if (!PromotionContentManager.hasImageUrlById(param1.settings.imageId) && imagesIds.indexOf(param1.settings.imageId) == -1) {
                    imagesIds.push(param1.settings.imageId);
                }
            }
        });
        if (localizationIds.length > 0 || imagesIds.length > 0) {
            new GetPromotionContentInfoCmd(localizationIds, imagesIds).execute();
        }
    }

    private static function promotionAdded_eventHandler(param1:Event):void {
        promotionsPricesUpdate();
        promotionsContentUpdate();
    }
}
}
