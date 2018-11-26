package model.logic.commands.alliances {
import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class DeleteKnownAllianceProposalCmd extends BaseAllianceCmd {


    private var _dto;

    public function DeleteKnownAllianceProposalCmd() {
        super();
        this._dto = makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.DeleteKnownAllianceProposal", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc2_ = AllianceManager.currentAlliance.gameData.knownAllianceData;
                _loc2_.proposal = null;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(function (param1:* = null):void {
            if (_onFault != null) {
                _onFault.call();
            }
        }).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
