package model.data {
import common.ArrayCustom;
import common.GameType;

import integration.SocialNetworkIdentifier;

public class SectorSkinType {

    public static const SectorSkinTypeId_Default:int = -1;

    public static const SectorSkinGroupId_Beginner:int = 0;

    public static const SectorSkinGroupId_Advanced:int = 1;

    public static const SectorSkinGroupId_Super:int = 2;

    public static const SectorSkinGroupId_Epic:int = 3;

    public static const SectorSkinTypeStatus_Normal:int = 0;

    public static const SectorSkinTypeStatus_Invisible:int = 1;

    public static const SectorSkinTypeStatus_ForceDisabled:int = 2;

    public static const SectorSkinTypeStatus_New:int = 3;


    public var id:int;

    public var name:String;

    public var order:int;

    public var price:Resources;

    public var defenceBonusPoints:int;

    public var urlShop:String;

    public var urlMap:String;

    public var offsetX:int;

    public var offsetY:int;

    public var sizeX:int;

    public var sizeY:int;

    public var description:String;

    public var requiredLevel:int;

    public var limitCount:int;

    public var dateExpires:Date;

    public var status:int = 0;

    public var newUntil:Date;

    public var isForBankSells:Boolean;

    public var isTemporary:Boolean = false;

    public function SectorSkinType() {
        this.dateExpires = new Date();
        super();
    }

    public static function fromDto(param1:*):SectorSkinType {
        var _loc2_:SectorSkinType = new SectorSkinType();
        _loc2_.id = param1.i;
        if (param1.m && param1.m.c) {
            _loc2_.name = param1.m.c;
        }
        else {
            _loc2_.name = param1.n;
        }
        _loc2_.order = param1.o;
        _loc2_.price = Resources.fromDto(param1.p);
        _loc2_.defenceBonusPoints = param1.d == null ? 0 : int(param1.d);
        _loc2_.urlShop = param1.us;
        _loc2_.urlMap = param1.um == null || param1.um == "" ? _loc2_.urlShop : param1.um;
        _loc2_.offsetX = param1.ox;
        _loc2_.offsetY = param1.oy;
        _loc2_.sizeX = param1.sx;
        _loc2_.sizeY = param1.sy;
        _loc2_.requiredLevel = param1.rl;
        _loc2_.limitCount = param1.lc;
        _loc2_.dateExpires = new Date(param1.de);
        _loc2_.isTemporary = param1.tm;
        _loc2_.status = int(param1.s);
        if (param1.t && param1.t.c) {
            _loc2_.description = param1.t.c;
        }
        else {
            _loc2_.description = param1.pt != null ? param1.pt : "";
        }
        _loc2_.newUntil = param1.u == null ? null : new Date(param1.u);
        _loc2_.isForBankSells = param1.b;
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            if (!isDenySkin(_loc3_.i)) {
                _loc2_.addItem(fromDto(_loc3_));
            }
        }
        return _loc2_;
    }

    public static function toDtos(param1:ArrayCustom):Array {
        var _loc3_:SectorSkinType = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public static function isDenySkin(param1:int):Boolean {
        var _loc2_:int = SocialNetworkIdentifier.socialNetworkConfig.cluster;
        var _loc3_:Boolean = GameType.isPirates && param1 == 3008 && SocialNetworkIdentifier.isVK && _loc2_ != 0;
        return _loc3_;
    }

    public function toDto():* {
        var _loc1_:* = {"i": this.id};
        return _loc1_;
    }
}
}
