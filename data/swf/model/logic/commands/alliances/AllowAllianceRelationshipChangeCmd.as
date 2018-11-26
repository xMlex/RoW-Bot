package model.logic.commands.alliances {
import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class AllowAllianceRelationshipChangeCmd extends BaseAllianceCmd {


    private var _userId:Number;

    private var _canMakeDiplomaticDecidions:Boolean;

    private var _dto;

    public function AllowAllianceRelationshipChangeCmd(param1:Number, param2:Boolean) {
        super();
        this._userId = param1;
        this._canMakeDiplomaticDecidions = param2;
        this._dto = makeRequestDto({
            "u": this._userId,
            "d": this._canMakeDiplomaticDecidions
        });
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.AllowDiplomacyDecisions", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc2_ = AllianceManager.currentAlliance.gameData.membershipData.getMember(_userId);
                _loc2_.canMakeDiplomaticDecidions = _canMakeDiplomaticDecidions;
                AllianceManager.currentAlliance.gameData.membershipData.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
