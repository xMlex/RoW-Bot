package model.logic.commands.alliances {
import model.data.alliances.membership.AllianceMemberState;
import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class ChangeStatusCmd extends BaseAllianceCmd {


    private var _userId:Number;

    private var _stateId:int;

    private var _stateComment:String;

    private var _dto;

    public function ChangeStatusCmd(param1:Number, param2:int, param3:String) {
        super();
        this._userId = param1;
        this._stateId = param2;
        this._stateComment = param3;
        this._dto = makeRequestDto({
            "u": this._userId,
            "s": this._stateId,
            "c": this._stateComment
        });
    }

    override public function execute():void {
        new JsonCallCmd("ChangeAllianceStatus", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc2_ = AllianceManager.currentAlliance.gameData.membershipData.getMember(_userId);
                _loc2_.state = new AllianceMemberState();
                _loc2_.state.stateId = _stateId;
                _loc2_.state.stateComment = _stateComment;
                AllianceManager.currentAlliance.gameData.membershipData.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
