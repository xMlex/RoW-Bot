package model.data.alliances {
import common.ArrayCustom;

import flash.utils.Dictionary;

import gameObjects.observableObject.ObservableObject;

public class AllianceTowerData extends ObservableObject {

    public static const CLASS_NAME:String = "AllianceTowerData";

    public static const OCCUPIED_TOWERS_CHANGED:String = CLASS_NAME + "OccupiedTowersChanged";

    public static const PERMITTED_TOWERS_CHANGED:String = CLASS_NAME + "PermittedTowersChanged";


    public var occupiedTowerIds:ArrayCustom;

    public var occupiedTowerLevels:Dictionary;

    public var towerUnitTroops:Dictionary;

    public var towerUnitTroopsStats:Dictionary;

    public var membersPermittedToReturnTowerTroops:Array;

    public var membersPermittedToReturnTroopsFromSlots:Array;

    public var occupiedTeritory:Number;

    public var occupiedTeritoryPure:Number;

    public var dirty:Boolean = false;

    public var dirtyPermitted:Boolean = false;

    public function AllianceTowerData() {
        this.occupiedTowerIds = new ArrayCustom();
        this.occupiedTowerLevels = new Dictionary();
        this.towerUnitTroops = new Dictionary();
        this.towerUnitTroopsStats = new Dictionary();
        super();
    }

    public static function fromDto(param1:*):AllianceTowerData {
        var _loc3_:* = undefined;
        var _loc4_:int = 0;
        var _loc2_:AllianceTowerData = new AllianceTowerData();
        _loc2_.occupiedTowerIds = new ArrayCustom(param1.t);
        _loc2_.occupiedTowerLevels = new Dictionary();
        _loc2_.membersPermittedToReturnTowerTroops = param1.p == null ? [] : param1.p;
        _loc2_.membersPermittedToReturnTroopsFromSlots = param1.ts == null ? [] : param1.ts;
        _loc2_.occupiedTeritory = param1.r;
        _loc2_.occupiedTeritoryPure = param1.u;
        if (param1.l) {
            for (_loc3_ in param1.l) {
                _loc4_ = param1.l[_loc3_];
                _loc2_.occupiedTowerLevels[_loc3_] = _loc4_;
            }
        }
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
        var _loc3_:AllianceTowerData = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(OCCUPIED_TOWERS_CHANGED);
        }
        if (this.dirtyPermitted) {
            this.dirtyPermitted = false;
            dispatchEvent(PERMITTED_TOWERS_CHANGED);
        }
    }

    public function getTowerDefencePowerByUserId(param1:Number, param2:Number = -1):int {
        var _loc4_:* = undefined;
        var _loc5_:* = undefined;
        var _loc3_:int = 0;
        for (_loc4_ in this.towerUnitTroopsStats) {
            for (_loc5_ in this.towerUnitTroopsStats[_loc4_]) {
                if (_loc5_ == param1) {
                    _loc3_ = _loc3_ + (this.towerUnitTroopsStats[_loc4_][_loc5_] as AllianceUserTroopsStats).getDefencePower(param2);
                }
            }
        }
        return _loc3_;
    }

    public function toDto():* {
        var _loc1_:* = {"t": (this.occupiedTowerIds == null ? null : this.occupiedTowerIds)};
        return _loc1_;
    }
}
}
