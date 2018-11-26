package model.logic.commands.sector {
import model.data.users.UserNote;
import model.data.users.buildings.Sector;
import model.logic.UserManager;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class RepairBuildingForFriendCmd extends BaseCmd {


    private var _userId:Number;

    private var _buildingId:Number;

    private var _dto;

    public function RepairBuildingForFriendCmd(param1:Number, param2:Number) {
        super();
        this._userId = param1;
        this._buildingId = param2;
        this._dto = {
            "u": this._userId,
            "b": this._buildingId
        };
    }

    override public function execute():void {
        var userNote:UserNote = UserNoteManager.getById(this._userId);
        var segmentId:int = userNote != null ? int(userNote.segmentId) : int(UserManager.segmentId);
        new JsonCallCmd("RepairBuildingForFriend", this._dto, "POST").setSegment(segmentId).ifResult(function (param1:*):void {
            UserManager.user.gameData.sector.buildingRepairedForUserIds.addItem(_userId);
            UserManager.user.gameData.sector.dispatchEvent(Sector.BUILDING_REPAIREDfOR_USER_CHANGE_EVENT);
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
