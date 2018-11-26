package model.data.users.notificationPreference {
public class UserNotificationPreferences {


    protected var _enabled:Boolean;

    protected var _battle:BattlePreferences;

    public function UserNotificationPreferences() {
        super();
    }

    public static function getFilled():UserNotificationPreferences {
        var _loc1_:UserNotificationPreferences = new UserNotificationPreferences();
        _loc1_._enabled = true;
        _loc1_._battle = BattlePreferences.getFilled();
        return _loc1_;
    }

    public static function create(param1:Boolean, param2:BattlePreferences):UserNotificationPreferences {
        var _loc3_:UserNotificationPreferences = new UserNotificationPreferences();
        _loc3_._enabled = param1;
        _loc3_._battle = param2;
        return _loc3_;
    }

    public static function fromDto(param1:*):UserNotificationPreferences {
        var _loc2_:UserNotificationPreferences = new UserNotificationPreferences();
        _loc2_._enabled = param1.e;
        _loc2_._battle = !!param1.b ? BattlePreferences.fromDto(param1.b) : null;
        return _loc2_;
    }

    public function get enabled():Boolean {
        return this._enabled;
    }

    public function get battle():BattlePreferences {
        return this._battle;
    }

    public function get isAllActivated():Boolean {
        var _loc1_:Boolean = this._enabled;
        if (this._battle != null && !this._battle.isAllActivated) {
            _loc1_ = false;
        }
        return _loc1_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "e": this._enabled,
            "b": (!!this._battle ? this._battle.toDto() : null)
        };
        return _loc1_;
    }
}
}
