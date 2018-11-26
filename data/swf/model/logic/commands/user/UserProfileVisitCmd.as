package model.logic.commands.user {
import model.data.UserProfileDto;
import model.logic.AllianceNoteManager;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class UserProfileVisitCmd extends BaseCmd {


    private var _userId:Number;

    private var _segmentId:int;

    public function UserProfileVisitCmd(param1:Number, param2:int) {
        super();
        this._userId = param1;
        this._segmentId = param2;
    }

    override public function execute():void {
        if (this._userId == 0) {
            return;
        }
        new JsonCallCmd("VisitUserProfile", this._userId, "POST").setSegment(this._segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = UserProfileDto.fromDto(param1);
            if (_loc2_.userNote != null) {
                UserNoteManager.updateOne(_loc2_.userNote);
            }
            if (_loc2_.allianceNote != null) {
                AllianceNoteManager.updateOne(_loc2_.allianceNote);
            }
            if (_onResult != null) {
                _onResult(_loc2_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
