package model.data.alliances.activityData {
import common.DateUtil;
import common.queries.util.query;

import configs.Global;

import gameObjects.observableObject.ObservableObject;

import model.logic.AllianceManager;
import model.logic.ServerTimeManager;

public class AllianceActivityData extends ObservableObject {

    public static const CLASS_NAME:String = "AllianceActivityData";

    public static const DATA_CHANGED:String = CLASS_NAME + "_DataChanged";


    private var _dirty:Boolean;

    private var _lastActivityDate:Date;

    private var _history:Array;

    public function AllianceActivityData() {
        super();
    }

    public static function fromDto(param1:*):AllianceActivityData {
        var _loc3_:AllianceActivityDayHistory = null;
        var _loc4_:* = undefined;
        var _loc2_:AllianceActivityData = new AllianceActivityData();
        _loc2_._lastActivityDate = param1.a == null ? null : new Date(param1.a);
        if (param1.h != null) {
            _loc2_._history = [];
            for each(_loc4_ in param1.h) {
                _loc3_ = AllianceActivityDayHistory.fromDto(_loc4_);
                _loc2_._history.push(_loc3_);
            }
        }
        return _loc2_;
    }

    public function get lastActivityDate():Date {
        return this._lastActivityDate;
    }

    public function get history():Array {
        return this._history;
    }

    public function update(param1:AllianceActivityData):void {
        if (param1 == null) {
            return;
        }
        this._lastActivityDate = param1._lastActivityDate;
        this._history = param1._history;
        this._dirty = true;
    }

    public function dispatchEvents():void {
        if (this._dirty) {
            this._dirty = false;
            dispatchEvent(DATA_CHANGED);
        }
    }

    public function get isShutdown():Boolean {
        return Global.REMOVE_INACTIVE_ALLIANCE_ENABLED && !AllianceManager.isAllianceInDeletingProcess() && this._lastActivityDate != null && !ServerTimeManager.isToday(this._lastActivityDate);
    }

    public function get shutdownTime():Date {
        var _loc1_:Date = null;
        if (this._lastActivityDate != null) {
            _loc1_ = new Date(this._lastActivityDate.time);
            _loc1_.date = _loc1_.date + (Global.ALLIANCE_SHUTDOWN_DAYS_DELAY + 1);
        }
        return _loc1_;
    }

    public function get yesterdayActivityHistory():AllianceActivityDayHistory {
        var yesterdayDate:Date = null;
        yesterdayDate = ServerTimeManager.serverTimeNow;
        yesterdayDate.time = yesterdayDate.time - DateUtil.MILLISECONDS_PER_DAY;
        return query(this._history).firstOrDefault(function (param1:AllianceActivityDayHistory):Boolean {
            return param1.date.date == yesterdayDate.date && param1.date.month == yesterdayDate.month && param1.date.fullYear == yesterdayDate.fullYear;
        });
    }

    public function get todayActivityHistory():AllianceActivityDayHistory {
        return query(this._history).firstOrDefault(function (param1:AllianceActivityDayHistory):Boolean {
            return ServerTimeManager.isToday(param1.date);
        });
    }
}
}
