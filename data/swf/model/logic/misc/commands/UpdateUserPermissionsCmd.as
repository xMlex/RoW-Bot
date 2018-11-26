package model.logic.misc.commands {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class UpdateUserPermissionsCmd extends BaseCmd {


    private var _newPermissions:Array;

    public function UpdateUserPermissionsCmd(param1:Array) {
        super();
        this._newPermissions = param1;
    }

    override public function execute():void {
        var dto:Object = UserRefreshCmd.makeRequestDto(this._newPermissions);
        new JsonCallCmd("UpdateUserPermissions", dto, "POST").ifResult(function (param1:Object):void {
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
