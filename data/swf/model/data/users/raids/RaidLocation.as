package model.data.users.raids {
import common.ArrayCustom;

import model.data.map.MapPos;

public class RaidLocation {


    public var id:Number;

    public var typeId:int;

    public var timeAdded:Date;

    public var closed:Boolean;

    public var level:int;

    public var mapPos:MapPos;

    public var strength:int;

    public var storyInfo:RaidLocationStoryInfo;

    public function RaidLocation() {
        super();
    }

    public static function fromDto(param1:*):RaidLocation {
        var _loc2_:RaidLocation = new RaidLocation();
        _loc2_.id = param1.i;
        _loc2_.typeId = param1.t;
        _loc2_.timeAdded = new Date(param1.a);
        _loc2_.closed = param1.f;
        _loc2_.level = param1.l;
        _loc2_.mapPos = MapPos.fromDto(param1.m);
        _loc2_.strength = param1.s;
        _loc2_.storyInfo = !!param1.r ? RaidLocationStoryInfo.fromDto(param1.r) : null;
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
}
}
