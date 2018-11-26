package model.data.users.notificationPreference {
public class BattlePreferences {


    protected var _attackReports:int;

    protected var _defenceReports:int;

    protected var _reconReports:int;

    public function BattlePreferences() {
        super();
    }

    public static function getFilled():BattlePreferences {
        var _loc1_:BattlePreferences = new BattlePreferences();
        _loc1_._attackReports = BattleReportPreference.All;
        _loc1_._defenceReports = BattleReportPreference.All;
        _loc1_._reconReports = BattleReportPreference.All;
        return _loc1_;
    }

    public static function create(param1:int, param2:int, param3:int):BattlePreferences {
        var _loc4_:BattlePreferences = new BattlePreferences();
        _loc4_._attackReports = param1;
        _loc4_._defenceReports = param2;
        _loc4_._reconReports = param3;
        return _loc4_;
    }

    public static function fromDto(param1:*):BattlePreferences {
        var _loc2_:BattlePreferences = new BattlePreferences();
        _loc2_._attackReports = param1.a;
        _loc2_._defenceReports = param1.d;
        _loc2_._reconReports = param1.r;
        return _loc2_;
    }

    public function get attackReports():int {
        return this._attackReports;
    }

    public function get defenceReports():int {
        return this._defenceReports;
    }

    public function get reconReports():int {
        return this._reconReports;
    }

    public function get isAllActivated():Boolean {
        var _loc1_:Boolean = false;
        _loc1_ = this.attackReports == BattleReportPreference.All && this.defenceReports == BattleReportPreference.All && this.reconReports == BattleReportPreference.All;
        return _loc1_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "a": this._attackReports,
            "d": this._defenceReports,
            "r": this._reconReports
        };
        return _loc1_;
    }
}
}
