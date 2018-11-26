package model.data.specialOfferTriggers.notifications {
import configs.Global;

import model.data.specialOfferTriggers.TriggerTestConsole;
import model.logic.ServerTimeManager;
import model.logic.UserManager;
import model.logic.commands.triggers.NotifyAboutClientEventCmd;
import model.logic.commands.triggers.TriggerClientEventDto;

public class NotificationAboutClientEventManager {

    private static const INTERVAL:int = 60 * 1000;

    private static const MIN_USER_LEVEL_FOR_TRIGGER:int = 5;

    private static var _instance:NotificationAboutClientEventManager;


    private var _lastTriggerDateByType:Object;

    public function NotificationAboutClientEventManager() {
        this._lastTriggerDateByType = {};
        super();
        if (_instance) {
            throw new Error("NotificationAboutClientEventManager single tone initialization error");
        }
    }

    public static function get instance():NotificationAboutClientEventManager {
        if (_instance == null) {
            _instance = new NotificationAboutClientEventManager();
        }
        return _instance;
    }

    public function trackEvent(param1:TriggerEvent):void {
        var _loc2_:* = UserManager.user.gameData.account.level >= MIN_USER_LEVEL_FOR_TRIGGER;
        var _loc3_:Boolean = Global.PROMOTION_OFFERS_ENABLED;
        if (_loc3_ && _loc2_) {
            param1.startVerification(this.waitAnswer);
        }
    }

    private function waitAnswer(param1:Boolean, param2:TriggerEvent):void {
        if (param1) {
            this.trySendEvent(param2.triggerEventDto);
        }
    }

    private function trySendEvent(param1:TriggerClientEventDto):void {
        var _loc2_:Number = ServerTimeManager.serverTimeNow.time;
        if (this._lastTriggerDateByType[param1.e] == undefined || _loc2_ - this._lastTriggerDateByType[param1.e] >= INTERVAL) {
            this.sendEvents(param1);
        }
    }

    private function sendEvents(param1:TriggerClientEventDto):void {
        var event:TriggerClientEventDto = param1;
        new NotifyAboutClientEventCmd([event]).ifResult(function ():void {
            TriggerTestConsole.addSentEventTrace(" [" + ServerTimeManager.serverTimeNow.toString() + "]\n       " + event.toString());
            _lastTriggerDateByType[event.e] = ServerTimeManager.serverTimeNow.time;
        }).execute();
    }
}
}
