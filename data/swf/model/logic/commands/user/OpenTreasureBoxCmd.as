package model.logic.commands.user {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class OpenTreasureBoxCmd extends BaseCmd {


    private var _dto;

    protected var _onQuestNotFound:Function;

    public function OpenTreasureBoxCmd(param1:int, param2:int) {
        super();
        this._dto = UserRefreshCmd.makeRequestDto({
            "b": param1,
            "p": param2
        });
    }

    public function ifNotFound(param1:Function):BaseCmd {
        this._onQuestNotFound = param1;
        return this;
    }

    override public function execute():void {
        new JsonCallCmd("OpenTreasureBox", this._dto, "POST").ifResult(function (param1:*):void {
            UserRefreshCmd.updateUserByResultDto(param1, _dto);
            if (param1.o != 0) {
                if (_onResult != null) {
                    _onResult();
                }
            }
            else if (_onQuestNotFound != null) {
                _onQuestNotFound();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
