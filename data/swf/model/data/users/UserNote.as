package model.data.users {
import common.ArrayCustom;
import common.GameType;
import common.StringUtil;
import common.queries.util.query;

import flash.geom.Rectangle;

import model.data.GeneralNote;
import model.data.SectorSkinType;
import model.data.User;
import model.data.UserShieldTypeId;
import model.data.effects.EffectSource;
import model.data.effects.EffectTypeId;
import model.data.effects.LightEffectItem;
import model.data.map.MapPos;
import model.data.temporarySkins.TemporarySkin;
import model.logic.ServerManager;
import model.logic.UserDemoManager;
import model.logic.UserLevelManager;
import model.logic.UserManager;
import model.logic.UserNoteManager;
import model.logic.blackMarketItems.EffectInfo;
import model.logic.character.UserNoteCharacterData;
import model.logic.vip.VipManager;

public class UserNote extends GeneralNote {

    public static const STATUS_THIS_USER:String = "statusThisUser";

    public static const STATUS_DEMO_USER:String = "statusDemoUser";

    public static const STATUS_ALLY:String = "statusAlly";

    public static const STATUS_HELPER:String = "statusHelper";

    public static const STATUS_ENEMY:String = "statusEnemy";

    public static const STATUS_FOE:String = "statusFoe";

    public static const STATUS_FRIEND:String = "statusFriend";

    public static const STATUS_NEW_USER:String = "statusNewUser";

    public static const STATUS_UNKNOWN_USER:String = "statusUnknownUser";


    public var segmentId:int;

    public var socialId:String;

    public var profileUrl:String = "";

    public var fullName:String;

    private var _photoUrl:String;

    public var registrationTime:Date;

    public var lastReturnDate:Date;

    public var sectorName:String;

    public var mapStateId:int;

    public var caravanSpeed:Number;

    public var allianceId:Number;

    public var allianceRankId:int;

    public var mobilizersCount:int;

    public var sectorSkinTypeId:Number;

    public var lastMissileStrikeDate:Date;

    public var hashedId:String;

    public var activeVipLevel:int;

    public var hasVipSectorNamePanel:Boolean;

    public var lastReceivedGachaChestIndex:int;

    public var mapElementRect:Rectangle;

    public var mapImageSource:String;

    public var mapTooltipEnabled:Boolean;

    public var characterData:UserNoteCharacterData;

    private var _incognitoMode:Boolean = false;

    public var effectItems:ArrayCustom;

    public var shieldTypeId:int;

    public var hasActiveTempSkin:Boolean;

    private var _status:String;

    public function UserNote(param1:User = null) {
        super();
        if (param1 != null) {
            id = param1.id;
            this.segmentId = UserManager.segmentId;
            this.socialId = !!param1.socialData.socialId ? param1.socialData.socialId : "";
            this.profileUrl = !!param1.socialData.profileUrl ? param1.socialData.profileUrl : "";
            this.fullName = !!param1.socialData.fullName ? param1.socialData.fullName : "";
            this._photoUrl = param1.socialData.photoUrlString;
            this.registrationTime = param1.gameData.commonData.registrationTime;
            level = param1.gameData.account.level;
            this.sectorName = param1.gameData.sector.name;
            mapPos = param1.gameData.mapPos;
            this.caravanSpeed = param1.gameData.constructionData.caravanSpeed;
            occupantUserId = UserManager.getOccupantUserId(param1);
            this.activeVipLevel = !!VipManager.getActiveState() ? int(param1.gameData.vipData.vipLevel) : 0;
            this.hasVipSectorNamePanel = param1.gameData.vipSupportData.hasVipSectorNamePanel;
            if (param1.gameData.allianceData != null) {
                this.allianceId = param1.gameData.allianceData.allianceId;
                this.allianceRankId = param1.gameData.allianceData.rankId;
                this.mobilizersCount = param1.gameData.allianceData.mobilizersCount;
            }
            this.effectItems = param1.gameData.effectData.getLightEffectsList();
            this.shieldTypeId = getShieldType(this.effectItems);
            this.sectorSkinTypeId = !!param1.gameData.sectorSkinsData ? Number(UserManager.user.gameData.sectorSkinsData.currentSkinTypeId) : Number(SectorSkinType.SectorSkinTypeId_Default);
            this.hasActiveTempSkin = param1.gameData.sectorSkinsData && param1.gameData.sectorSkinsData.temporarySectorSkinData && param1.gameData.sectorSkinsData.temporarySectorSkinData.currentActiveSkin;
            this.lastReturnDate = param1.gameData.commonData.lastReturnDate;
        }
    }

    public static function fromDto(param1:*):UserNote {
        var _loc2_:UserNote = new UserNote();
        _loc2_.id = param1.i;
        _loc2_.segmentId = param1.g;
        _loc2_.socialId = param1.s;
        _loc2_.profileUrl = !!param1.f ? param1.f : "";
        if (param1.p == null) {
            _loc2_._photoUrl = "";
        }
        else {
            _loc2_._photoUrl = param1.p;
        }
        _loc2_._photoUrl = fixFbPhotoUrl(_loc2_._photoUrl);
        if (_loc2_._photoUrl.indexOf("question") != -1) {
            _loc2_._photoUrl = ServerManager.buildContentUrl("ui/question_a.gif");
        }
        else if (_loc2_._photoUrl.indexOf("camera") != -1) {
            _loc2_._photoUrl = ServerManager.buildContentUrl("ui/camera_a.gif");
        }
        _loc2_.registrationTime = new Date(param1.r);
        _loc2_.level = param1.l;
        _loc2_.sectorName = !!GameType.isNords ? param1.a : StringUtil.validateSymbols(param1.a);
        _loc2_.mapPos = MapPos.fromDto(param1.m);
        _loc2_.mapStateId = param1.ms == null ? 0 : int(param1.ms);
        _loc2_.isIncognito = param1.n == null && _loc2_._photoUrl == "" && _loc2_.profileUrl == "";
        _loc2_.fullName = param1.n != null ? validateName(StringUtil.replaceSpecExpressions(param1.n), _loc2_.id, _loc2_.socialId) : !!_loc2_.mapPos ? "User" + Math.abs(_loc2_.mapPos.x).toString() + Math.abs(_loc2_.mapPos.y).toString() : "UnknownUser";
        _loc2_.name = _loc2_.fullName;
        _loc2_.caravanSpeed = param1.c;
        _loc2_.occupantUserId = param1.o == null ? Number(NaN) : Number(param1.o);
        _loc2_.sectorSkinTypeId = param1.si == null ? Number(NaN) : Number(param1.si);
        _loc2_.allianceId = param1.x == null ? Number(NaN) : Number(param1.x);
        _loc2_.allianceRankId = param1.y == null ? -1 : int(param1.y);
        _loc2_.mobilizersCount = param1.mc == null ? 0 : int(param1.mc);
        _loc2_.hashedId = param1.e == null ? "" : param1.e;
        _loc2_.activeVipLevel = param1.av == null ? 0 : int(param1.av);
        _loc2_.hasVipSectorNamePanel = param1.np;
        _loc2_.lastReceivedGachaChestIndex = param1.gc;
        _loc2_.lastMissileStrikeDate = param1.b == null ? null : new Date(param1.b);
        _loc2_.lastReturnDate = !!param1.lr ? new Date(param1.lr) : null;
        _loc2_.characterData = UserNoteCharacterData.fromDto(param1);
        _loc2_.effectItems = LightEffectItem.fromDtos(param1.el);
        _loc2_.shieldTypeId = getShieldType(_loc2_.effectItems);
        _loc2_.hasActiveTempSkin = hasActiveTemporarySkin(_loc2_.effectItems);
        return _loc2_;
    }

    public static function fixFbPhotoUrl(param1:String):String {
        if (param1.indexOf("/picture&type=large") > -1) {
            return param1.replace("/picture&type", "/picture?type");
        }
        return param1;
    }

    private static function validateName(param1:String, param2:int, param3:String):String {
        var _loc5_:String = null;
        if (param2 == UserDemoManager.DemoUserId || UserDemoManager.demoUsersArray.indexOf(param3) > 0) {
            return param1;
        }
        var _loc4_:String = param1.toLowerCase();
        for each(_loc5_ in UserDemoManager.demoUserNames) {
            if (_loc4_.indexOf(_loc5_.toLowerCase()) >= 0) {
                return "FAKE";
            }
        }
        return StringUtil.validateSymbols(param1);
    }

    private static function getShieldType(param1:ArrayCustom):int {
        var _loc3_:LightEffectItem = null;
        var _loc2_:int = UserShieldTypeId.NONE;
        for each(_loc3_ in param1) {
            if (_loc3_.effectTypeId == EffectTypeId.UserFullProtection) {
                _loc2_ = UserShieldTypeId.USER_FULL_PROTECTION;
                break;
            }
            if (_loc3_.effectTypeId == EffectTypeId.UserProtectionIntelligence) {
                _loc2_ = UserShieldTypeId.USER_PROTECTION_INTELLIGENCE;
                break;
            }
        }
        return _loc2_;
    }

    private static function hasActiveTemporarySkin(param1:ArrayCustom):Boolean {
        var effects:ArrayCustom = param1;
        return query(effects).any(function (param1:LightEffectItem):Boolean {
            return param1.source & EffectSource.TemporarySector && param1.effectTypeId == EffectTypeId.TemporarySectorSkin;
        });
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public function get isIncognito():Boolean {
        return this._incognitoMode;
    }

    public function set isIncognito(param1:Boolean):void {
        if (GameType.isNords) {
            this._incognitoMode = param1;
        }
        else {
            this._incognitoMode = false;
        }
    }

    public function isUpdated():Boolean {
        return UserNoteManager.getById(id) != this;
    }

    public function mapPosInitialized():Boolean {
        return mapPos != null;
    }

    public function get status():String {
        var _loc9_:Number = NaN;
        var _loc10_:Number = NaN;
        var _loc11_:Number = NaN;
        var _loc12_:Number = NaN;
        var _loc1_:* = id == UserManager.user.id;
        var _loc2_:* = id == 0;
        var _loc3_:* = !UserLevelManager.isSkilledUser2(this);
        var _loc4_:Boolean = false;
        var _loc5_:Boolean = false;
        var _loc6_:Boolean = false;
        var _loc7_:Boolean = false;
        var _loc8_:Boolean = false;
        if (!_loc1_ && !_loc2_) {
            _loc4_ = UserManager.user.gameData.clanData.isMemberIsAlly(id);
            for each(_loc9_ in UserManager.user.gameData.knownUsersData.mateUserIds) {
                if (id == _loc9_) {
                    _loc5_ = true;
                    break;
                }
            }
            for each(_loc10_ in UserManager.user.gameData.knownUsersData.enemyUserIds) {
                if (id == _loc10_) {
                    _loc6_ = true;
                    break;
                }
            }
            for each(_loc11_ in UserManager.user.gameData.knownUsersData.allianceEnemyUserIds) {
                if (id == _loc11_) {
                    _loc7_ = true;
                    break;
                }
            }
            for each(_loc12_ in UserManager.userFriendIds) {
                if (id == _loc12_) {
                    _loc8_ = true;
                    break;
                }
            }
        }
        if (_loc1_) {
            return STATUS_THIS_USER;
        }
        if (_loc2_) {
            return STATUS_DEMO_USER;
        }
        if (_loc4_) {
            return STATUS_ALLY;
        }
        if (_loc6_) {
            return STATUS_ENEMY;
        }
        if (_loc3_) {
            return STATUS_NEW_USER;
        }
        if (_loc5_) {
            return STATUS_HELPER;
        }
        if (_loc7_) {
            return STATUS_FOE;
        }
        if (_loc8_) {
            return STATUS_FRIEND;
        }
        return STATUS_UNKNOWN_USER;
    }

    public function set photoUrl(param1:Object):void {
        this._photoUrl = param1.toString();
    }

    public function get photoUrl():Object {
        var _loc1_:String = !UserDemoManager.emptyPhotoUrl || UserDemoManager.emptyPhotoUrl == "" ? "" : ServerManager.buildContentUrl(UserDemoManager.emptyPhotoUrl);
        if (this._photoUrl != null && this._photoUrl != "") {
            if (this._photoUrl == "[lapidus]") {
                _loc1_ = ServerManager.buildContentUrl(UserDemoManager.PHOTO_URL);
            }
            else if (this._photoUrl.indexOf("vkontakte.ru/images/question") > -1) {
                _loc1_ = ServerManager.buildContentUrl("ui/question_a.gif");
            }
            else if (this._photoUrl.indexOf("vkontakte.ru/images/camera") > -1) {
                _loc1_ = ServerManager.buildContentUrl("ui/camera_a.gif");
            }
            else {
                _loc1_ = this._photoUrl;
            }
        }
        return _loc1_;
    }

    public function getCurrentActiveSkin():TemporarySkin {
        var tempSkin:TemporarySkin = null;
        var skinEffect:LightEffectItem = null;
        if (this.hasActiveTempSkin) {
            tempSkin = new TemporarySkin();
            tempSkin.skinTypeId = this.sectorSkinTypeId;
            tempSkin.skinTemplateId = -1;
            skinEffect = query(this.effectItems).firstOrDefault(function (param1:LightEffectItem):Boolean {
                return param1.source & EffectSource.TemporarySector && param1.effectTypeId == EffectTypeId.TemporarySectorSkin;
            });
            if (skinEffect != null) {
                tempSkin.skinEffectInfo = skinEffect.toEffectInfo();
            }
            tempSkin.additionalEffectInfos = query(this.effectItems).where(function (param1:LightEffectItem):Boolean {
                return param1.source & EffectSource.TemporarySector && param1.effectTypeId != EffectTypeId.TemporarySectorSkin;
            }).select(function (param1:LightEffectItem):EffectInfo {
                return param1.toEffectInfo();
            }).toArray();
            return tempSkin;
        }
        return null;
    }
}
}
