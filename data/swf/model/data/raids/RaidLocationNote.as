package model.data.raids {
import common.ObjectUtil;

import flash.geom.Rectangle;

import model.data.GeneralNote;
import model.data.users.raids.RaidLocation;
import model.data.users.raids.RaidLocationStoryInfo;
import model.logic.RaidLocationNoteManager;

public class RaidLocationNote extends GeneralNote {


    public var typeId:int;

    public var timeAdded:Date;

    public var closed:Boolean;

    public var strength:int;

    public var mapElementRect:Rectangle;

    public var mapImageSource:String;

    public var storyInfo:RaidLocationStoryInfo;

    public function RaidLocationNote() {
        super();
    }

    public static function from(param1:RaidLocation):RaidLocationNote {
        var _loc2_:RaidLocationNote = new RaidLocationNote();
        _loc2_.id = param1.id;
        _loc2_.typeId = param1.typeId;
        _loc2_.timeAdded = param1.timeAdded;
        _loc2_.closed = param1.closed;
        _loc2_.level = param1.level;
        _loc2_.mapPos = param1.mapPos;
        _loc2_.strength = param1.strength;
        _loc2_.storyInfo = param1.storyInfo;
        return _loc2_;
    }

    public function isUpdated():Boolean {
        return RaidLocationNoteManager.getById(id) != this;
    }

    public function clone():RaidLocationNote {
        return ObjectUtil.trueClone(this) as RaidLocationNote;
    }
}
}
