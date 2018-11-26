package model.logic.commands.globalMission {
import flash.utils.Dictionary;

import model.data.raids.GlobalMissionManager;
import model.data.raids.GlobalMissionUIData;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class GetGlobalMissionClientDataCmd extends BaseCmd {


    private var _prototypeIds:Array;

    public function GetGlobalMissionClientDataCmd(param1:Array) {
        super();
        this._prototypeIds = param1;
    }

    override public function execute():void {
        new JsonCallCmd("GetGlobalMissionClientData", this._prototypeIds, "POST").ifResult(function (param1:*):void {
            var _loc3_:* = undefined;
            var _loc2_:* = new Dictionary();
            for (_loc3_ in param1) {
                _loc2_[_loc3_] = GlobalMissionUIData.fromDto(param1[_loc3_]);
            }
            if (_loc2_ != null) {
                GlobalMissionManager.objectsDataByGlobalMission = _loc2_;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
