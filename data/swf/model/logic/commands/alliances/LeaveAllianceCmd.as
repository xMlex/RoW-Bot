package model.logic.commands.alliances {
import model.data.alliances.Alliance;
import model.logic.AllianceManager;
import model.logic.UserManager;
import model.logic.commands.server.JsonCallCmd;

public class LeaveAllianceCmd extends BaseAllianceCmd {


    private var _alliance:Alliance;

    private var _dto;

    public function LeaveAllianceCmd(param1:Alliance) {
        super();
        this._alliance = param1;
        this._dto = this._alliance.id;
    }

    override public function execute():void {
        new JsonCallCmd("LeaveAlliance", this._dto, "POST").setSegment(this._alliance.segmentId).ifResult(function (param1:*):void {
            if (param1 != null && param1.t != null && AllianceManager.currentAlliance.gameData.membershipData.getLeaderId() == UserManager.user.id) {
                AllianceManager.updateAllianceDeletion(true, new Date(param1.t));
            }
            else {
                AllianceManager.currentAlliance = null;
                AllianceManager.cityIsAlreadyLoaded = false;
                AllianceManager.currentAllianceCity = null;
                UserManager.user.gameData.allianceData.allianceId = Number.NaN;
                UserManager.user.gameData.allianceData.rankId = -1;
                UserManager.user.gameData.allianceData.dirty = true;
                UserManager.user.gameData.allianceData.dispatchEvents();
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
