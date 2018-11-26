package model.logic.commands.allianceMissions {
import flash.utils.Dictionary;

import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class SetUserAllianceMissionStateCmd extends BaseCmd {


    private var _allianceId:Number;

    private var _missionId:Number;

    private var _missionState:int;

    private var _requestDto;

    public function SetUserAllianceMissionStateCmd(param1:Number, param2:Number, param3:int) {
        super();
        this._allianceId = param1;
        this._missionId = param2;
        this._missionState = param3;
        this._requestDto = {
            "a": param1,
            "m": param2,
            "s": param3
        };
    }

    override public function execute():void {
        new JsonCallCmd("AllianceMission.SetUserAllianceMissionState", this._requestDto, "POST").execute();
        var _loc1_:Dictionary = UserManager.user.gameData.allianceData.allianceMissions;
        if (_loc1_[this._allianceId]) {
            _loc1_[this._allianceId][this._missionId] = this._missionState;
        }
        UserManager.user.gameData.allianceData.dirty = true;
        UserManager.user.gameData.allianceData.dispatchEvents();
    }
}
}
