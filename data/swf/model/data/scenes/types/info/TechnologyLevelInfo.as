package model.data.scenes.types.info {
import common.ArrayCustom;
import common.DictionaryUtil;

import configs.Global;

import flash.utils.Dictionary;

import model.data.Resources;
import model.logic.StaticDataManager;

public class TechnologyLevelInfo {

    public static const ATTACK_BONUS:int = 1;

    public static const DEFENCE_BONUS:int = 2;


    public var unitCountLimitBonus:MovingUnitCount;

    public var armySizeLimitBonus:ArmySize;

    public var caravanQuantity:int;

    public var caravanCapacityPercent:int;

    public var caravanSpeed:int;

    public var dynamicResourceMiningSpeedPerHour:Resources;

    private var _troopsBonus:Dictionary;

    private var _troopsAttackBonus:Dictionary;

    private var _troopsDefenceBonus:Dictionary;

    public function TechnologyLevelInfo() {
        super();
    }

    public static function fromDto(param1:*):TechnologyLevelInfo {
        var _loc2_:TechnologyLevelInfo = new TechnologyLevelInfo();
        _loc2_._troopsBonus = DictionaryUtil.fromDto(param1.b);
        _loc2_._troopsAttackBonus = DictionaryUtil.fromDto(param1.ab);
        _loc2_._troopsDefenceBonus = DictionaryUtil.fromDto(param1.db);
        _loc2_.caravanQuantity = param1.f;
        _loc2_.caravanCapacityPercent = param1.g;
        _loc2_.caravanSpeed = param1.h;
        _loc2_.unitCountLimitBonus = !!param1.u ? MovingUnitCount.fromDto(param1.u) : null;
        _loc2_.armySizeLimitBonus = !!param1.a ? ArmySize.fromDto(param1.a) : null;
        _loc2_.dynamicResourceMiningSpeedPerHour = param1.m == null ? null : Resources.fromDto(param1.m);
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

    public function hasTroopsBonus(param1:int):Boolean {
        var _loc2_:* = false;
        if (Global.TECHNOLOGY_TROOPS_32LEVELS_ENABLED) {
            _loc2_ = Boolean(this._troopsAttackBonus[param1] != null || this._troopsDefenceBonus[param1] != null);
        }
        else {
            _loc2_ = this._troopsBonus[param1] != null;
        }
        return _loc2_;
    }

    public function getTroopsBonuses(param1:int = 1):Dictionary {
        var _loc2_:Dictionary = null;
        if (Global.TECHNOLOGY_TROOPS_32LEVELS_ENABLED) {
            if (param1 == ATTACK_BONUS) {
                _loc2_ = this._troopsAttackBonus;
            }
            else if (param1 == DEFENCE_BONUS) {
                _loc2_ = this._troopsDefenceBonus;
            }
        }
        else {
            _loc2_ = this._troopsBonus;
        }
        return _loc2_;
    }

    public function getTroopsBonusById(param1:int, param2:int):int {
        var _loc3_:Dictionary = this.getTroopsBonuses(param1);
        return _loc3_[param2];
    }

    public function getTroopsBonus(param1:int):int {
        var _loc3_:* = undefined;
        var _loc2_:Dictionary = this.getTroopsBonuses(param1);
        for (_loc3_ in _loc2_) {
            return _loc2_[_loc3_];
        }
        return 0;
    }

    public function getUnitTypes():Array {
        var _loc3_:* = undefined;
        var _loc1_:Array = [];
        var _loc2_:Dictionary = this.getTroopsBonuses(ATTACK_BONUS);
        if (_loc2_ != null) {
            for (_loc3_ in _loc2_) {
                _loc1_.push(StaticDataManager.getObjectType(_loc3_ as Number));
            }
        }
        return _loc1_;
    }
}
}
