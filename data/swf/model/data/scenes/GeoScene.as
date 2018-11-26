package model.data.scenes {
import common.ArrayCustom;

import gameObjects.GameScene;
import gameObjects.sceneObject.SceneObject;

import model.data.scenes.objects.GeoSceneObject;

public class GeoScene extends GameScene {


    public function GeoScene(param1:Vector.<SceneObject>, param2:int, param3:int, param4:int, param5:int) {
        super(param1, param2, param3, param4, param5);
    }

    public static function fromDto(param1:*):GeoScene {
        var _loc2_:int = param1.x;
        var _loc3_:int = param1.y;
        var _loc4_:GeoScene = new GeoScene(new Vector.<SceneObject>(), 30, 30, _loc2_, _loc3_);
        fromDtoImpl(_loc4_, param1);
        return _loc4_;
    }

    protected static function fromDtoImpl(param1:GeoScene, param2:*):void {
        var _loc4_:GeoSceneObject = null;
        var _loc3_:Vector.<SceneObject> = GeoSceneObject.fromDtos(param2.o);
        for each(_loc4_ in _loc3_) {
            param1.sceneObjectAdd(_loc4_);
        }
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
        var _loc3_:GeoScene = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function dispatchEvents():void {
        var _loc1_:GeoSceneObject = null;
        for each(_loc1_ in sceneObjects) {
            _loc1_.dispatchEvents();
        }
    }

    public function toDto():* {
        var _loc1_:* = {
            "x": sizeX,
            "y": sizeY,
            "o": GeoSceneObject.toDtos(sceneObjects)
        };
        return _loc1_;
    }
}
}
