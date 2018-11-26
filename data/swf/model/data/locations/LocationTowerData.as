package model.data.locations {
import common.ArrayCustom;
import common.GameType;

import flash.events.Event;
import flash.events.EventDispatcher;

import model.data.Resources;
import model.data.TroopsTransfer;
import model.data.locations.towers.TowerUnitSlot;
import model.data.locations.world.ResourceTransfer;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.towerSlots.TowerUnitSlotInfo;

public class LocationTowerData extends EventDispatcher {

    public static const NEED_UPDATE_LOCATION:String = "NeedUpdateLocation";

    public static const NEED_UPDATE_SLOT:String = "NeedUpdateSlot";


    public var level:int;

    public var resources:Resources;

    public var consumptionStartTime:Date;

    public var lastDowngradeTime:Date;

    public var antigen:Number;

    public var towerNumber:Number;

    public var antigenMutationHistory:ArrayCustom;

    public var antigenTransferHistory:ArrayCustom;

    public var resourceTransferHistory:ArrayCustom;

    public var troopsTransferHistory:ArrayCustom;

    public var defenderUserIds:Array;

    public var unitSlots:Array;

    public var bonusLevel:int;

    public var neighborsTowerIds:Array;

    public function LocationTowerData() {
        super();
    }

    public static function fromDto(param1:*):LocationTowerData {
        var _loc2_:LocationTowerData = new LocationTowerData();
        _loc2_.level = param1.l;
        _loc2_.resources = Resources.fromDto(param1.r);
        _loc2_.consumptionStartTime = param1.c == null ? null : new Date(param1.c);
        _loc2_.lastDowngradeTime = param1.d == null ? null : new Date(param1.d);
        _loc2_.antigen = param1.a == null ? Number(Number.NaN) : Number(param1.a);
        _loc2_.antigenMutationHistory = param1.m = !!null ? new ArrayCustom() : AntigenMutation.fromDtos(param1.m);
        _loc2_.antigenTransferHistory = param1.t == null ? new ArrayCustom() : AntigenTransfer.fromDtos(param1.t);
        _loc2_.resourceTransferHistory = param1.h == null ? new ArrayCustom() : ResourceTransfer.fromDtos(param1.h);
        _loc2_.troopsTransferHistory = param1.o == null ? new ArrayCustom() : TroopsTransfer.fromDtos(param1.o);
        _loc2_.towerNumber = param1.n == null ? Number(null) : Number(param1.n);
        _loc2_.defenderUserIds = param1.u == null ? new Array() : param1.u;
        _loc2_.unitSlots = param1.s == null ? new Array() : TowerUnitSlot.fromDtos(param1.s);
        _loc2_.bonusLevel = param1.x;
        _loc2_.neighborsTowerIds = param1.nt;
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

    public static function toDtos(param1:ArrayCustom):Array {
        var _loc3_:LocationTowerData = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function getEffectiveLevel():int {
        return this.level;
    }

    public function getSignalLevel():Number {
        return this.getEffectiveLevel();
    }

    public function getEstimatedPlutoniumAmount():Number {
        if (this.consumptionStartTime == null) {
            return 0;
        }
        var _loc1_:Number = (new Date().time - this.consumptionStartTime.time) / (1000 * 60 * 60);
        return 0;
    }

    public function getEstimatedEffectiveLevel():int {
        return this.level;
    }

    public function getEstimatedSignalLevel():int {
        if (GameType.isNords) {
            return this.getEstimatedEffectiveLevel() * 300;
        }
        return this.getEstimatedEffectiveLevel() * 100;
    }

    public function getEstimatedDefenceBonusPercents(param1:Boolean = false):int {
        if (param1) {
            return this.getEstimatedEffectiveLevel() * 5 + this.bonusTower5s();
        }
        return this.getEstimatedEffectiveLevel() * 5;
    }

    public function getEstimatedDefenceBonusPercentsByLevel(param1:int):int {
        return param1 * 5 + this.bonusTower5s(param1);
    }

    private function bonusTower5s(param1:int = -1):Number {
        var _loc2_:int = param1 == -1 || param1 > 4 ? int(this.level) : int(param1);
        var _loc3_:Array = StaticDataManager.towerData.towerBonusInfoByLevel;
        return !!_loc3_ ? Number(_loc3_[_loc2_ - 1].defencePercent) : Number(0);
    }

    public function toDto():* {
        var _loc1_:* = {
            "l": this.level,
            "r": (this.resources == null ? null : this.resources.toDto()),
            "c": (this.consumptionStartTime == null ? null : this.consumptionStartTime.time),
            "d": (this.lastDowngradeTime == null ? null : this.lastDowngradeTime.time),
            "a": (!!isNaN(this.antigen) ? null : this.antigen),
            "m": AntigenMutation.toDtos(this.antigenMutationHistory),
            "h": ResourceTransfer.toDtos(this.resourceTransferHistory)
        };
        return _loc1_;
    }

    public function upgradeUnitSlotsToCurrentLevel():void {
        var _loc6_:TowerUnitSlotInfo = null;
        var _loc7_:TowerUnitSlot = null;
        var _loc8_:int = 0;
        var _loc9_:TowerUnitSlotInfo = null;
        var _loc10_:TowerUnitSlotInfo = null;
        var _loc11_:int = 0;
        var _loc1_:int = this.level - 1;
        var _loc2_:Array = StaticDataManager.towerData.towerUnitSlotsByLevel;
        if (_loc2_ == null || _loc1_ < 0 || _loc1_ >= _loc2_.length) {
            return;
        }
        var _loc3_:Array = _loc2_[_loc1_];
        var _loc4_:Array = this.unitSlots;
        this.unitSlots = new Array();
        var _loc5_:Array = new Array();
        for each(_loc6_ in _loc3_) {
            this.unitSlots.push(TowerUnitSlot.towerUnitSlotFill(_loc6_.id, _loc6_.IsPayFree()));
        }
        _loc8_ = 0;
        while (_loc8_ < _loc4_.length) {
            _loc7_ = _loc4_[_loc8_];
            if (_loc7_.userId != -1) {
                this.unitSlots[_loc8_].userId = _loc7_.userId;
                this.unitSlots[_loc8_].bought = true;
            }
            _loc8_++;
        }
        for each(_loc7_ in _loc4_) {
            _loc9_ = StaticDataManager.towerData.GetUnitSlotById(_loc7_.slotId);
            if (_loc9_ != null && _loc9_.IsPaid()) {
                if (_loc7_.bought) {
                    _loc5_.push(_loc9_.price);
                }
            }
        }
        _loc8_ = 0;
        while (_loc8_ < this.unitSlots.length && _loc5_.length != 0) {
            _loc10_ = _loc3_[_loc8_];
            if (!_loc10_.IsPayFree()) {
                _loc11_ = this.searchArray(_loc5_, _loc10_.price);
                if (_loc11_ != -1) {
                    this.unitSlots[_loc8_].bought = true;
                    _loc5_.splice(_loc11_, 1);
                }
            }
            _loc8_++;
        }
    }

    public function checkBuySlot(param1:int):Boolean {
        var _loc3_:TowerUnitSlotInfo = null;
        var _loc2_:int = 0;
        while (_loc2_ < this.unitSlots.length) {
            _loc3_ = StaticDataManager.towerData.GetUnitSlotById(this.unitSlots[_loc2_].slotId);
            if (this.unitSlots[_loc2_].slotId == param1 && _loc3_ != null && _loc3_.IsPaid()) {
                return true;
            }
            if (!this.unitSlots[_loc2_].bought && _loc3_ != null && _loc3_.IsPaid()) {
                return false;
            }
            _loc2_++;
        }
        return false;
    }

    private function searchArray(param1:Array, param2:Resources):int {
        var _loc3_:int = 0;
        while (_loc3_ < param1.length) {
            if (param1[_loc3_].goldMoney == param2.goldMoney) {
                return _loc3_;
            }
            _loc3_++;
        }
        return -1;
    }

    public function removeUnitFromSlot(param1:int):void {
        var _loc2_:int = 0;
        while (_loc2_ < this.unitSlots.length) {
            if (this.unitSlots[_loc2_].slotId == param1) {
                this.unitSlots[_loc2_] = -1;
                break;
            }
            _loc2_++;
        }
    }

    public function dispatchEventsNeedUpdateData():void {
        dispatchEvent(new Event(NEED_UPDATE_LOCATION));
    }

    public function dispatchEventsNeedUpdateSlotData():void {
        dispatchEvent(new Event(NEED_UPDATE_SLOT));
    }

    public function isMyTroopsReinforcements():Boolean {
        var _loc1_:int = 0;
        while (_loc1_ < this.unitSlots.length) {
            if (this.unitSlots[_loc1_].userId == UserManager.user.id) {
                return true;
            }
            _loc1_++;
        }
        return false;
    }

    public function getFreeTower():int {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        while (_loc2_ < this.unitSlots.length) {
            if (this.unitSlots[_loc2_].bought) {
                _loc1_++;
            }
            _loc2_++;
        }
        return _loc1_;
    }
}
}
