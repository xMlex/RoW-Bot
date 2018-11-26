package model.data.users.troops {
import common.ArrayCustom;

import flash.utils.Dictionary;

import gameObjects.observableObject.ObservableObject;

import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.TroopsGroupId;
import model.data.scenes.types.info.TroopsTypeId;
import model.data.visualBattle.UnitVO;
import model.logic.StaticDataManager;

public class Troops extends ObservableObject {

    public static const CLASS_NAME:String = "Troops";

    public static const STATUS_UPDATED:String = CLASS_NAME + "StatusUpdated";

    public static const NEED_TO_CLEAR:String = CLASS_NAME + "NeedToClear";


    public var countByType:Dictionary;

    public var dirtyNormalized:Boolean;

    public function Troops(param1:Troops = null) {
        this.countByType = new Dictionary();
        super();
        if (param1 == null) {
            return;
        }
        this.addTroops(param1);
    }

    public static function from(param1:int, param2:Number):Troops {
        var _loc3_:Troops = new Troops();
        _loc3_.countByType[param1] = param2;
        return _loc3_;
    }

    public static function addTroopsS(param1:Troops, param2:Troops):Troops {
        var _loc3_:Troops = new Troops(param1);
        _loc3_.addTroops(param2);
        return _loc3_;
    }

    public static function fromDto(param1:*):Troops {
        var _loc3_:* = undefined;
        var _loc4_:int = 0;
        var _loc2_:Troops = new Troops();
        for (_loc3_ in param1.t) {
            _loc4_ = param1.t[_loc3_];
            if (_loc4_ != 0) {
                _loc2_.countByType[_loc3_] = _loc4_;
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
        var _loc3_:Troops = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function get Empty():Boolean {
        var _loc1_:* = undefined;
        for each(_loc1_ in this.countByType) {
            return false;
        }
        return true;
    }

    public function raiseNeedToClear():void {
        dispatchEvent(NEED_TO_CLEAR);
    }

    public function dispatchEvents():void {
        if (!this.dirtyNormalized) {
            return;
        }
        this.dirtyNormalized = false;
        dispatchEvent(STATUS_UPDATED);
    }

    public function capacity():Number {
        var _loc2_:Number = NaN;
        var _loc1_:Number = 0;
        for each(_loc2_ in this.countByType) {
            _loc1_ = _loc1_ + _loc2_;
        }
        return _loc1_;
    }

    public function maxValue():Number {
        var _loc2_:Number = NaN;
        var _loc1_:Number = 0;
        for each(_loc2_ in this.countByType) {
            if (_loc2_ > _loc1_) {
                _loc1_ = _loc2_;
            }
        }
        return _loc1_;
    }

    public function getAttack():Number {
        return 0;
    }

    public function getDefense():Number {
        return 0;
    }

    public function getLength():int {
        var _loc2_:* = undefined;
        var _loc1_:uint = 0;
        for (_loc2_ in this.countByType) {
            _loc1_ = _loc1_ + this.countByType[_loc2_];
        }
        return _loc1_;
    }

    public function getTypesLength():int {
        var _loc2_:* = undefined;
        var _loc1_:int = 0;
        for (_loc2_ in this.countByType) {
            _loc1_++;
        }
        return _loc1_;
    }

    public function toVector(param1:Boolean = false, param2:Boolean = false):Vector.<UnitVO> {
        var _loc4_:* = undefined;
        var _loc5_:UnitVO = null;
        var _loc3_:Vector.<UnitVO> = new Vector.<UnitVO>(0);
        for (_loc4_ in this.countByType) {
            if (!(param2 == false && this.isRobot(_loc4_))) {
                _loc5_ = new UnitVO();
                if (param1) {
                    _loc5_.type = _loc4_;
                    _loc5_.count = 0;
                    _loc5_.losses = this.countByType[_loc4_];
                    _loc3_.push(_loc5_);
                }
                else {
                    _loc5_.type = _loc4_;
                    _loc5_.count = this.countByType[_loc4_];
                    _loc3_.push(_loc5_);
                }
            }
        }
        return _loc3_;
    }

    private function isRobot(param1:int):Boolean {
        switch (param1) {
            case TroopsTypeId.BuildingIdRobot1:
            case TroopsTypeId.BuildingIdRobot2:
            case TroopsTypeId.BuildingIdRobot3:
            case TroopsTypeId.BuildingIdRobot21:
            case TroopsTypeId.BuildingIdRobot22:
            case TroopsTypeId.BuildingIdRobot23:
            case TroopsTypeId.BuildingIdRepairingRobot:
            case TroopsTypeId.BuildingIdExtractorRig:
            case TroopsTypeId.GunTurrets:
            case TroopsTypeId.GunTurrets2:
            case TroopsTypeId.GunTurrets3:
            case TroopsTypeId.GunTurrets4:
            case TroopsTypeId.GunTurrets5:
            case TroopsTypeId.GunTurrets6:
            case TroopsTypeId.GunTurrets7:
            case TroopsTypeId.GunTurrets8:
            case TroopsTypeId.GunTurrets9:
            case TroopsTypeId.GunTurrets10:
            case TroopsTypeId.MissileTurrets:
            case TroopsTypeId.MissileTurrets2:
            case TroopsTypeId.MissileTurrets3:
            case TroopsTypeId.MissileTurrets4:
            case TroopsTypeId.MissileTurrets5:
            case TroopsTypeId.MissileTurrets6:
            case TroopsTypeId.MissileTurrets7:
            case TroopsTypeId.MissileTurrets8:
            case TroopsTypeId.MissileTurrets9:
            case TroopsTypeId.MissileTurrets10:
            case TroopsTypeId.RobotUnitBoostResources:
            case TroopsTypeId.Gate:
            case TroopsTypeId.Catapult:
            case TroopsTypeId.Mortira:
            case TroopsTypeId.RobotUnit1:
            case TroopsTypeId.RobotUnit2:
            case TroopsTypeId.RobotUnit3:
            case TroopsTypeId.RobotUnit21:
            case TroopsTypeId.RobotUnit22:
            case TroopsTypeId.RobotUnit23:
            case TroopsTypeId.LocationUnit1:
            case TroopsTypeId.LocationUnit2:
                return true;
            default:
                return false;
        }
    }

    public function get(param1:int):int {
        return this.countByType[param1] == null ? 0 : int(this.countByType[param1]);
    }

    public function clone():Troops {
        var _loc2_:* = undefined;
        var _loc1_:Troops = new Troops();
        for (_loc2_ in this.countByType) {
            _loc1_.countByType[_loc2_] = this.countByType[_loc2_];
        }
        return _loc1_;
    }

    public function addTroops(param1:Troops):void {
        var _loc2_:* = undefined;
        if (param1) {
            for (_loc2_ in param1.countByType) {
                this.addTroops2(_loc2_, param1.countByType[_loc2_]);
            }
        }
    }

    public function addTroopsApplyFilter(param1:Troops, param2:*, param3:Boolean = false):void {
        var _loc4_:* = undefined;
        var _loc5_:GeoSceneObjectType = null;
        if (param3) {
            if (TroopsGroupId.STRATEGY == param2) {
                for (_loc4_ in param1.countByType) {
                    _loc5_ = StaticDataManager.getObjectType(_loc4_);
                    if (_loc5_.isStrategyUnit) {
                        this.addTroops2(_loc4_, param1.countByType[_loc4_]);
                    }
                }
            }
            else {
                for (_loc4_ in param1.countByType) {
                    _loc5_ = StaticDataManager.getObjectType(_loc4_);
                    if (!_loc5_.isStrategyUnit && _loc5_.troopsInfo.kindId == param2) {
                        this.addTroops2(_loc4_, param1.countByType[_loc4_]);
                    }
                }
            }
        }
        else {
            for (_loc4_ in param1.countByType) {
                _loc5_ = StaticDataManager.getObjectType(_loc4_);
                if (_loc5_.troopsInfo.kindId == param2) {
                    this.addTroops2(_loc4_, param1.countByType[_loc4_]);
                }
            }
        }
    }

    public function addTroops2(param1:int, param2:int):void {
        if (param2 == 0) {
            return;
        }
        if (this.countByType[param1] == null) {
            this.countByType[param1] = param2;
        }
        else {
            this.countByType[param1] = this.countByType[param1] + param2;
        }
        this.dirtyNormalized = true;
    }

    public function canRemove(param1:Troops):Boolean {
        var _loc2_:* = undefined;
        var _loc3_:Number = NaN;
        if (this == param1) {
            return true;
        }
        for (_loc2_ in param1.countByType) {
            _loc3_ = param1.countByType[_loc2_];
            if (_loc3_ > 0 && (this.countByType[_loc2_] == null || this.countByType[_loc2_] < _loc3_)) {
                return false;
            }
        }
        return true;
    }

    public function removeTroops(param1:Troops):void {
        var _loc2_:* = undefined;
        for (_loc2_ in param1.countByType) {
            this.removeTroops2(_loc2_, param1.countByType[_loc2_]);
        }
    }

    public function removeTroops2(param1:int, param2:int):void {
        if (this.countByType[param1] != null) {
            if (this.countByType[param1] < param2) {
                this.countByType[param1] = 0;
            }
            if (this.countByType[param1] == param2) {
                delete this.countByType[param1];
            }
            else {
                this.countByType[param1] = this.countByType[param1] - param2;
            }
            this.dirtyNormalized = true;
        }
    }

    public function scaleTroops(param1:Number):void {
        var _loc2_:* = undefined;
        var _loc3_:Number = NaN;
        if (param1 == 1) {
            return;
        }
        for (_loc2_ in this.countByType) {
            _loc3_ = Math.round(this.countByType[_loc2_] * param1);
            if (_loc3_ == 0) {
                this.countByType.Remove(_loc2_);
            }
            else {
                this.countByType[_loc2_] = _loc3_;
            }
        }
    }

    public function toString():String {
        var _loc2_:* = undefined;
        var _loc3_:Number = NaN;
        var _loc1_:String = "[";
        for (_loc2_ in this.countByType) {
            _loc3_ = this.countByType[_loc2_];
            _loc1_ = _loc1_ + (_loc2_ + ":" + _loc3_ + ",");
        }
        return _loc1_ + "]";
    }

    public function Equal(param1:Troops):Boolean {
        var _loc2_:* = undefined;
        if (!param1) {
            return false;
        }
        if (this.Empty && !param1.Empty || !this.Empty && param1.Empty) {
            return false;
        }
        for (_loc2_ in this.countByType) {
            if (this.countByType[_loc2_] != param1.countByType[_loc2_]) {
                return false;
            }
        }
        return true;
    }

    public function toDto():* {
        var _loc2_:* = undefined;
        var _loc1_:* = {"t": {}};
        for (_loc2_ in this.countByType) {
            _loc1_.t[_loc2_] = this.countByType[_loc2_];
        }
        return _loc1_;
    }
}
}
