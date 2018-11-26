package model.data.scenes.core {
import common.ArrayCustom;
import common.GameType;

import flash.events.TimerEvent;
import flash.geom.Rectangle;
import flash.utils.Timer;

import model.data.scenes.SectorScene;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.BuildingTypeId;
import model.logic.slots.SectorSlotsManager;
import model.logic.slots.SlotKindId;

public class SectorSceneCoreSlots extends SectorSceneCoreDefault {


    private var _pausedY:int;

    private var _pausedX:int;

    private const ALLOW_SLOT_INFO_PRINT:Boolean = false;

    private var id:int = 4500;

    private var type:String = "Decor1";

    private var timer:Timer;

    public function SectorSceneCoreSlots(param1:SectorScene) {
        this._pausedY = -int.MAX_VALUE;
        this._pausedX = -int.MAX_VALUE;
        this.timer = new Timer(1000, 1);
        super(param1);
        _wallAreaDepth = 1;
        _wallOffset = 0;
        _extensionCoef = 18;
        this.timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.showCoords);
    }

    private function showCoords(param1:TimerEvent):void {
        trace("new SlotInfo {Id = " + this.id++ + ", X = " + this._pausedX + ", Y = " + this._pausedY + ", KindId = SlotKindId." + this.type + "},");
    }

    override public function checkTileIsForBuildings(param1:int, param2:int):Boolean {
        return true;
    }

    override public function checkObjectCanBePositioned(param1:GeoSceneObject, param2:GeoSceneObjectType, param3:Boolean, param4:Boolean, param5:Boolean):Boolean {
        if (param1 == null || param2 == null || param2.buildingInfo == null || param1.type.id != param2.id) {
            return false;
        }
        if (this.ALLOW_SLOT_INFO_PRINT) {
            this.timer.reset();
            this.timer.start();
            this._pausedX = param1.left;
            this._pausedY = param1.top;
        }
        return this.checkBuildingWithSlotsPosition(param1, param2, param3, param4, param5);
    }

    override public function getGeoObjectsByPosition(param1:int, param2:int, param3:int, param4:int, param5:Boolean = false):ArrayCustom {
        var _loc7_:GeoSceneObject = null;
        var _loc6_:ArrayCustom = new ArrayCustom();
        for each(_loc7_ in _sectorScene.sceneObjects) {
            if (_loc7_.isOnTiles(param1, param2, param3, param4) && _loc7_.isRoad == param5) {
                _loc6_.addItem(_loc7_);
            }
        }
        return _loc6_;
    }

    private function checkBuildingWithSlotsPosition(param1:GeoSceneObject, param2:GeoSceneObjectType, param3:Boolean, param4:Boolean, param5:Boolean):Boolean {
        var _loc9_:Rectangle = null;
        var _loc10_:int = 0;
        var _loc11_:int = 0;
        var _loc12_:int = 0;
        var _loc13_:GeoSceneObject = null;
        var _loc14_:* = false;
        var _loc15_:Boolean = false;
        var _loc16_:Boolean = false;
        var _loc17_:* = false;
        var _loc18_:ArrayCustom = null;
        var _loc19_:int = 0;
        var _loc20_:GeoSceneObject = null;
        var _loc6_:int = param1.objectType.buildingInfo.slotKindId;
        var _loc7_:Array = this.slotManager.getSlotsAreasByType(_loc6_);
        var _loc8_:int = 0;
        while (_loc8_ < _loc7_.length) {
            _loc9_ = _loc7_[_loc8_].area;
            _loc10_ = _loc7_[_loc8_].id;
            _loc11_ = param1.type.id;
            if (BuildingTypeId.isWall(_loc11_) || BuildingTypeId.isTower(_loc11_)) {
                if (param1.left >= _loc9_.x - 2 && param1.top >= _loc9_.y - 2 && param1.right < _loc9_.width + 2 && param1.bottom < _loc9_.height + 2) {
                    param1.isMirrored = _loc10_ < 4500;
                }
            }
            else if (BuildingTypeId.isGate(_loc11_)) {
                if (param1.left >= _loc9_.x - 6 && param1.top >= _loc9_.y - 6 && param1.right <= _loc9_.width + 6 && param1.bottom <= _loc9_.height + 6) {
                    param1.isMirrored = _loc10_ == 5000;
                }
            }
            _loc12_ = _loc6_ == SlotKindId.DECOR_1 ? 1 : 2;
            if (param1.left >= _loc9_.x - _loc12_ && param1.top >= _loc9_.y - _loc12_ && param1.right < _loc9_.width + _loc12_ && param1.bottom < _loc9_.height + _loc12_) {
                _loc13_ = this.slotManager.getSlotObject(_loc10_);
                _loc14_ = !_loc13_;
                _loc15_ = this.isResources(_loc11_) && param3 && _loc13_ && this.isOreOfNewType(_loc13_.type.id, _loc11_);
                _loc16_ = _loc13_ && _loc13_.slotId != _loc10_;
                _loc17_ = param1.slotId == _loc10_;
                if (_loc14_ || _loc15_ || _loc16_ || _loc17_) {
                    param1.setPosition(_loc9_.x, _loc9_.y);
                    this.slotManager.lastOperationSlotId = _loc10_;
                    return true;
                }
            }
            _loc8_++;
        }
        if (GameType.isSparta && this.isResources(param1.type.id)) {
            _loc18_ = this.slotManager.getSlotsByType(_loc6_);
            _loc19_ = 0;
            while (_loc19_ < _loc18_.length) {
                _loc20_ = _loc18_[_loc19_].gso;
                if (_loc20_ == null) {
                    this.slotManager.lastOperationSlotId = _loc18_[_loc19_].id;
                    return true;
                }
                if (this.isOreOfNewType(_loc20_.type.id, param1.type.id)) {
                    this.slotManager.lastOperationSlotId = _loc18_[_loc19_].id;
                    return true;
                }
                _loc19_++;
            }
        }
        return false;
    }

    private function isResources(param1:int):Boolean {
        return param1 == BuildingTypeId.TitaniumShaft || param1 == BuildingTypeId.UraniumMine || param1 == BuildingTypeId.HousingEstate;
    }

    private function isOreOfNewType(param1:int, param2:int):Boolean {
        var _loc3_:Boolean = false;
        if (param1 == BuildingTypeId.UraniumOre && param2 == BuildingTypeId.UraniumMine) {
            _loc3_ = true;
        }
        else if (param1 == BuildingTypeId.TitaniumOre && param2 == BuildingTypeId.TitaniumShaft) {
            _loc3_ = true;
        }
        else if (param1 == BuildingTypeId.HousingEstateOre && param2 == BuildingTypeId.HousingEstate) {
            _loc3_ = true;
        }
        return _loc3_;
    }

    protected function get slotManager():SectorSlotsManager {
        return SectorSlotsManager.instance;
    }
}
}
