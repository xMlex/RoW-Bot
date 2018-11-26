package model.data.users {
import model.data.users.notificationPreference.UserNotificationPreferenceData;

public class UserUIData {


    public var notificationSetting:UserNotificationPreferenceData;

    public function UserUIData() {
        super();
    }

    public static function fromDto(param1:*):UserUIData {
        var _loc2_:UserUIData = new UserUIData();
        _loc2_.notificationSetting = !!param1.n ? UserNotificationPreferenceData.fromDto(param1.n) : null;
        return _loc2_;
    }
}
}
