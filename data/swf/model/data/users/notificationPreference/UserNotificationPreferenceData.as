package model.data.users.notificationPreference {
import flash.utils.Dictionary;

import model.logic.commands.gameSettings.PreferenceByCategory;

public class UserNotificationPreferenceData {


    private var _preferences:Dictionary;

    private var _isAllActivate:Boolean;

    private var _isAllDeactivate:Boolean;

    public function UserNotificationPreferenceData() {
        super();
    }

    public static function fromDto(param1:*):UserNotificationPreferenceData {
        var _loc4_:* = undefined;
        var _loc5_:Object = null;
        var _loc6_:UserNotificationPreferences = null;
        var _loc2_:UserNotificationPreferenceData = new UserNotificationPreferenceData();
        _loc2_._preferences = new Dictionary();
        var _loc3_:int = 0;
        _loc2_._isAllActivate = true;
        _loc2_._isAllDeactivate = true;
        if (param1.p) {
            for (_loc4_ in param1.p) {
                _loc5_ = param1.p[_loc4_];
                _loc6_ = !!_loc5_ ? UserNotificationPreferences.fromDto(_loc5_) : null;
                _loc2_._preferences[_loc4_] = _loc6_;
                _loc3_++;
                if (_loc6_.isAllActivated) {
                    _loc2_._isAllDeactivate = false;
                }
                else {
                    _loc2_._isAllActivate = false;
                }
            }
        }
        return _loc2_;
    }

    public function get isAllActivate():Boolean {
        return this._isAllActivate;
    }

    public function get isAllDeactivate():Boolean {
        return this._isAllDeactivate;
    }

    public function getPreferenceByKey(param1:int):UserNotificationPreferences {
        var _loc2_:UserNotificationPreferences = this._preferences[param1];
        return _loc2_;
    }

    public function get preferences():Dictionary {
        return this._preferences;
    }

    public function updatePreference(param1:Array):void {
        var _loc4_:PreferenceByCategory = null;
        var _loc5_:int = 0;
        var _loc6_:* = undefined;
        var _loc7_:UserNotificationPreferences = null;
        if (!param1) {
            return;
        }
        this._preferences = new Dictionary();
        var _loc2_:int = 0;
        this._isAllActivate = true;
        this._isAllDeactivate = true;
        var _loc3_:int = 0;
        while (_loc3_ < param1.length) {
            _loc4_ = param1[_loc3_];
            _loc5_ = _loc4_.getCategory();
            _loc6_ = _loc4_.getPreference();
            _loc7_ = !!_loc6_ ? UserNotificationPreferences.fromDto(_loc6_) : null;
            this._preferences[_loc5_] = _loc7_;
            _loc2_++;
            if (_loc7_.isAllActivated) {
                this._isAllDeactivate = false;
            }
            else {
                this._isAllActivate = false;
            }
            _loc3_++;
        }
    }
}
}
