package model.data {
import common.ArrayCustom;
import common.StringUtil;

import integration.LoadedGameData;
import integration.SocialUser;

import model.data.users.UserNote;
import model.logic.ServerManager;
import model.logic.UserDemoManager;

public class UserSocialData {

    public static var downloadedGameData:LoadedGameData;

    private static var _prefix:String = "";


    private var _photoUrl:String;

    public var socialId:String;

    public var profileUrl:String = "";

    public var fullName:String;

    public var sex:String;

    public var locale:String;

    public var email:String;

    public var isApproved:Boolean;

    public var portal_fb_uid:String;

    public var advReferrer:String;

    public var hashedId:String;

    public var appPermissions:Array;

    public var ageRange:Array = null;

    public var userType:int;

    public var customData:String;

    public var mailruMinigameUserId:String;

    public var portal_global_id:Number;

    public var portal_social_name:String;

    public var portal_email:String;

    public var portal_birth_date:String;

    public var portal_fb_bi:Object = null;

    public var vkShowInMenuStatus:Boolean = false;

    public var paymentTestGroup:int;

    public var isLiked:Boolean = false;

    public var giftRequests:Array;

    public var giftEntrance:Boolean = false;

    public var pageParams:String;

    public var nppAvailable:Boolean = false;

    public var businessIds:Object = null;

    public var purchaseHistoryDetails:Object = null;

    public var facebookUserId:String = null;

    public var incognitoMode:Boolean;

    public var devicesList:Array = null;

    public var thirdPartyId:String = null;

    public function UserSocialData() {
        super();
    }

    public static function fromSocialUser(param1:SocialUser):UserSocialData {
        var _loc2_:UserSocialData = new UserSocialData();
        if (param1 != null) {
            _loc2_.socialId = buildSocialId(param1.uid);
            _loc2_.profileUrl = param1.profile_url;
            _loc2_.fullName = param1.name != "" ? param1.name : param1.first_name + " " + param1.last_name;
            _loc2_.fullName = StringUtil.replaceSpecExpressions(_loc2_.fullName);
            if (param1.pic && param1.pic.length > 0) {
                if (param1.pic.indexOf("question") != -1) {
                    _loc2_._photoUrl = ServerManager.buildContentUrl("ui/question_a.gif");
                }
                else if (param1.pic.indexOf("camera") != -1) {
                    _loc2_._photoUrl = ServerManager.buildContentUrl("ui/camera_a.gif");
                }
                else {
                    _loc2_._photoUrl = param1.pic;
                }
            }
            _loc2_.sex = param1.sex;
            _loc2_.locale = normalizeLocale(param1.locale);
            _loc2_.isApproved = param1.isApproved;
            _loc2_.customData = param1.socialNetworkData;
            if (param1.portal_fb_uid && param1.portal_fb_uid.length > 0) {
                _loc2_.portal_fb_uid = param1.portal_fb_uid;
            }
            if (param1.email && param1.email.length > 0) {
                _loc2_.email = param1.email;
            }
            if (param1.advReferrer && param1.advReferrer.length > 0) {
                _loc2_.advReferrer = param1.advReferrer;
            }
            if (param1.hashedId && param1.hashedId.length > 0) {
                _loc2_.hashedId = buildSocialId(param1.hashedId);
            }
            if (param1.appPermissions != null) {
                _loc2_.appPermissions = param1.appPermissions;
            }
            if (param1.ageRange) {
                _loc2_.ageRange = param1.ageRange;
            }
            _loc2_.userType = !!param1.isAnonymousUser ? int(UserRegType.ANONYMOUS) : int(param1.realStartNowUser);
            _loc2_.paymentTestGroup = param1.paymentTestGroup;
            _loc2_.nppAvailable = param1.nppAvailable;
            if (param1.giftRequests != null) {
                _loc2_.giftRequests = param1.giftRequests;
            }
            if (param1.giftEntrance) {
                _loc2_.giftEntrance = param1.giftEntrance;
                _loc2_.pageParams = param1.pageParams;
            }
            _loc2_.mailruMinigameUserId = param1.mailruMinigameUserId != null && param1.mailruMinigameUserId != "" ? param1.mailruMinigameUserId : "";
            if (param1.businessIds != null) {
                _loc2_.businessIds = param1.businessIds;
            }
            if (param1.purchaseHistoryDetails != null) {
                _loc2_.purchaseHistoryDetails = param1.purchaseHistoryDetails;
            }
            if (param1.portal_global_id) {
                _loc2_.portal_global_id = param1.portal_global_id;
            }
            if (param1.portal_social_name) {
                _loc2_.portal_social_name = param1.portal_social_name;
            }
            if (param1.portal_email) {
                _loc2_.portal_email = param1.portal_email;
            }
            if (param1.portal_birth_date) {
                _loc2_.portal_birth_date = param1.portal_birth_date;
            }
            if (param1.portal_fb_bi) {
                _loc2_.portal_fb_bi = param1.portal_fb_bi;
            }
            if (param1.facebookUserId) {
                _loc2_.facebookUserId = param1.facebookUserId;
            }
            _loc2_.incognitoMode = param1.incognitoMode;
            _loc2_.devicesList = param1.devices;
            _loc2_.thirdPartyId = param1.thirdPartyId;
        }
        return _loc2_;
    }

    public static function fromSocialUsers(param1:Array):ArrayCustom {
        var _loc3_:SocialUser = null;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromSocialUser(_loc3_));
        }
        return _loc2_;
    }

    public static function normalizeLocale(param1:String):String {
        if (param1 == null) {
            return null;
        }
        return param1.replace("_", "-");
    }

    public static function initSNPrefix(param1:String):void {
        _prefix = param1;
    }

    public static function buildSocialId(param1:String):String {
        if (param1 == null || param1 == "") {
            return "";
        }
        return _prefix + param1;
    }

    public static function buildSocialIds(param1:Array):ArrayCustom {
        var _loc3_:String = null;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(buildSocialId(_loc3_));
        }
        return _loc2_;
    }

    public static function fromDto(param1:*):UserSocialData {
        var _loc2_:UserSocialData = new UserSocialData();
        _loc2_.socialId = param1.i;
        _loc2_.profileUrl = !!param1.s ? param1.s : "";
        _loc2_.fullName = param1.n == null ? "0" : StringUtil.replaceSpecExpressions(param1.n);
        if (param1.u == null) {
            _loc2_._photoUrl = "";
        }
        else {
            _loc2_._photoUrl = UserNote.fixFbPhotoUrl(param1.u);
        }
        if (_loc2_._photoUrl.indexOf("question") != -1) {
            _loc2_._photoUrl = ServerManager.buildContentUrl("ui/question_a.gif");
        }
        _loc2_.sex = param1.x;
        _loc2_.locale = param1.l;
        _loc2_.customData = param1.d;
        _loc2_.hashedId = param1.h;
        _loc2_.appPermissions = param1.p;
        _loc2_.ageRange = param1.ar;
        _loc2_.nppAvailable = param1.np;
        if (param1.m) {
            _loc2_.email = param1.m;
        }
        if (param1.tg) {
            _loc2_.paymentTestGroup = param1.tg;
        }
        if (param1.fl) {
            _loc2_.isLiked = param1.fl;
        }
        _loc2_.incognitoMode = param1.im;
        return _loc2_;
    }

    private static function processGistRequests(param1:Array):Array {
        var i:int = 0;
        var o:Object = null;
        var elements:Array = null;
        var pushObject:Object = null;
        var gr:Array = param1;
        if (gr == null) {
            return null;
        }
        var res:Array = [];
        try {
            i = 0;
            while (i < gr.length) {
                o = gr[i];
                elements = o.data.split("_");
                pushObject = {
                    "f": o.from.uid,
                    "r": o.requestId,
                    "d": o.createdTimeRaw
                };
                if (elements.length > 1) {
                    pushObject.s = elements[1];
                }
                res.push(pushObject);
                i++;
            }
        }
        catch (e:Error) {
        }
        return res;
    }

    public function get socialIdOrHash():String {
        if (this.socialId) {
            return this.socialId;
        }
        return this.hashedId.substring(2);
    }

    public function set photoUrl(param1:Object):void {
        this._photoUrl = param1.toString();
    }

    public function get photoUrl():Object {
        return this._photoUrl == "[lapidus]" ? ServerManager.buildContentUrl(UserDemoManager.PHOTO_URL) : this._photoUrl;
    }

    public function get photoUrlString():String {
        return this._photoUrl;
    }

    public function toDto():* {
        var _loc4_:int = 0;
        var _loc1_:String = "";
        if (this._photoUrl) {
            _loc1_ = this._photoUrl;
            _loc4_ = this._photoUrl.indexOf("&access_token");
            if (_loc4_ > -1) {
                _loc1_ = this._photoUrl.substring(0, _loc4_);
            }
        }
        var _loc2_:String = this.socialId;
        if (!_loc2_ || _loc2_.length == 0) {
            _loc2_ = null;
        }
        var _loc3_:Object = {
            "i": _loc2_,
            "n": this.fullName,
            "u": _loc1_,
            "x": this.sex,
            "l": normalizeLocale(this.locale),
            "d": this.customData,
            "a": this.isApproved,
            "vk": {}
        };
        if (this.email && this.email.length > 0) {
            _loc3_.m = this.email;
        }
        if (this.advReferrer && this.advReferrer.length > 0) {
            _loc3_.r = this.advReferrer;
        }
        if (this.hashedId && this.hashedId.length > 0) {
            _loc3_.h = this.hashedId;
        }
        _loc3_.vk = {"b": this.vkShowInMenuStatus};
        _loc3_.p = this.appPermissions;
        _loc3_.ar = this.ageRange;
        _loc3_.t = this.userType;
        _loc3_.tg = this.paymentTestGroup;
        _loc3_.s = this.profileUrl;
        _loc3_.fl = this.isLiked;
        _loc3_.gr = processGistRequests(this.giftRequests);
        if (this.portal_fb_uid) {
            _loc3_.b = this.portal_fb_uid;
        }
        if (this.giftEntrance) {
            _loc3_.pp = this.pageParams;
        }
        _loc3_.np = this.nppAvailable;
        _loc3_.tpi = this.thirdPartyId;
        _loc3_.de = this.devicesList;
        if (this.businessIds != null) {
            _loc3_.bi = this.businessIds;
        }
        if (this.purchaseHistoryDetails != null) {
            _loc3_.ph = this.purchaseHistoryDetails;
        }
        if (this.portal_global_id) {
            _loc3_.gi = this.portal_global_id;
        }
        if (this.portal_social_name) {
            _loc3_.sn = this.portal_social_name;
        }
        if (this.portal_birth_date) {
            _loc3_.bd = this.portal_birth_date;
        }
        if (this.portal_email) {
            _loc3_.se = this.portal_email;
        }
        if (this.portal_fb_bi) {
            _loc3_.bi = this.portal_fb_bi;
        }
        if (this.facebookUserId) {
            _loc3_.f = this.facebookUserId;
        }
        _loc3_.im = this.incognitoMode;
        return _loc3_;
    }

    public function toString():String {
        var _loc2_:* = null;
        var _loc1_:String = "";
        for (_loc2_ in this) {
            _loc1_ = _loc1_ + (_loc2_.toString() + ":" + this[_loc2_].toString());
        }
        return _loc1_;
    }
}
}
