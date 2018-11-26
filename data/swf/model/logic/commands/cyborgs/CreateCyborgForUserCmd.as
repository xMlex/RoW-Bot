package model.logic.commands.cyborgs {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class CreateCyborgForUserCmd extends BaseCmd {


    private var requestDto;

    private var _friendId:Number;

    public function CreateCyborgForUserCmd(param1:Number) {
        super();
        this._friendId = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto({"u": this._friendId});
    }

    override public function execute():void {
        new JsonCallCmd("CreateCyborgForUser", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user;
                _loc2_.gameData.cyborgData.createdCyborgForUserIds.addItem(_friendId);
                _loc2_.gameData.cyborgData.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
