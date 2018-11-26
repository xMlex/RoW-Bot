package model.logic.commands.alliances {
import model.data.alliances.membership.AllianceMember;
import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class RemoveFromAlliance extends BaseAllianceCmd {


    private var _allianceMember:AllianceMember;

    private var _dto;

    public function RemoveFromAlliance(param1:AllianceMember) {
        super();
        this._allianceMember = param1;
        this._dto = makeRequestDto(this._allianceMember.userId);
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.RemoveFromAlliance", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc2_ = AllianceManager.currentAlliance.gameData;
                _loc2_.membershipData.members.removeItemAt(_loc2_.membershipData.members.getItemIndex(_allianceMember));
                _loc2_.membershipData.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
