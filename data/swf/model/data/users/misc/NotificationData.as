package model.data.users.misc {
public class NotificationData {


    public var notificationSettings:NotificationSettings;

    public function NotificationData() {
        super();
    }

    public static function fromDto(param1:*):NotificationData {
        var _loc2_:NotificationData = new NotificationData();
        _loc2_.notificationSettings = !!param1.q ? NotificationSettings.fromDto(param1.q) : null;
        return _loc2_;
    }
}
}
