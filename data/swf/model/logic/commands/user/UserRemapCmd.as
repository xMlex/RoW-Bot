package model.logic.commands.user {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class UserRemapCmd extends BaseCmd {


    private var _fbRealUid:String;

    private var _hashedId:String;

    private var _updSignedRequest:String;

    private var _permissions:Array;

    public function UserRemapCmd(param1:String, param2:String, param3:String, param4:Array) {
        super();
        this._fbRealUid = param1;
        this._hashedId = param2;
        this._updSignedRequest = param3;
        this._permissions = param4 || [];
    }

    override public function execute():void {
        var requestDto:Object = null;
        requestDto = UserRefreshCmd.makeRequestDto({
            "h": this._hashedId,
            "f": this._fbRealUid,
            "s": this._updSignedRequest,
            "p": this._permissions
        });
        new JsonCallCmd("RemapFbSnUser", requestDto, "POST").ifResult(function (param1:*):void {
            UserRefreshCmd.updateUserByResultDto(param1, requestDto);
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
