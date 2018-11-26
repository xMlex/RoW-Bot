package model.logic.autoRefresh {
import flash.events.EventDispatcher;
import flash.events.TimerEvent;
import flash.utils.Timer;

import model.logic.MessageManager;
import model.logic.commands.server.FaultDto;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class AutoRefreshManager {

    public static const CLASS_NAME:String = "AutoRefresh";

    public static const EVENT_REFRESH_START:String = CLASS_NAME + "Start";

    public static const EVENT_REFRESH_COMPLETED:String = CLASS_NAME + "Completed";

    public static var enabled:Boolean = false;

    public static var retryTimeoutMs:Number = 30000;

    private static var timer:Timer = new Timer(1000);

    private static var timeLastError:Date = null;

    private static var cmd:JsonCallCmd;

    private static var blocked:int;

    public static var countActiveCommands:int = 0;

    private static var _events:EventDispatcher = new EventDispatcher();


    public function AutoRefreshManager() {
        super();
    }

    public static function get events():EventDispatcher {
        if (_events == null) {
            _events = new EventDispatcher();
        }
        return _events;
    }

    public static function run():void {
        if (!enabled) {
            return;
        }
        timer.start();
        timer.addEventListener(TimerEvent.TIMER, timerHandler);
        autoRefresh();
    }

    public static function block():void {
        if (!enabled) {
            return;
        }
        blocked++;
    }

    public static function unblock():void {
        if (!enabled) {
            return;
        }
        if (blocked > 0) {
            blocked--;
        }
        autoRefresh();
    }

    private static function timerHandler(param1:TimerEvent):void {
        if (timeLastError == null) {
            return;
        }
        var _loc2_:Number = new Date().time - timeLastError.time;
        if (_loc2_ > retryTimeoutMs) {
            timeLastError = null;
            autoRefresh();
        }
    }

    private static function autoRefresh():void {
        var requestDto:* = undefined;
        if (cmd != null) {
            return;
        }
        countActiveCommands++;
        requestDto = UserRefreshCmd.makeRequestDto();
        events.dispatchEvent(new AutoRefreshEvent(requestDto, EVENT_REFRESH_START));
        if (blocked == 0 && timeLastError == null) {
            (cmd = new JsonCallCmd("AutoRefresh", requestDto)).ifResult(function (param1:*):void {
                UserRefreshCmd.updateUserByResultDto(param1, requestDto);
                MessageManager.waitWhenMessagesIsReadOnServer = false;
                events.dispatchEvent(new AutoRefreshEvent(param1, EVENT_REFRESH_COMPLETED));
            }).ifFault(function (param1:FaultDto):void {
                timeLastError = new Date();
            }).doFinally(function ():void {
                cmd = null;
                countActiveCommands--;
                if (blocked == 0 && timeLastError == null) {
                    autoRefresh();
                }
            }).execute();
        }
    }
}
}
