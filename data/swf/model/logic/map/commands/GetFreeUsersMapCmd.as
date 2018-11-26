package model.logic.map.commands {
import model.data.map.MapPos;
import model.data.users.UserNote;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class GetFreeUsersMapCmd extends BaseCmd {


    private var _position:MapPos;

    private var _radius:int;

    private var _requestDto;

    public function GetFreeUsersMapCmd(param1:MapPos, param2:int) {
        super();
        this._position = param1;
        this._radius = param2;
        this._requestDto = {
            "p": param1.toDto(),
            "r": param2
        };
    }

    override public function execute():void {
        new JsonCallCmd("GetFreeUsersMap", this._requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = UserNote.fromDtos(param1.n);
            UserNoteManager.update(_loc2_);
            if (_onResult != null) {
                _onResult(_loc2_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
