package model.data.scenes {
import common.ArrayCustom;
import common.GameType;

import flash.geom.Rectangle;

import gameObjects.sceneObject.SceneObject;

import model.data.scenes.core.SectorSceneCoreDefault;
import model.data.scenes.core.SectorSceneCoreSlots;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.GeoSceneObjectType;

public class SectorScene extends GeoScene {

    public static const TILE_W:int = 30;

    public static const TILE_H:int = 30;

    private static var _wall_area_depth:int;

    private static var _wall_offset:int;

    private static var _extention_coef:int;


    private var _sectorSceneCore:SectorSceneCoreDefault;

    public function SectorScene(param1:Vector.<SceneObject>, param2:int, param3:int, param4:int, param5:int) {
        this._sectorSceneCore = GameType.isSparta || GameType.isNords ? new SectorSceneCoreSlots(this) : new SectorSceneCoreDefault(this);
        _wall_area_depth = this._sectorSceneCore.wallAreaDepth;
        _wall_offset = this._sectorSceneCore.wallOffset;
        _extention_coef = this._sectorSceneCore.extensionCoef;
        super(param1, param2, param3, param4, param5);
    }

    public static function get WALL_AREA_DEPTH():int {
        return _wall_area_depth;
    }

    public static function get WALL_OFFSET():int {
        return _wall_offset;
    }

    public static function get EXTENTION_COEF():int {
        return _extention_coef;
    }

    public static function getExtensionOffset(param1:int):int {
        return param1 - EXTENTION_COEF;
    }

    public static function fromDto(param1:*, param2:Boolean = false):SectorScene {
        var _loc3_:int = param1.x;
        var _loc4_:int = param1.y;
        var _loc5_:SectorScene = new SectorScene(new Vector.<SceneObject>(), TILE_W, TILE_H, _loc3_, _loc4_);
        _loc5_.mySector = param2;
        fromDtoImpl(_loc5_, param1);
        return _loc5_;
    }

    public function checkTileIsForBuildings(param1:int, param2:int):Boolean {
        return this._sectorSceneCore.checkTileIsForBuildings(param1, param2);
    }

    public function checkTileIsWallsArea(param1:int, param2:int):Boolean {
        return this._sectorSceneCore.checkTileIsWallsArea(param1, param2);
    }

    public function checkTileIsForPlacingWalls(param1:int, param2:int):Boolean {
        return this._sectorSceneCore.checkTileIsForPlacingWalls(param1, param2);
    }

    public function checkTileIsForPlacingWallsLeft(param1:int, param2:int):Boolean {
        return this._sectorSceneCore.checkTileIsForPlacingWallsLeft(param1, param2);
    }

    public function checkTileIsForPlacingWallsRight(param1:int, param2:int):Boolean {
        return this._sectorSceneCore.checkTileIsForPlacingWallsRight(param1, param2);
    }

    public function checkTileIsForPlacingWallsTop(param1:int, param2:int):Boolean {
        return this._sectorSceneCore.checkTileIsForPlacingWallsTop(param1, param2);
    }

    public function checkTileIsForPlacingWallsBottom(param1:int, param2:int):Boolean {
        return this._sectorSceneCore.checkTileIsForPlacingWallsBottom(param1, param2);
    }

    public function getPlacingWallsRect():Rectangle {
        return this._sectorSceneCore.getPlacingWallsRect();
    }

    public function checkObjectCanBePositioned(param1:GeoSceneObject, param2:GeoSceneObjectType, param3:Boolean, param4:Boolean, param5:Boolean):Boolean {
        return this._sectorSceneCore.checkObjectCanBePositioned(param1, param2, param3, param4, param5);
    }

    public function checkBuildingCanBePositioned(param1:GeoSceneObject):Boolean {
        return this._sectorSceneCore.checkBuildingCanBePositioned(param1);
    }

    public function getGeoObjectsByPosition(param1:int, param2:int, param3:int, param4:int, param5:Boolean = false):ArrayCustom {
        return this._sectorSceneCore.getGeoObjectsByPosition(param1, param2, param3, param4, param5);
    }

    protected function checkNewMineCanBePositioned(param1:GeoSceneObject):Boolean {
        return this._sectorSceneCore.checkNewMineCanBePositioned(param1);
    }

    protected function checkWallDecorCanBePositioned(param1:GeoSceneObject, param2:Boolean, param3:Boolean, param4:Boolean):Boolean {
        return this._sectorSceneCore.checkWallDecorCanBePositioned(param1, param2, param3, param4);
    }

    public function getWallForDecor(param1:GeoSceneObject):GeoSceneObject {
        return this._sectorSceneCore.getWallForDecor(param1);
    }

    public function getWallForDecorWithoutRestrictions(param1:GeoSceneObject):GeoSceneObject {
        return this._sectorSceneCore.getWallForDecorWithoutRestrictions(param1);
    }

    private function rotateObjectNearWallIfNeeded(param1:GeoSceneObject, param2:Boolean, param3:Boolean, param4:Boolean):void {
        return this._sectorSceneCore.rotateObjectNearWallIfNeeded(param1, param2, param3, param4);
    }

    protected function checkWallCanBePositioned(param1:GeoSceneObject):Boolean {
        return this._sectorSceneCore.checkWallCanBePositioned(param1);
    }

    override public function dispose():void {
        this._sectorSceneCore = null;
        super.dispose();
    }
}
}
