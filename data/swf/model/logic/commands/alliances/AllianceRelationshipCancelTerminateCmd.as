package model.logic.commands.alliances {
import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class AllianceRelationshipCancelTerminateCmd extends BaseAllianceCmd {


    private var _allianceId:Number;

    private var _dto;

    public function AllianceRelationshipCancelTerminateCmd(param1:Number) {
        super();
        this._allianceId = param1;
        this._dto = makeRequestDto(this._allianceId);
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.CancelTerminateRelationship", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc2_ = AllianceManager.currentAlliance.gameData.knownAllianceData;
                _loc3_ = _loc2_.getKnownAllianceById(_allianceId);
                if (_loc3_) {
                    _loc3_.knownAllianceTerminateInfo.cancelling = true;
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
