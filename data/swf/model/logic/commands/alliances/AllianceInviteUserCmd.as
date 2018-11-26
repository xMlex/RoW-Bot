package model.logic.commands.alliances {
import model.data.alliances.membership.AllianceInvitation;
import model.data.alliances.membership.AllianceMember;
import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class AllianceInviteUserCmd extends BaseAllianceCmd {


    private var _userId:Number;

    private var _dto;

    public function AllianceInviteUserCmd(param1:int) {
        super();
        this._userId = param1;
        this._dto = makeRequestDto(this._userId);
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.InviteUser", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                if (param1.o.i) {
                    _loc2_ = AllianceInvitation.fromDto(param1.o.i);
                    AllianceManager.currentAlliance.gameData.membershipData.invitationsSent.addItem(_loc2_);
                }
                if (param1.o.m) {
                    _loc3_ = AllianceMember.fromDto(param1.o.m);
                    AllianceManager.currentAlliance.gameData.membershipData.members.addItem(_loc3_);
                }
                AllianceManager.currentAlliance.gameData.membershipData.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
