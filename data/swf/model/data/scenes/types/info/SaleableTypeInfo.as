package model.data.scenes.types.info {
import common.ArrayCustom;

import configs.Global;

import model.logic.UserManager;

public class SaleableTypeInfo {


    public var levelInfos:Vector.<SaleableLevelInfo>;

    public var requiredObjects:ArrayCustom;

    public var limit:int;

    public var requiresAllExistingMaxLevel:Boolean;

    public var discountsProhibited:Boolean;

    public function SaleableTypeInfo() {
        super();
    }

    public static function fromDto(param1:*):SaleableTypeInfo {
        if (param1 == null) {
            return null;
        }
        var _loc2_:SaleableTypeInfo = new SaleableTypeInfo();
        _loc2_.levelInfos = SaleableLevelInfo.fromDtos(param1.lc);
        _loc2_.requiredObjects = RequiredObject.fromDtos(param1.ro);
        _loc2_.limit = param1.l;
        _loc2_.requiresAllExistingMaxLevel = param1.m;
        _loc2_.discountsProhibited = param1.d;
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public function get levelsCount():int {
        return this.levelInfos.length;
    }

    public function getLevelInfo(param1:int):SaleableLevelInfo {
        return this.levelInfos[param1 - 1];
    }

    public function limitWithBonuses(param1:int):int {
        var _loc2_:int = this.limit;
        if (Global.ADDITIONAL_BUILDINGS_LEVELS_VOL2_ENABLED) {
            _loc2_ = _loc2_ + UserManager.user.gameData.sector.buildingLimitBonuses(param1);
        }
        return _loc2_;
    }
}
}
