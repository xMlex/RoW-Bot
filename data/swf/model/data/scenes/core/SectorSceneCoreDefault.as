package model.data.scenes.core {
import common.ArrayCustom;
import common.GameType;

import configs.Global;

import flash.geom.Point;
import flash.geom.Rectangle;

import gameObjects.sceneObject.SceneObject;

import model.data.scenes.SectorScene;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.BuildingGroupId;
import model.data.scenes.types.info.BuildingTypeId;

public class SectorSceneCoreDefault {


    protected var _sectorScene:SectorScene;

    protected var _wallAreaDepth:int = 13;

    protected var _wallOffset:int = 11;

    protected var _extensionCoef:int = 34;

    public function SectorSceneCoreDefault(param1:SectorScene) {
        super();
        this.initialize(param1);
    }

    public function get wallAreaDepth():int {
        return this._wallAreaDepth;
    }

    public function get wallOffset():int {
        return this._wallOffset;
    }

    public function get extensionCoef():int {
        return this._extensionCoef;
    }

    public function initialize(param1:SectorScene):void {
        this._sectorScene = param1;
    }

    public function checkTileIsForBuildings(param1:int, param2:int):Boolean {
        return param1 >= this._wallAreaDepth && param1 < this._sectorScene.sizeX - this._wallAreaDepth && param2 >= this._wallAreaDepth && param2 < this._sectorScene.sizeY - this._wallAreaDepth;
    }

    public function checkTileIsWallsArea(param1:int, param2:int):Boolean {
        return !this.checkTileIsForBuildings(param1, param2);
    }

    public function checkTileIsForPlacingWalls(param1:int, param2:int):Boolean {
        return false || this.checkTileIsForPlacingWallsLeft(param1, param2) || this.checkTileIsForPlacingWallsRight(param1, param2) || this.checkTileIsForPlacingWallsTop(param1, param2) || this.checkTileIsForPlacingWallsBottom(param1, param2);
    }

    public function checkTileIsForPlacingWallsLeft(param1:int, param2:int):Boolean {
        var _loc3_:Rectangle = this.getPlacingWallsRect();
        var _loc4_:* = param1 == _loc3_.left;
        return _loc4_ && this.checkPointInRect(param1, param2, _loc3_);
    }

    public function checkTileIsForPlacingWallsRight(param1:int, param2:int):Boolean {
        var _loc3_:Rectangle = this.getPlacingWallsRect();
        var _loc4_:* = param1 == _loc3_.right;
        return _loc4_ && this.checkPointInRect(param1, param2, _loc3_);
    }

    public function checkTileIsForPlacingWallsTop(param1:int, param2:int):Boolean {
        var _loc3_:Rectangle = this.getPlacingWallsRect();
        var _loc4_:* = param2 == _loc3_.top;
        return _loc4_ && this.checkPointInRect(param1, param2, _loc3_);
    }

    public function checkTileIsForPlacingWallsBottom(param1:int, param2:int):Boolean {
        var _loc3_:Rectangle = this.getPlacingWallsRect();
        var _loc4_:* = param2 == _loc3_.bottom;
        return _loc4_ && this.checkPointInRect(param1, param2, _loc3_);
    }

    public function getPlacingWallsRect():Rectangle {
        return new Rectangle(this._wallOffset - 1, this._wallOffset - 1, this._sectorScene.sizeX - this._wallOffset * 2 + 1, this._sectorScene.sizeY - this._wallOffset * 2 + 1);
    }

    public function checkObjectCanBePositioned(param1:GeoSceneObject, param2:GeoSceneObjectType, param3:Boolean, param4:Boolean, param5:Boolean):Boolean {
        if (param1 == null || param2 == null || param2.buildingInfo == null || param1.type.id != param2.id) {
            return false;
        }
        if (param3 && (param2.id == BuildingTypeId.UraniumMine || param2.id == BuildingTypeId.TitaniumShaft)) {
            return this.checkNewMineCanBePositioned(param1);
        }
        if (GameType.isMilitary) {
            return this.checkBuildingCanBePositioned(param1);
        }
        switch (param2.buildingInfo.groupId) {
            case BuildingGroupId.DEFENSIVE:
                return this.checkWallCanBePositioned(param1);
            case BuildingGroupId.DECOR_FOR_WALLS:
                return this.checkWallDecorCanBePositioned(param1, param3, param4, param5);
            case BuildingGroupId.DECOR_FOR_SECTOR_AND_WALLS:
                return this.checkWallDecorCanBePositioned(param1, param3, param4, param5) || this.checkBuildingCanBePositioned(param1);
            case BuildingGroupId.DECOR_FOR_SECTOR:
                return this.checkBuildingCanBePositioned(param1);
            default:
                return this.checkBuildingCanBePositioned(param1);
        }
    }

    public function checkBuildingCanBePositioned(param1:GeoSceneObject):Boolean {
        var _loc2_:Boolean = false;
        if (GameType.isElves || GameType.isMilitary || GameType.isTotalDomination || GameType.isPirates) {
            _loc2_ = !this.checkTileIsForBuildings(param1.right, param1.top) || !this.checkTileIsForBuildings(param1.right, param1.bottom) || !this.checkTileIsForBuildings(param1.left, param1.top) || !this.checkTileIsForBuildings(param1.left, param1.bottom) || this.getGeoObjectsByPosition(param1.column, param1.row, param1.sizeX, param1.sizeY, param1.isRoad).length > 1;
            return !_loc2_;
        }
        return this.checkTileIsForBuildings(param1.left, param1.top) && this.checkTileIsForBuildings(param1.left, param1.bottom) && this.checkTileIsForBuildings(param1.right, param1.top) && this.checkTileIsForBuildings(param1.right, param1.bottom) && this.getObjectsByPosition(param1.column, param1.row, param1.sizeX, param1.sizeY).length <= 1;
    }

    public function getGeoObjectsByPosition(param1:int, param2:int, param3:int, param4:int, param5:Boolean = false):ArrayCustom {
        var _loc7_:GeoSceneObject = null;
        var _loc6_:ArrayCustom = new ArrayCustom();
        for each(_loc7_ in this._sectorScene.sceneObjects) {
            if (_loc7_.isOnTiles(param1, param2, param3, param4) && _loc7_.isRoad == param5) {
                _loc6_.addItem(_loc7_);
            }
        }
        return _loc6_;
    }

    public function checkNewMineCanBePositioned(param1:GeoSceneObject):Boolean {
        var _loc4_:SceneObject = null;
        var _loc5_:int = 0;
        var _loc2_:Boolean = this.checkTileIsForBuildings(param1.left, param1.top) && this.checkTileIsForBuildings(param1.left, param1.bottom) && this.checkTileIsForBuildings(param1.right, param1.top) && this.checkTileIsForBuildings(param1.right, param1.bottom);
        if (!_loc2_) {
            return false;
        }
        var _loc3_:ArrayCustom = this.getObjectsByPosition(param1.column, param1.row, param1.sizeX, param1.sizeY);
        if (_loc3_.length == 1) {
            return true;
        }
        if (_loc3_.length != 2) {
            return false;
        }
        for each(_loc4_ in _loc3_) {
            if (_loc4_ != param1) {
                _loc5_ = param1.type.id == BuildingTypeId.UraniumMine ? int(BuildingTypeId.UraniumOre) : int(BuildingTypeId.TitaniumOre);
                return _loc4_.type.id == _loc5_;
            }
        }
        return false;
    }

    public function checkWallDecorCanBePositioned(param1:GeoSceneObject, param2:Boolean, param3:Boolean, param4:Boolean):Boolean {
        this.rotateObjectNearWallIfNeeded(param1, param2, param3, param4);
        return this.getWallForDecor(param1) != null;
    }

    public function getWallForDecor(param1:GeoSceneObject):GeoSceneObject {
        var _loc6_:GeoSceneObject = null;
        var _loc7_:GeoSceneObjectType = null;
        var _loc2_:ArrayCustom = this.getObjectsByPosition(param1.column, param1.row, param1.sizeX, param1.sizeY);
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc5_:GeoSceneObject = null;
        for each(_loc6_ in _loc2_) {
            _loc7_ = _loc6_.type as GeoSceneObjectType;
            if (_loc7_ == null || _loc7_.buildingInfo == null) {
                return null;
            }
            if (_loc7_.buildingInfo.groupId == BuildingGroupId.DEFENSIVE) {
                _loc3_++;
                _loc5_ = _loc6_;
            }
            else {
                _loc4_++;
            }
        }
        if (_loc3_ < 1 || _loc4_ > 1) {
            return null;
        }
        if (this.checkRectInRect(param1.boundsRect, _loc5_.boundsRect)) {
            return _loc5_;
        }
        return null;
    }

    public function getWallForDecorWithoutRestrictions(param1:GeoSceneObject):GeoSceneObject {
        var _loc4_:GeoSceneObject = null;
        var _loc5_:GeoSceneObjectType = null;
        var _loc2_:ArrayCustom = this.getObjectsByPosition(param1.column, param1.row, param1.sizeX, param1.sizeY);
        var _loc3_:GeoSceneObject = null;
        while (true) {
            for each(_loc4_ in _loc2_) {
                _loc5_ = _loc4_.type as GeoSceneObjectType;
                if (_loc5_ == null || _loc5_.buildingInfo == null) {
                    break;
                }
                if (_loc5_.buildingInfo.groupId == BuildingGroupId.DEFENSIVE) {
                    _loc3_ = _loc4_;
                }
                else {
                    continue;
                }
            }
            if (_loc3_ && this.checkRectInRect(param1.boundsRect, _loc3_.boundsRect)) {
                return _loc3_;
            }
            return null;
        }
        return null;
    }

    public function rotateObjectNearWallIfNeeded(param1:GeoSceneObject, param2:Boolean, param3:Boolean, param4:Boolean):void {
        var _loc5_:ArrayCustom = null;
        var _loc6_:Point = null;
        var _loc7_:Boolean = false;
        if (param1.sizeX != param1.sizeY) {
            _loc5_ = param1.getObjectTiles();
            for each(_loc6_ in _loc5_) {
                if (this.checkTileIsForPlacingWallsRight(_loc6_.x, _loc6_.y) || this.checkTileIsForPlacingWallsLeft(_loc6_.x, _loc6_.y)) {
                    if (param1.sizeX > param1.sizeY) {
                        param1.isMirrored = !param1.isMirrored;
                    }
                }
                if (this.checkTileIsForPlacingWallsTop(_loc6_.x, _loc6_.y) || this.checkTileIsForPlacingWallsBottom(_loc6_.x, _loc6_.y)) {
                    if (param1.sizeX < param1.sizeY) {
                        param1.isMirrored = !param1.isMirrored;
                    }
                }
            }
        }
        else if (param1.objectType.isTurret && (param2 || param4)) {
            _loc5_ = param1.getObjectTiles();
            _loc7_ = GameType.isPirates;
            for each(_loc6_ in _loc5_) {
                if (this.checkTileIsForPlacingWallsRight(_loc6_.x, _loc6_.y) || this.checkTileIsForPlacingWallsLeft(_loc6_.x, _loc6_.y)) {
                    param1.isMirrored = _loc7_;
                }
                if (this.checkTileIsForPlacingWallsTop(_loc6_.x, _loc6_.y) || this.checkTileIsForPlacingWallsBottom(_loc6_.x, _loc6_.y)) {
                    param1.isMirrored = !_loc7_;
                }
            }
        }
        else if (Global.WALLS_10LVL_ENABLED && this.needRotate(param1)) {
            _loc5_ = param1.getObjectTiles();
            for each(_loc6_ in _loc5_) {
                if (this.checkTileIsForPlacingWallsRight(_loc6_.x, _loc6_.y) || this.checkTileIsForPlacingWallsLeft(_loc6_.x, _loc6_.y)) {
                    param1.isMirrored = false;
                }
                if (this.checkTileIsForPlacingWallsTop(_loc6_.x, _loc6_.y) || this.checkTileIsForPlacingWallsBottom(_loc6_.x, _loc6_.y)) {
                    param1.isMirrored = true;
                }
            }
        }
    }

    private function needRotate(param1:GeoSceneObject):Boolean {
        return BuildingTypeId.isTowerBigLevel(param1.objectType.id);
    }

    public function checkWallCanBePositioned(param1:GeoSceneObject):Boolean {
        var _loc7_:Point = null;
        var _loc8_:ArrayCustom = null;
        var _loc9_:ArrayCustom = null;
        this.rotateObjectNearWallIfNeeded(param1, false, false, false);
        var _loc2_:Boolean = false;
        var _loc3_:ArrayCustom = param1.getObjectLeftTiles();
        var _loc4_:ArrayCustom = param1.getObjectRightTiles();
        var _loc5_:ArrayCustom = param1.getObjectTopTiles();
        var _loc6_:ArrayCustom = param1.getObjectBottomTiles();
        if (param1.sizeX > param1.sizeY) {
            _loc4_.removeAll();
            _loc3_.removeAll();
        }
        else if (param1.sizeY > param1.sizeX) {
            _loc5_.removeAll();
            _loc6_.removeAll();
        }
        for each(_loc7_ in _loc3_) {
            if (this.checkTileIsForPlacingWallsRight(_loc7_.x, _loc7_.y)) {
                _loc2_ = true;
            }
        }
        for each(_loc7_ in _loc4_) {
            if (this.checkTileIsForPlacingWallsLeft(_loc7_.x, _loc7_.y)) {
                _loc2_ = true;
            }
        }
        for each(_loc7_ in _loc5_) {
            if (this.checkTileIsForPlacingWallsBottom(_loc7_.x, _loc7_.y)) {
                _loc2_ = true;
            }
        }
        for each(_loc7_ in _loc6_) {
            if (this.checkTileIsForPlacingWallsTop(_loc7_.x, _loc7_.y)) {
                _loc2_ = true;
            }
        }
        _loc8_ = new ArrayCustom();
        _loc9_ = this.getObjectsByPosition(param1.column, param1.row, param1.sizeX, param1.sizeY);
        for each(param1 in _loc9_) {
            if (!(param1 != null && param1.objectType != null && param1.objectType.buildingInfo != null && BuildingGroupId.checkCanBeOnWalls(param1.objectType.buildingInfo.groupId))) {
                _loc8_.addItem(param1);
            }
        }
        return _loc2_ && _loc8_.length <= 1;
    }

    public function getObjectsByPosition(param1:int, param2:int, param3:int, param4:int):ArrayCustom {
        return this._sectorScene.getObjectsByPosition(param1, param2, param3, param4);
    }

    public function checkRectInRect(param1:Rectangle, param2:Rectangle):Boolean {
        return this.gameSceneCheckRectInRect(param1, param2);
    }

    private function gameSceneCheckRectInRect(param1:Rectangle, param2:Rectangle):Boolean {
        return this.checkPointInRect(param1.left, param1.top, param2) && this.checkPointInRect(param1.right, param1.top, param2) && this.checkPointInRect(param1.left, param1.bottom, param2) && this.checkPointInRect(param1.right, param1.bottom, param2);
    }

    public function checkPointInRect(param1:int, param2:int, param3:Rectangle):Boolean {
        return this.gameSceneCheckPointInRect(param1, param2, param3);
    }

    public function gameSceneCheckPointInRect(param1:int, param2:int, param3:Rectangle):Boolean {
        return param1 >= param3.left && param1 <= param3.right && param2 >= param3.top && param2 <= param3.bottom;
    }
}
}
