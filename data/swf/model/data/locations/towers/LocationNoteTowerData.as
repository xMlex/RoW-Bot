package model.data.locations.towers {
import common.ArrayCustom;

import model.logic.StaticDataManager;

public class LocationNoteTowerData {


    public var level:int;

    public var plutonium:Number;

    public var consumptionStartTime:Date;

    public var towerBonusLevel:int;

    public function LocationNoteTowerData() {
        super();
    }

    public static function fromDto(param1:*):LocationNoteTowerData {
        var _loc2_:LocationNoteTowerData = new LocationNoteTowerData();
        _loc2_.level = param1.l;
        _loc2_.plutonium = param1.p;
        _loc2_.consumptionStartTime = param1.c == null ? null : new Date(param1.c);
        _loc2_.towerBonusLevel = param1.x;
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
        var _loc3_:LocationNoteTowerData = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function getEstimatedPlutoniumAmount():Number {
        if (this.consumptionStartTime == null) {
            return 0;
        }
        return Math.max(0, this.plutonium - (new Date().time - this.consumptionStartTime.time) / 1000 * 60 * 60 * StaticDataManager.towerData.plutoniumConsumptionPerHour);
    }

    public function get isSuperTower():Boolean {
        return this.towerBonusLevel > 0 && this.towerBonusLevel == StaticDataManager.towerData.towerBonusInfoByLevel.length - 1;
    }

    public function getEstimatedEffectiveLevel():int {
        return this.level;
    }

    public function getEstimatedSignalLevel():int {
        return this.getEstimatedEffectiveLevel();
    }

    public function getEstimatedDefenceBonusPercents():int {
        return this.getEstimatedEffectiveLevel() * 5;
    }

    public function get signalBonusCoef():Number {
        var _loc1_:Number = this.towerBonusLevel > 0 && StaticDataManager.towerData.towerBonusInfoByLevel != null ? Number(StaticDataManager.towerData.towerBonusInfoByLevel[this.towerBonusLevel].signalPercent) : Number(0);
        return 1 + _loc1_ / 100;
    }

    public function toDto():* {
        var _loc1_:* = {
            "l": this.level,
            "p": this.plutonium,
            "c": (this.consumptionStartTime == null ? null : this.consumptionStartTime.time)
        };
        return _loc1_;
    }
}
}
