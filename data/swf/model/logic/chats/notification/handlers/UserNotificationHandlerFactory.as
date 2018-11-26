package model.logic.chats.notification.handlers {
import json.JSONOur;

import model.logic.chats.ChatMessage;
import model.logic.chats.notification.INotificationHelper;
import model.logic.chats.notification.INotificationTypeHelper;
import model.logic.chats.notification.helpers.RefreshLocationHelper;
import model.logic.chats.notification.objects.NotificationMessageObject;
import model.logic.chats.notification.types.UserNotificationType;

public class UserNotificationHandlerFactory implements INotificationHelper {


    private var _notificationHelper:INotificationTypeHelper;

    public function UserNotificationHandlerFactory() {
        super();
    }

    public function findHandler(param1:ChatMessage):void {
        var _loc2_:NotificationMessageObject = this.notificationDataConvert(param1.text);
        switch (_loc2_.type) {
            case UserNotificationType.REFRESH_LOCATION:
                this._notificationHelper = RefreshLocationHelper(_loc2_);
            default:
                this._notificationHelper = RefreshLocationHelper(_loc2_);
        }
    }

    public function execute():void {
        this._notificationHelper.execute();
    }

    public function executeCash():void {
    }

    private function notificationDataConvert(param1:String):NotificationMessageObject {
        var _loc2_:NotificationMessageObject = new NotificationMessageObject();
        var _loc3_:* = JSONOur.decode(param1);
        _loc2_.type = _loc3_.t;
        _loc2_.data = _loc3_.i;
        _loc2_.date = _loc3_.d;
        return _loc2_;
    }
}
}
