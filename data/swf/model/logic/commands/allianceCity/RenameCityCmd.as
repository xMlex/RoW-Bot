package model.logic.commands.allianceCity {
import model.data.Resources;
import model.logic.AllianceManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class RenameCityCmd extends BaseCmd {


    private var _requestDto;

    private var _newName:String;

    public function RenameCityCmd(param1:String) {
        super();
        this._newName = param1;
        this._requestDto = UserRefreshCmd.makeRequestDto({"n": param1});
    }

    override public function execute():void {
        new JsonCallCmd("RenameCity", this._requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _requestDto)) {
                if (param1.o && param1.o.p) {
                    _loc2_ = Resources.fromDto(param1.o.p);
                    UserManager.user.gameData.account.resources.substract(_loc2_);
                }
            }
            AllianceManager.updateMyAllianceCityName(_newName);
            if (_onResult != null) {
                _onResult(_newName);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
