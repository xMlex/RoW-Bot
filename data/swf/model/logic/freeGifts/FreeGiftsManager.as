package model.logic.freeGifts {
import common.ArrayCustom;
import common.localization.LocaleUtil;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.Dictionary;

import integration.SocialNetworkIdentifier;
import integration.facebook.FacebookGlobalAuthService;
import integration.facebook.v2.Api;

import model.data.Resources;
import model.data.freeGifts.FreeGift;
import model.data.freeGifts.FreeGiftsInfo;
import model.data.users.UserAccount;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.freeGifts.commands.AcceptFreeGiftsCmd;
import model.logic.freeGifts.commands.GetFreeGiftsRecipientsTodayCmd;
import model.logic.freeGifts.commands.SendFreeGiftsCmd;

public class FreeGiftsManager {

    public static const SENT_GIFT_TO_FRIEND_EVENT:String = "sentGiftToFriendEvent";

    public static const FbGiftId:String = "resGift";

    public static const FbOgGiftId:String = SocialNetworkIdentifier.socialService.freeGiftObjectId;

    public static const MaxAcceptPerDay:int = 10;

    public static const FbMaxRecipientsPerRequest:int = 50;

    public static var acceptedToday:int = 0;

    public static var availableGifts:ArrayCustom;

    public static var sendGifts:ArrayCustom;

    public static var baseProdRate:Resources;

    public static var sentToIdsToday:Array;

    private static var _idsToRemoveManually:Array;

    private static var _api:Api;

    private static var _events:EventDispatcher = new EventDispatcher();


    public function FreeGiftsManager() {
        super();
    }

    public static function get events():EventDispatcher {
        return _events;
    }

    public static function initialize(param1:FreeGiftsInfo):void {
        if (param1 == null) {
            return;
        }
        acceptedToday = param1.acceptedToday;
        availableGifts = new ArrayCustom(param1.gifts.reverse());
        sendGifts = new ArrayCustom();
        baseProdRate = param1.prodRate;
        sentToIdsToday = param1.sentToIdsToday;
    }

    public static function get canAcceptToday():int {
        return MaxAcceptPerDay - acceptedToday;
    }

    public static function acceptRequests(param1:Array, param2:Function):void {
        var ids:Array = param1;
        var callback:Function = param2;
        new AcceptFreeGiftsCmd(ids, SocialNetworkIdentifier.socialService.authKey).ifResult(function (param1:Array, param2:Boolean):void {
            removeAcceptedRequests(param1);
            UserManager.user.gameData.statsData.giftsDirty = true;
            UserManager.user.gameData.statsData.dispatchEvents();
            if (callback != null) {
                callback(param1);
            }
            if (param2) {
                FreeGiftsManager.removeFbRequests(param1);
            }
        }).execute();
    }

    private static function removeAcceptedRequests(param1:Array):void {
        var _loc3_:String = null;
        var _loc4_:FreeGift = null;
        var _loc2_:int = 0;
        while (_loc2_ < param1.length) {
            _loc3_ = param1[_loc2_];
            _loc4_ = getGiftByRequestId(_loc3_);
            if (_loc4_ != null) {
                availableGifts.removeItemAt(availableGifts.getItemIndex(_loc4_));
                sendGifts.push(_loc4_);
            }
            acceptedToday++;
            _loc2_++;
        }
    }

    private static function getGiftByRequestId(param1:String):FreeGift {
        var _loc2_:FreeGift = null;
        for each(_loc2_ in availableGifts) {
            if (_loc2_.requestId == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public static function send(param1:Array, param2:Function, param3:Boolean):void {
        var title:String = null;
        var message:String = null;
        var socialIds:Array = null;
        var facebookIds:Array = null;
        var i:int = 0;
        var eligibleRecipients:Array = null;
        var j:int = 0;
        var giftType:String = null;
        var receivers:Array = param1;
        var callback:Function = param2;
        var acceptAndSendBack:Boolean = param3;
        title = LocaleUtil.getText("integration_requestfb_free_gifts header");
        message = LocaleUtil.getText("integrationrequestfb_free_gifts");
        if (SocialNetworkIdentifier.socialService is FacebookGlobalAuthService) {
            socialIds = [];
            facebookIds = [];
            i = 0;
            while (i < receivers.length) {
                if ("fb" == receivers[i].slice(0, 2)) {
                    facebookIds.push(receivers[i].slice(2));
                }
                else if ("um" == receivers[i].slice(0, 2)) {
                    socialIds.push(receivers[i]);
                }
                else {
                    facebookIds.push(receivers[i]);
                }
                i++;
            }
            if (!socialIds.length && !facebookIds.length) {
                return;
            }
            if (facebookIds.length) {
                SocialNetworkIdentifier.socialService.getUnityIdsList(facebookIds, function (param1:Dictionary):void {
                    SendRequestToAuthUsers(param1, socialIds, title, message, acceptAndSendBack, callback);
                });
            }
            else {
                SendRequestToAuthUsers(new Dictionary(), socialIds, title, message, acceptAndSendBack, callback);
            }
        }
        else {
            eligibleRecipients = [];
            j = 0;
            while (j < receivers.length) {
                if (sentToIdsToday.indexOf(receivers[j]) <= -1) {
                    if ("fb" == receivers[j].slice(0, 2)) {
                        receivers[j] = receivers[j].slice(2);
                    }
                    eligibleRecipients.push(receivers[j]);
                }
                j++;
            }
            if (!eligibleRecipients.length) {
                return;
            }
            if (eligibleRecipients.length > FbMaxRecipientsPerRequest) {
                eligibleRecipients = eligibleRecipients.slice(0, FbMaxRecipientsPerRequest);
            }
            giftType = generateGiftId();
            SocialNetworkIdentifier.socialService.sendRequest(eligibleRecipients, title, message, function (param1:Object):void {
                var response:Object = param1;
                var recipients:Array = [];
                if (response && response.hasOwnProperty("to")) {
                    recipients = SocialNetworkIdentifier.socialService.prefixSocialIds(response.to);
                }
                _sendFreeGiftsToGameServer(recipients, acceptAndSendBack, response.request, function ():void {
                    if (callback != null && response.request) {
                        callback();
                    }
                });
            }, FbOgGiftId, giftType, UserManager.user.id);
        }
    }

    protected static function _sendFreeGiftsToGameServer(param1:Array, param2:Boolean, param3:String, param4:Function = null):void {
        var userIds:Array = param1;
        var isSendBack:Boolean = param2;
        var baseRequestId:String = param3;
        var callback:Function = param4;
        if (!userIds || !userIds.length) {
            return;
        }
        new SendFreeGiftsCmd(userIds, isSendBack, baseRequestId).ifResult(function (param1:Array):void {
            var _loc2_:* = undefined;
            if (param1 && param1.length) {
                _loc2_ = 0;
                while (_loc2_ < param1.length) {
                    sentToIdsToday.push(param1[_loc2_]);
                    _loc2_++;
                }
            }
            UserManager.user.gameData.statsData.giftsDirty = true;
            UserManager.user.gameData.statsData.dispatchEvents();
            if (callback != null) {
                callback();
            }
        }).execute();
    }

    public static function checkIfEnoughStorage(param1:Array):Resources {
        var _loc8_:String = null;
        var _loc9_:int = 0;
        var _loc10_:Resources = null;
        var _loc11_:int = 0;
        var _loc12_:int = 0;
        var _loc13_:int = 0;
        var _loc14_:int = 0;
        var _loc2_:Resources = new Resources();
        var _loc3_:UserAccount = UserManager.user.gameData.account;
        var _loc4_:int = 0;
        while (_loc4_ < param1.length) {
            _loc8_ = param1[_loc4_];
            _loc9_ = 0;
            while (_loc9_ < availableGifts.length) {
                if (availableGifts[_loc9_].requestId == _loc8_) {
                    _loc10_ = availableGifts[_loc9_].resources;
                    _loc2_.uranium = _loc2_.uranium + _loc10_.uranium;
                    _loc2_.titanite = _loc2_.titanite + _loc10_.titanite;
                    _loc2_.money = _loc2_.money + _loc10_.money;
                    break;
                }
                _loc9_++;
            }
            _loc4_++;
        }
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        var _loc7_:int = 0;
        if (_loc2_.uranium > 0) {
            _loc11_ = _loc3_.resources.uranium + _loc2_.uranium;
            if (_loc11_ > _loc3_.resourcesLimit.uranium) {
                _loc5_ = int(Math.abs(_loc3_.resourcesLimit.uranium - _loc11_));
            }
        }
        if (_loc2_.titanite > 0) {
            _loc12_ = _loc3_.resources.titanite + _loc2_.titanite;
            if (_loc12_ > _loc3_.resourcesLimit.titanite) {
                _loc6_ = int(Math.abs(_loc3_.resourcesLimit.titanite - _loc12_));
            }
        }
        if (_loc2_.money > 0) {
            _loc13_ = _loc3_.resources.money + _loc2_.money;
            _loc14_ = Math.ceil(Math.abs(_loc3_.resourcesLimit.money - _loc13_));
            if (_loc13_ > _loc3_.resourcesLimit.money && _loc14_ > 0) {
                _loc7_ = Math.ceil(Math.abs(_loc3_.resourcesLimit.money - _loc13_));
            }
        }
        return new Resources(0, _loc7_, _loc5_, _loc6_);
    }

    public static function getMostRecentRecipientsList(param1:Function):void {
        var completeCallback:Function = param1;
        new GetFreeGiftsRecipientsTodayCmd(UserManager.user.id).ifResult(function (param1:Object):void {
            var res:Object = param1;
            var r:* = [];
            try {
                r = res as Array;
                sentToIdsToday = r;
            }
            catch (e:Error) {
            }
            if (completeCallback != null) {
                completeCallback(r);
            }
        }).execute();
    }

    public static function checkDailyResourcesLimitExceeded(param1:Array):Resources {
        var _loc7_:Number = NaN;
        var _loc8_:Number = NaN;
        var _loc9_:Number = NaN;
        var _loc10_:Resources = null;
        var _loc11_:String = null;
        var _loc12_:Resources = null;
        var _loc2_:Boolean = (SocialNetworkIdentifier.isFB || SocialNetworkIdentifier.isVK) && StaticDataManager.DailyIncomingResourcesLimit != null;
        if (!_loc2_) {
            return null;
        }
        var _loc3_:Number = StaticDataManager.DailyIncomingResourcesLimit.uranium;
        var _loc4_:Number = StaticDataManager.DailyIncomingResourcesLimit.titanite;
        var _loc5_:Number = StaticDataManager.DailyIncomingResourcesLimit.money;
        if (_loc3_ <= 0 || _loc4_ <= 0 || _loc5_ <= 0) {
            return null;
        }
        var _loc6_:Resources = UserManager.user.gameData.worldData.incomingResourcesToday;
        if (_loc6_ == null) {
            return null;
        }
        for each(_loc11_ in param1) {
            _loc10_ = getGiftResourcesByRequestId(_loc11_);
            if (_loc10_ != null) {
                _loc7_ = _loc10_.money + _loc6_.money;
                _loc8_ = _loc10_.uranium + _loc6_.uranium;
                _loc9_ = _loc10_.titanite + _loc6_.titanite;
            }
        }
        _loc12_ = new Resources(0, _loc7_ > _loc5_ ? Number(_loc7_) : Number(0), _loc8_ > _loc3_ ? Number(_loc8_) : Number(0), _loc9_ > _loc4_ ? Number(_loc9_) : Number(0));
        return _loc12_.capacity() > 0 ? _loc12_ : null;
    }

    private static function getGiftResourcesByRequestId(param1:String):Resources {
        var _loc3_:FreeGift = null;
        var _loc2_:int = 0;
        while (_loc2_ < availableGifts.length) {
            _loc3_ = availableGifts[_loc2_];
            if (_loc3_.requestId == param1) {
                return _loc3_.resources;
            }
            _loc2_++;
        }
        return null;
    }

    private static function removeFbRequests(param1:Array):void {
        _idsToRemoveManually = param1;
        doRemove();
    }

    private static function doRemove():void {
        if (!_idsToRemoveManually || !_idsToRemoveManually) {
            return;
        }
        if (!_api) {
            _api = new Api();
        }
        var endpointUri:String = 1 < _idsToRemoveManually.length ? "/?ids=" + _idsToRemoveManually.join(",") : "/" + _idsToRemoveManually[0];
        _api.call(endpointUri, "DELETE", null, function (param1:Object = null):void {
            _idsToRemoveManually = [];
        });
    }

    private static function generateGiftId():String {
        return FbGiftId + "_" + SocialNetworkIdentifier.socialService.userIdPrefix + SocialNetworkIdentifier.socialService.userId + "_" + SocialNetworkIdentifier.socialNetworkConfig.currentClusterId;
    }

    private static function getFacebookIdFromSendGifts(param1:String):String {
        var _loc2_:int = 0;
        while (_loc2_ < sendGifts.length) {
            if (sendGifts[_loc2_].fromSocialId == param1 && sendGifts[_loc2_].fromFacebookId) {
                return sendGifts[_loc2_].fromFacebookId;
            }
            _loc2_++;
        }
        return null;
    }

    private static function SendRequestToAuthUsers(param1:Dictionary, param2:Array, param3:String, param4:String, param5:Boolean, param6:Function):void {
        var key:Object = null;
        var i:int = 0;
        var umId:String = null;
        var fbId:String = null;
        var fbAndUmMapping:Dictionary = param1;
        var socialIds:Array = param2;
        var title:String = param3;
        var message:String = param4;
        var acceptAndSendBack:Boolean = param5;
        var callback:Function = param6;
        var eligibleRecipientsFacebookIds:Array = [];
        for (key in fbAndUmMapping) {
            umId = SocialNetworkIdentifier.socialService.addSocialNetworkPrefix(fbAndUmMapping[key]);
            if (sentToIdsToday.indexOf(umId) == -1) {
                eligibleRecipientsFacebookIds.push(key);
            }
        }
        i = 0;
        while (i < socialIds.length) {
            if (sentToIdsToday.indexOf(socialIds[i]) == -1) {
                fbId = getFacebookIdFromSendGifts(socialIds[i]);
                if (fbId && eligibleRecipientsFacebookIds.indexOf(fbId) == -1) {
                    eligibleRecipientsFacebookIds.push(fbId);
                    if (fbAndUmMapping[fbId] == null) {
                        fbAndUmMapping[fbId] = socialIds[i];
                    }
                }
            }
            i++;
        }
        if (!eligibleRecipientsFacebookIds.length) {
            return;
        }
        if (eligibleRecipientsFacebookIds.length > FbMaxRecipientsPerRequest) {
            eligibleRecipientsFacebookIds = eligibleRecipientsFacebookIds.slice(0, FbMaxRecipientsPerRequest);
        }
        var giftType:String = generateGiftId();
        SocialNetworkIdentifier.socialService.sendRequest(eligibleRecipientsFacebookIds, title, message, function (param1:Object):void {
            var i:int = 0;
            var response:Object = param1;
            var recipients:Array = [];
            if (response && response.hasOwnProperty("to")) {
                i = 0;
                while (i < response.to.length) {
                    umId = SocialNetworkIdentifier.socialService.addSocialNetworkPrefix(fbAndUmMapping[response.to[i]]);
                    recipients.push(umId);
                    i++;
                }
                _events.dispatchEvent(new Event(FreeGiftsManager.SENT_GIFT_TO_FRIEND_EVENT));
            }
            sendGifts.removeAll();
            _sendFreeGiftsToGameServer(recipients, acceptAndSendBack, response.request, function ():void {
                if (callback != null && response.request) {
                    callback();
                }
            });
        }, FbOgGiftId, giftType, UserManager.user.id);
    }
}
}
