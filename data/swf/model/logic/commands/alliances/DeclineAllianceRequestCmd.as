package model.logic.commands.alliances {
import model.data.alliances.membership.AllianceRequest;
import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class DeclineAllianceRequestCmd extends BaseAllianceCmd {


    private var _allianceRequest:AllianceRequest;

    private var _dto;

    public function DeclineAllianceRequestCmd(param1:AllianceRequest) {
        super();
        this._allianceRequest = param1;
        this._dto = makeRequestDto(this._allianceRequest.userId);
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.DeclineRequest", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc2_ = AllianceManager.currentAlliance.gameData;
                _loc2_.membershipData.removeRequestsReceived(_allianceRequest);
                _loc2_.membershipData.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
