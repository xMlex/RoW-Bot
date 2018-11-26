package model.data.scenes {
import gameObjects.sceneObject.SceneObject;

import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.GeoSceneObjectType;

public class WarCampScene extends GeoScene {

    public static const TILE_W:int = 20;

    public static const TILE_H:int = 20;


    public function WarCampScene(param1:Vector.<SceneObject>, param2:int, param3:int, param4:int, param5:int) {
        super(param1, param2, param3, param4, param5);
    }

    public static function fromDto(param1:*):WarCampScene {
        var _loc2_:int = param1.x;
        var _loc3_:int = param1.y;
        var _loc4_:WarCampScene = new WarCampScene(new Vector.<SceneObject>(), TILE_W, TILE_H, _loc2_, _loc3_);
        fromDtoImpl(_loc4_, param1);
        return _loc4_;
    }

    public function checkTileIsForUnits(param1:int, param2:int):Boolean {
        return param1 >= SectorScene.WALL_AREA_DEPTH && param1 < sizeX - SectorScene.WALL_AREA_DEPTH && param2 >= SectorScene.WALL_AREA_DEPTH && param2 < sizeY - SectorScene.WALL_AREA_DEPTH;
    }

    public function checkTileIsWallsArea(param1:int, param2:int):Boolean {
        return !this.checkTileIsForUnits(param1, param2);
    }

    public function checkObjectCanBePositioned(param1:GeoSceneObject):Boolean {
        if (param1 == null) {
            return false;
        }
        var _loc2_:GeoSceneObjectType = param1.type as GeoSceneObjectType;
        if (_loc2_ == null || _loc2_.troopsInfo == null) {
            return false;
        }
        return this.checkUnitCanBePositioned(param1);
    }

    protected function checkUnitCanBePositioned(param1:GeoSceneObject):Boolean {
        return this.checkTileIsForUnits(param1.left, param1.top) && this.checkTileIsForUnits(param1.left, param1.bottom) && this.checkTileIsForUnits(param1.right, param1.top) && this.checkTileIsForUnits(param1.right, param1.bottom) && getObjectsByPosition(param1.column, param1.row, param1.sizeX, param1.sizeY).length <= 1;
    }
}
}
