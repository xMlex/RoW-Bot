package model.data.alliances {
import common.DateUtil;

import gameObjects.observableObject.ObservableObject;

import model.logic.ServerTimeManager;

public class AllianceMessageData extends ObservableObject {

    public static const CLASS_NAME:String = "AllianceMessageData";

    public static const MESSAGE_DATA_CHANGED:String = CLASS_NAME + "MessageDataChanged";


    public var MessageSentDate:Date;

    public var LeaderDailyMessagesSent:int = 0;

    public var DeputiesDailyMessagesSent:int = 0;

    public var dirty:Boolean = false;

    public function AllianceMessageData() {
        this.MessageSentDate = new Date();
        super();
    }

    public static function fromDto(param1:*):AllianceMessageData {
        var _loc2_:AllianceMessageData = new AllianceMessageData();
        _loc2_.MessageSentDate = param1.t == null ? null : new Date(param1.t);
        _loc2_.LeaderDailyMessagesSent = param1.l == null ? int(_loc2_.LeaderDailyMessagesSent = 0) : int(param1.l);
        _loc2_.DeputiesDailyMessagesSent = param1.d == null ? int(_loc2_.DeputiesDailyMessagesSent = 0) : int(param1.d);
        if (_loc2_.MessageSentDate == null || DateUtil.getDatePart(_loc2_.MessageSentDate).toString() != DateUtil.getDatePart(ServerTimeManager.serverTimeNow).toString()) {
            _loc2_.LeaderDailyMessagesSent = 0;
            _loc2_.DeputiesDailyMessagesSent = 0;
        }
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(MESSAGE_DATA_CHANGED);
        }
    }
}
}
