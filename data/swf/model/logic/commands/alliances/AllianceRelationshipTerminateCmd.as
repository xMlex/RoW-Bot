package model.logic.commands.alliances {
import model.data.alliances.KnownAlliance;
import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class AllianceRelationshipTerminateCmd extends BaseAllianceCmd {


    private var _allianceId:Number;

    private var _dto;

    public function AllianceRelationshipTerminateCmd(param1:Number) {
        super();
        this._allianceId = param1;
        this._dto = makeRequestDto(this._allianceId);
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.TerminateRelationship", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc2_ = AllianceManager.currentAlliance.gameData.knownAllianceData;
                _loc3_ = _loc2_.getKnownAllianceById(_allianceId);
                if (param1.o != null) {
                    _loc3_.knownAllianceTerminateInfo = KnownAlliance.createTerminateInfo(AllianceManager.currentAlliance.id, new Date(param1.o));
                }
                else if (_loc3_.knownAllianceTerminateInfo && _loc3_.knownAllianceTerminateInfo.terminatorAllianceId != AllianceManager.currentAlliance.id) {
                    _loc3_.knownAllianceTerminateInfo.confirmed = true;
                }
                else {
                    _loc2_.removeKnownAllianceById(_allianceId);
                }
                _loc2_.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
