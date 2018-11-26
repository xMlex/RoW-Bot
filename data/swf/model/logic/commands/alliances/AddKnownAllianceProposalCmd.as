package model.logic.commands.alliances {
import model.data.alliances.KnownAllianceProposal;
import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class AddKnownAllianceProposalCmd extends BaseAllianceCmd {


    private var _dto;

    public function AddKnownAllianceProposalCmd(param1:int, param2:Boolean = false) {
        super();
        this._dto = makeRequestDto({
            "t": param1,
            "a": param2
        });
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.AddKnownAllianceProposal", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc2_ = AllianceManager.currentAlliance.gameData.knownAllianceData;
                _loc2_.proposal = KnownAllianceProposal.fromDto(param1.o);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
