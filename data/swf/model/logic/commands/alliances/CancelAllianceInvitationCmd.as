package model.logic.commands.alliances {
import model.data.alliances.membership.AllianceInvitation;
import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class CancelAllianceInvitationCmd extends BaseAllianceCmd {


    private var _allianceInvitation:AllianceInvitation;

    private var _dto;

    public function CancelAllianceInvitationCmd(param1:AllianceInvitation) {
        super();
        this._allianceInvitation = param1;
        this._dto = makeRequestDto(this._allianceInvitation.userId);
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.CancelInvitation", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc2_ = AllianceManager.currentAlliance.gameData;
                _loc2_.membershipData.invitationsSent.removeItemAt(_loc2_.membershipData.invitationsSent.getItemIndex(_allianceInvitation));
                _loc2_.membershipData.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
