package model.data.alliances {
import common.ArrayCustom;

import flash.utils.Dictionary;

public class AllianceMission {

    public static const MISSION_STATE_IN_PROGRESS:int = 5;

    public static const MISSION_STATE_INTRO_SHOWN:int = 6;

    public static const MISSION_STATE_COMPLETING:int = 8;

    public static const MISSION_STATE_COMPLETED:int = 9;

    public static const MISSION_STATE_OUTRO_SHOWN:int = 10;


    public var id:Number;

    public var groupId:int;

    public var missionState:int;

    public var statsType:int;

    public var dateFrom:Date;

    public var dateTo:Date;

    public var value:Number;

    public var valueByUser:Dictionary;

    public var valueByUserEmpty:Boolean = true;

    public var stepsCompleteTimes:Dictionary;

    public function AllianceMission() {
        super();
    }

    public static function fromDto(param1:*):AllianceMission {
        var _loc3_:* = undefined;
        var _loc4_:* = undefined;
        var _loc2_:AllianceMission = new AllianceMission();
        _loc2_.id = param1.i;
        _loc2_.groupId = param1.g;
        _loc2_.missionState = param1.a;
        _loc2_.statsType = param1.s;
        _loc2_.dateFrom = param1.f == null ? new Date() : new Date(param1.f);
        _loc2_.dateTo = param1.t == null ? new Date() : new Date(param1.t);
        _loc2_.value = param1.v;
        if (param1.u) {
            _loc2_.valueByUser = new Dictionary();
            for (_loc3_ in param1.u) {
                _loc2_.valueByUserEmpty = false;
                _loc2_.valueByUser[_loc3_] = param1.u[_loc3_];
            }
        }
        if (param1.c) {
            _loc2_.stepsCompleteTimes = new Dictionary();
            for (_loc4_ in param1.c) {
                _loc2_.stepsCompleteTimes[_loc4_] = new Date(param1.c[_loc4_]);
            }
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

    public function cloneMission():AllianceMission {
        var _loc2_:* = undefined;
        var _loc3_:* = undefined;
        var _loc1_:AllianceMission = new AllianceMission();
        _loc1_.id = this.id;
        _loc1_.groupId = this.groupId;
        _loc1_.missionState = this.missionState;
        _loc1_.statsType = this.statsType;
        _loc1_.dateFrom = this.dateFrom;
        _loc1_.dateTo = this.dateTo;
        _loc1_.value = this.value;
        _loc1_.valueByUser = new Dictionary();
        for (_loc2_ in this.valueByUser) {
            _loc1_.valueByUser[_loc2_] = this.valueByUser[_loc2_];
        }
        _loc1_.valueByUserEmpty = this.valueByUserEmpty;
        _loc1_.stepsCompleteTimes = new Dictionary();
        for (_loc3_ in this.stepsCompleteTimes) {
            _loc1_.stepsCompleteTimes[_loc3_] = this.stepsCompleteTimes[_loc3_];
        }
        return _loc1_;
    }
}
}
