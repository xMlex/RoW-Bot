package model.logic.commands.alliances {
import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class DeclineAllAllianceRequestsCmd extends BaseAllianceCmd {


    private var _dto;

    public function DeclineAllAllianceRequestsCmd() {
        super();
        this._dto = makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.DeclineAllRequests", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc2_ = AllianceManager.currentAlliance.gameData;
                _loc2_.membershipData.requestsReceived.removeAll();
                _loc2_.membershipData.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
