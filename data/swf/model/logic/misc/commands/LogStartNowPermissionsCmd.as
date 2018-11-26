package model.logic.misc.commands {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class LogStartNowPermissionsCmd extends BaseCmd {


    private var _hasGrantedPermissions:Boolean;

    private var _hashedId:String;

    private var _userId:String;

    private var _referrer:int;

    public function LogStartNowPermissionsCmd(param1:Boolean, param2:String, param3:String, param4:int) {
        super();
        this._hasGrantedPermissions = param1;
        this._hashedId = param2;
        this._userId = param3;
        this._referrer = param4;
    }

    override public function execute():void {
        var dto:Object = UserRefreshCmd.makeRequestDto({
            "g": this._hasGrantedPermissions,
            "r": this._referrer,
            "s": this._userId,
            "h": this._hashedId
        });
        new JsonCallCmd("LogStartNowPermissionsCmd", dto, "POST").ifResult(function (param1:Object):void {
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
