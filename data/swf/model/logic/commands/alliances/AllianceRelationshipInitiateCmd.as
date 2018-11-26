package model.logic.commands.alliances {
import model.data.alliances.KnownAlliance;
import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class AllianceRelationshipInitiateCmd extends BaseAllianceCmd {


    private var _allianceId:Number;

    private var _relationshipType:int;

    private var _dto;

    public function AllianceRelationshipInitiateCmd(param1:Number, param2:int, param3:Boolean = false) {
        super();
        this._allianceId = param1;
        this._relationshipType = param2;
        this._dto = makeRequestDto({
            "a": this._allianceId,
            "t": this._relationshipType,
            "aw": param3
        });
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.InitiateRelationship", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc2_ = AllianceManager.currentAlliance.gameData.knownAllianceData;
                _loc3_ = _loc2_.getKnownAllianceById(_allianceId);
                if (_loc3_) {
                    _loc3_.knownAllianceInitiateInfo = KnownAlliance.createInitiateInfo(_relationshipType);
                }
                else {
                    _loc2_.knownAlliances.addItem(KnownAlliance.createInitiated(_allianceId, _relationshipType));
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
