package model.logic.chats.notification.objects.allianceCity {
public class AllianceNotification {


    public var type:int;

    public var data:AllianceNotificationData;

    public function AllianceNotification() {
        super();
    }

    public static function fromDto(param1:*):AllianceNotification {
        var _loc2_:AllianceNotification = new AllianceNotification();
        _loc2_.type = param1.t;
        _loc2_.data = param1.d == null ? new AllianceNotificationData() : AllianceNotificationData.fromDto(param1.d);
        return _loc2_;
    }

    public static function fromDtos(param1:*):Vector.<AllianceNotification> {
        var _loc3_:* = undefined;
        var _loc2_:Vector.<AllianceNotification> = new Vector.<AllianceNotification>();
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
