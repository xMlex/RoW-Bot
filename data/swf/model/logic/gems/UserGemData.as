package model.logic.gems {
import common.ArrayCustom;

import gameObjects.observableObject.ObservableObject;

import model.data.scenes.objects.GeoSceneObject;

public class UserGemData extends ObservableObject {

    public static const GEMS_CHANGED:String = "UserGemData_GEMS_CHANGED";


    public var nextObjectId:Number;

    public var gems:ArrayCustom;

    public var activeGems:ArrayCustom;

    public var activeGemsCount:int;

    public var activatedSlots:Array;

    public var dirty:Boolean;

    public function UserGemData() {
        super();
    }

    public static function fromDto(param1:*):UserGemData {
        var _loc2_:UserGemData = new UserGemData();
        _loc2_.nextObjectId = param1.n == null ? Number(1) : Number(param1.n);
        _loc2_.gems = param1.g == null ? new ArrayCustom() : GeoSceneObject.fromDtos2(param1.g);
        _loc2_.activeGems = param1.a == null ? new ArrayCustom() : GeoSceneObject.fromDtos2(param1.a);
        _loc2_.activeGemsCount = param1.s;
        _loc2_.activatedSlots = param1.l == null ? new Array() : param1.l;
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (!this.dirty) {
            return;
        }
        this.dirty = false;
        dispatchEvent(GEMS_CHANGED);
    }
}
}
