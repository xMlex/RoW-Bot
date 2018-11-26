package model.logic.commands.user {
import common.ArrayCustom;

import model.data.User;
import model.data.users.UserNote;
import model.logic.AllianceNoteManager;
import model.logic.UserManager;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.alliances.AllianceGetNotesCmd;
import model.logic.commands.server.JsonCallCmd;

public class UserVisitCmd extends BaseCmd {


    private var _userId:Number;

    private var _myUserId:Number;

    private var _needSetCurrentUser:Boolean;

    private var _dto;

    public function UserVisitCmd(param1:Number, param2:Boolean = true) {
        super();
        this._userId = param1;
        this._myUserId = UserManager.user.id;
        this._needSetCurrentUser = param2;
        this._dto = {
            "v": this._myUserId,
            "i": this._userId
        };
    }

    override public function execute():void {
        var userNote:UserNote = UserNoteManager.getById(this._userId);
        var segmentId:int = userNote != null ? int(userNote.segmentId) : int(UserManager.segmentId);
        new JsonCallCmd("VisitUser3", this._dto, "POST").setSegment(segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = User.fromVisitUserDto(param1);
            if (param1.o != null) {
                UserNoteManager.updateOne(UserNote.fromDto(param1.o));
            }
            var _loc3_:* = 0;
            if (_loc2_.gameData.allianceData != null) {
                _loc3_ = _loc2_.gameData.allianceData.allianceId;
            }
            if (_loc3_ > 0 && !AllianceNoteManager.hasNote(_loc3_)) {
                new AllianceGetNotesCmd(new ArrayCustom([_loc3_])).execute();
            }
            if (_needSetCurrentUser) {
                UserManager.userHasChanged = true;
                UserManager.setCurrentUser(_loc2_);
            }
            if (_onResult != null) {
                _onResult(_loc2_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
