package model.data.users.raids {
import common.ArrayCustom;

import flash.utils.Dictionary;

import model.logic.RaidLocationType;

public class RaidLocationStoryType {


    public var storyId:int;

    public var steps:ArrayCustom;

    public var raidLocationTypes:ArrayCustom;

    public var startingLocationLevel:int;

    public var storyName:String;

    public var storyName2:String;

    public var storyStartLocationLevel:int;

    public var stepById:Dictionary;

    public function RaidLocationStoryType() {
        this.stepById = new Dictionary();
        super();
    }

    public static function fromDto(param1:*):RaidLocationStoryType {
        var _loc3_:RaidLocationStoryTypeStep = null;
        var _loc2_:RaidLocationStoryType = new RaidLocationStoryType();
        _loc2_.storyId = param1.i;
        _loc2_.steps = RaidLocationStoryTypeStep.fromDtos(param1.s);
        _loc2_.raidLocationTypes = param1.r == null ? new ArrayCustom() : RaidLocationType.fromDtos(param1.r);
        _loc2_.startingLocationLevel = param1.l;
        _loc2_.storyName = !!param1.n.c ? param1.n.c : "";
        _loc2_.storyName2 = !!param1.z ? param1.z.c : "";
        _loc2_.storyStartLocationLevel = !!param1.l ? int(param1.l) : 0;
        for each(_loc3_ in _loc2_.steps) {
            _loc2_.stepById[_loc3_.stepId] = _loc3_;
        }
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

    public function getStepIndex(param1:int):int {
        var _loc2_:RaidLocationStoryTypeStep = null;
        for each(_loc2_ in this.steps) {
            if (_loc2_.stepId == param1) {
                return this.steps.getItemIndex(_loc2_) + 1;
            }
        }
        return -1;
    }
}
}
