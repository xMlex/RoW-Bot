package model.data.alliances.activityData {
public class AllianceActivityDayHistory {


    private var _data:Date;

    private var _allianceSize:int;

    private var _activityPercent:int;

    private var _closed:Boolean;

    public function AllianceActivityDayHistory() {
        super();
    }

    public static function fromDto(param1:*):AllianceActivityDayHistory {
        var _loc2_:AllianceActivityDayHistory = new AllianceActivityDayHistory();
        _loc2_._data = param1.d == null ? null : new Date(param1.d);
        _loc2_._allianceSize = param1.s;
        _loc2_._activityPercent = param1.a;
        _loc2_._closed = param1.c;
        return _loc2_;
    }

    public function get date():Date {
        return this._data;
    }

    public function get allianceSize():int {
        return this._allianceSize;
    }

    public function get activityPercent():int {
        return this._activityPercent;
    }

    public function get closed():Boolean {
        return this._closed;
    }

    public function toDto():* {
        var _loc1_:* = {
            "d": this._data.time,
            "s": this._allianceSize,
            "a": this._activityPercent,
            "c": this._closed
        };
        return _loc1_;
    }
}
}
