package model.logic.misc {
import flash.external.ExternalInterface;
import flash.utils.setTimeout;

import integration.SocialNetworkServicesBase;

import model.logic.misc.commands.SendUserDetailsCmd;

public final class SocialManager {

    private static var _commands:Array;

    private static var _results:Array;

    private static var _pendingCmdCount:int = 0;

    private static var _snService:SocialNetworkServicesBase;

    private static var _trackerResultUrl:String;


    public function SocialManager() {
        super();
    }

    private static function get hasTasks():Boolean {
        return _commands && _commands.length > 0;
    }

    public static function initializeTasks(param1:Array):void {
        var _loc2_:Object = null;
        _commands = [];
        _results = [];
        for each(_loc2_ in param1) {
            _commands.push(CustomCmd.fromDto(_loc2_));
        }
        _pendingCmdCount = _commands.length;
    }

    public static function sendUserDetails(param1:SocialNetworkServicesBase = null):void {
        var currentTask:CustomCmd = null;
        var snService:SocialNetworkServicesBase = param1;
        if (snService != null) {
            _snService = snService;
        }
        if (!hasTasks) {
            return;
        }
        do {
            currentTask = _commands.pop();
            switch (currentTask.type) {
                case CustomCmdType.FacebookGraphApiCmd:
                    setTimeout(function (param1:CustomCmd, param2:Function):void {
                        _snService.executeCustomCmd(param1.name, param1.parameters, param1.token, param2, CustomCmdType.FacebookGraphApiCmd, param1.resultUrl);
                    }, currentTask.timeout, currentTask, cmdResultHandler);
                    break;
                case CustomCmdType.JavaScript:
                    if (ExternalInterface.available) {
                        setTimeout(function ():void {
                            ExternalInterface.call(currentTask.name);
                            cmdResultHandler("", currentTask.token, CustomCmdType.JavaScript, CustomCmdResultType.Ok);
                        }, currentTask.timeout);
                    }
                    else {
                        cmdResultHandler("", currentTask.token, CustomCmdType.JavaScript, CustomCmdResultType.Error);
                    }
            }
        }
        while (_commands.length > 0);

    }

    private static function cmdResultHandler(param1:String, param2:String, param3:int, param4:uint = 0, param5:String = ""):void {
        _pendingCmdCount--;
        var _loc6_:Object = {};
        _loc6_.r = param1;
        _loc6_.o = param2;
        _loc6_.y = param4;
        _loc6_.t = param3;
        _results.push(_loc6_);
        new SendUserDetailsCmd(_loc6_, _trackerResultUrl).execute();
    }
}
}
