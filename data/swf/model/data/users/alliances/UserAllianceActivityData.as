package model.data.users.alliances {
import common.DateUtil;

import model.data.alliances.activityData.AllianceActivityDayHistory;
import model.logic.ServerTimeManager;

public class UserAllianceActivityData {


    private var _lastActivatedBonusFromDay:AllianceActivityDayHistory;

    private var _allianceId:int;

    public function UserAllianceActivityData() {
        super();
    }

    public static function fromDto(param1:*):UserAllianceActivityData {
        var _loc2_:UserAllianceActivityData = new UserAllianceActivityData();
        if (param1.b) {
            _loc2_._lastActivatedBonusFromDay = AllianceActivityDayHistory.fromDto(param1.b);
        }
        return _loc2_;
    }

    public function get lastActivateBonusFromDay():AllianceActivityDayHistory {
        return this._lastActivatedBonusFromDay;
    }

    public function set lastActivateBonusFromDay(param1:AllianceActivityDayHistory):void {
        this._lastActivatedBonusFromDay = param1;
    }

    public function get allianceId():int {
        return this._allianceId;
    }

    public function set allianceId(param1:int):void {
        this._allianceId = param1;
    }

    public function get lastActivateBonusDate():Date {
        return this._lastActivatedBonusFromDay == null ? null : this._lastActivatedBonusFromDay.date;
    }

    public function get isClaimedYesterdayReward():Boolean {
        var _loc1_:Boolean = false;
        var _loc2_:Date = this.lastActivateBonusDate;
        var _loc3_:Date = ServerTimeManager.serverTimeNow;
        _loc3_.time = _loc3_.time - DateUtil.MILLISECONDS_PER_DAY;
        if (_loc2_ != null) {
            _loc1_ = _loc2_.date == _loc3_.date && _loc2_.month == _loc3_.month && _loc2_.fullYear == _loc3_.fullYear;
        }
        return _loc1_;
    }
}
}
