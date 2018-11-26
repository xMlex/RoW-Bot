package model.logic.chats.notification.helpers {
import flash.utils.Dictionary;

import model.logic.ServerTimeManager;
import model.logic.chats.notification.INotificationTypeHelper;
import model.logic.chats.notification.NotificationHelper;
import model.logic.chats.notification.events.RefreshLocationEvent;

public class RefreshLocationHelper implements INotificationTypeHelper {

    private static var _locations:Dictionary = new Dictionary();


    private var _data:Object;

    private var _needToSendNotification:Boolean;

    public function RefreshLocationHelper(param1:Object) {
        super();
        if (param1 == null) {
            return;
        }
        this._data = param1;
        this.setData();
    }

    private function setData():void {
        if (isNaN(this._data.date)) {
            return;
        }
        if (this._data.date <= ServerTimeManager.serverTimeNow.dateUTC) {
            _locations[this._data.data] = null;
            delete _locations[this._data.data];
            return;
        }
        if (_locations[this._data.data] != null) {
            if (_locations[this._data.data] < this._data.date) {
                _locations[this._data.data] = this._data.date;
                this._needToSendNotification = true;
            }
        }
        else {
            _locations[this._data.data] = this._data.date;
            this._needToSendNotification = true;
        }
    }

    public function execute():void {
        var _loc1_:RefreshLocationEvent = new RefreshLocationEvent(RefreshLocationEvent.REFRESH_LOCATION_EVENT);
        _loc1_.eData = this._data;
        if (this._needToSendNotification) {
            this._needToSendNotification = false;
            NotificationHelper.events.dispatchEvent(_loc1_);
        }
    }

    public function get getData():Object {
        return _locations;
    }
}
}
