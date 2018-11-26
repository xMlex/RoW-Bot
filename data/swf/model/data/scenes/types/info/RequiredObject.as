package model.data.scenes.types.info {
import common.ArrayCustom;

import model.data.scenes.types.GeoSceneObjectType;
import model.logic.StaticDataManager;

public class RequiredObject {


    public var requiredType:int;

    public var typeId:int;

    public var level:int;

    public var count:int;

    public var abTestGroupId:int;

    private var _type:GeoSceneObjectType;

    public function RequiredObject() {
        super();
    }

    public static function fromDto(param1:*):RequiredObject {
        var _loc2_:RequiredObject = new RequiredObject();
        _loc2_.typeId = param1.t;
        _loc2_.requiredType = param1.r;
        _loc2_.level = param1.l;
        _loc2_.count = param1.c;
        _loc2_.abTestGroupId = param1.a != null ? int(param1.a) : -1;
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

    public function get type():GeoSceneObjectType {
        if (this._type == null) {
            this._type = StaticDataManager.getObjectType(this.typeId);
        }
        return this._type;
    }
}
}
