package model.data.users.drawings {
import common.ArrayCustom;

import gameObjects.observableObject.ObservableObject;
import gameObjects.sceneObject.SceneObject;

import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.GeoSceneObjectType;
import model.logic.StaticDataManager;

public class DrawingArchive extends ObservableObject {

    public static const DRAWING_PARTS_CHANGED:String = "DrawingArchive_DRAWING_PART_CHANGED";

    public static const DRAWING_CLICKS_CHANGED:String = "DrawingArchive_DRAWING_CLICKS_CHANGED";


    public var drawings:Vector.<SceneObject>;

    public var clicksForUserIds:ArrayCustom;

    public var clicksFromUserIds:ArrayCustom;

    public var lastClickDateByOtherUser:Date;

    public var currentClicksCount:int;

    public var addedDrawingPartsForClicks:ArrayCustom;

    public var clicksDirty:Boolean = false;

    public function DrawingArchive() {
        super();
    }

    public static function fromDto(param1:*):DrawingArchive {
        var _loc3_:GeoSceneObjectType = null;
        if (param1 == null) {
            return null;
        }
        var _loc2_:DrawingArchive = new DrawingArchive();
        _loc2_.drawings = GeoSceneObject.fromDtos(param1.d);
        _loc2_.clicksForUserIds = new ArrayCustom(param1.c);
        _loc2_.clicksFromUserIds = new ArrayCustom(param1.o);
        _loc2_.lastClickDateByOtherUser = param1.y == null ? null : new Date(param1.y);
        _loc2_.currentClicksCount = param1.x;
        _loc2_.addedDrawingPartsForClicks = DrawingPart.fromDtos(param1.a);
        for each(_loc3_ in StaticDataManager.types) {
            if (_loc3_.drawingInfo != null) {
                if (_loc2_.getDrawing(_loc3_.id) == null) {
                    _loc2_.addDrawing(GeoSceneObject.makeDrawing(_loc3_));
                }
            }
        }
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (!this.clicksDirty) {
            return;
        }
        this.clicksDirty = false;
        dispatchEvent(DRAWING_CLICKS_CHANGED);
    }

    public function addDrawing(param1:GeoSceneObject):void {
        if (this.getDrawing(param1.type.id) != null) {
            throw new Error("Drawing is already added");
        }
        this.drawings.push(param1);
    }

    public function addDrawingPart(param1:DrawingPart):void {
        var _loc2_:GeoSceneObject = this.getDrawing(param1.typeId);
        if (_loc2_ == null) {
            _loc2_ = GeoSceneObject.makeDrawing(StaticDataManager.getObjectType(param1.typeId));
            this.addDrawing(_loc2_);
        }
        _loc2_.drawingInfo.drawingParts[param1.part]++;
        this.raiseDrawingPartsChanged();
    }

    public function removeDrawingPart(param1:DrawingPart):void {
        var _loc2_:GeoSceneObject = this.getDrawing(param1.typeId);
        if (_loc2_ == null) {
            return;
        }
        if (_loc2_.drawingInfo.drawingParts[param1.part] <= 0) {
            return;
        }
        _loc2_.drawingInfo.drawingParts[param1.part]--;
        this.raiseDrawingPartsChanged();
    }

    public function getDrawing(param1:int):GeoSceneObject {
        var _loc2_:GeoSceneObject = null;
        for each(_loc2_ in this.drawings) {
            if (_loc2_.type.id == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public function hasCompleteDrawing(param1:int):Boolean {
        var _loc2_:GeoSceneObject = null;
        for each(_loc2_ in this.drawings) {
            if (_loc2_.type.id == param1 && _loc2_.getLevel() == 1) {
                return true;
            }
        }
        return false;
    }

    public function raiseDrawingPartsChanged():void {
        dispatchEvent(DRAWING_PARTS_CHANGED);
    }

    public function getDrawingsForTransfer():Vector.<SceneObject> {
        var _loc2_:GeoSceneObject = null;
        var _loc1_:Vector.<SceneObject> = new Vector.<SceneObject>();
        for each(_loc2_ in this.drawings) {
            if (_loc2_.drawingInfo.partsCollected > 0) {
                _loc1_.push(_loc2_);
            }
        }
        return _loc1_;
    }

    public function getTotalPartsCollected():int {
        var _loc2_:GeoSceneObject = null;
        var _loc3_:int = 0;
        var _loc1_:int = 0;
        for each(_loc2_ in this.drawings) {
            _loc3_ = 0;
            while (_loc3_ < _loc2_.drawingInfo.drawingParts.length) {
                _loc1_ = _loc1_ + _loc2_.drawingInfo.drawingParts[_loc3_];
                _loc3_++;
            }
        }
        return _loc1_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "d": GeoSceneObject.toDtos(this.drawings),
            "c": this.clicksForUserIds,
            "o": this.clicksFromUserIds,
            "y": this.lastClickDateByOtherUser,
            "x": this.currentClicksCount,
            "a": DrawingPart.toDtos(this.addedDrawingPartsForClicks)
        };
        return _loc1_;
    }
}
}
