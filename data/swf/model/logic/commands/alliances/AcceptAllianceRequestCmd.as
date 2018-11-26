package model.logic.commands.alliances {
import model.data.alliances.membership.AllianceMember;
import model.data.alliances.membership.AllianceRequest;
import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class AcceptAllianceRequestCmd extends BaseAllianceCmd {


    private var _allianceRequest:AllianceRequest;

    private var _dto;

    public function AcceptAllianceRequestCmd(param1:AllianceRequest) {
        super();
        this._allianceRequest = param1;
        this._dto = makeRequestDto(this._allianceRequest.userId);
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.AcceptRequest", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc2_ = AllianceManager.currentAlliance.gameData;
                _loc2_.membershipData.requestsReceived.removeItemAt(_loc2_.membershipData.requestsReceived.getItemIndex(_allianceRequest));
                _loc2_.membershipData.members.addItem(AllianceMember.fromDto(param1.o));
                _loc2_.membershipData.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
