package model.data.users.misc {
import common.ArrayCustom;

public class NotificationSettings {


    public var isAutomatic:Boolean;

    public var settings:ArrayCustom;

    public function NotificationSettings() {
        super();
    }

    public static function fromDto(param1:Object):NotificationSettings {
        var _loc2_:NotificationSettings = new NotificationSettings();
        _loc2_.isAutomatic = Boolean(param1.q);
        _loc2_.settings = new ArrayCustom(param1.w);
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "q": int(this.isAutomatic),
            "w": this.settings
        };
        return _loc1_;
    }
}
}
