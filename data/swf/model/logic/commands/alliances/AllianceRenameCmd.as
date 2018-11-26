package model.logic.commands.alliances {
import model.logic.AllianceManager;
import model.logic.UserManager;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class AllianceRenameCmd extends BaseAllianceCmd {


    private var _dto:Object;

    private var _allianceId:Number;

    private var _newName:String;

    public function AllianceRenameCmd(param1:Number, param2:String) {
        super();
        this._allianceId = param1;
        this._newName = param2;
        this._dto = UserRefreshCmd.makeRequestDto({
            "n": this._newName,
            "i": param1
        });
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.Rename", this._dto, "POST").setSegment(UserManager.segmentId).ifResult(function (param1:*):void {
            AllianceManager.updateMyAllianceName(_newName);
            if (_onResult != null) {
                _onResult(_newName);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
