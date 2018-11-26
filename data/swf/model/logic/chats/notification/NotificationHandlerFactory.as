package model.logic.chats.notification {
import flash.utils.Dictionary;

import model.logic.chats.notification.handlers.AllianceCityNotificationHandlerFactory;
import model.logic.chats.notification.handlers.UserNotificationHandlerFactory;

public class NotificationHandlerFactory {

    private static var _initialised:Boolean;

    private static var _dictionaryHandlers:Dictionary;


    public function NotificationHandlerFactory() {
        super();
    }

    private static function initializeData():void {
        _initialised = true;
        _dictionaryHandlers = new Dictionary();
        _dictionaryHandlers[MainNotificationType.USER] = new UserNotificationHandlerFactory();
        _dictionaryHandlers[MainNotificationType.ALLIANCE_CITY] = new AllianceCityNotificationHandlerFactory();
    }

    public static function getHandler(param1:int):INotificationHelper {
        if (!_initialised) {
            initializeData();
        }
        if (!_dictionaryHandlers[param1]) {
            throw new Error("BoostBehaviour - do not have builder for typeId = " + param1);
        }
        return _dictionaryHandlers[param1];
    }
}
}
