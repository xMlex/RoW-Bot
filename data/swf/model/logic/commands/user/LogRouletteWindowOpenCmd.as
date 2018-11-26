package model.logic.commands.user {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class LogRouletteWindowOpenCmd extends BaseCmd {

    public static const AUTO:int = 0;

    public static const MANUAL:int = 1;


    private var dto:int;

    public function LogRouletteWindowOpenCmd(param1:int) {
        super();
        this.dto = param1;
    }

    override public function execute():void {
        var requestDto:Object = UserRefreshCmd.makeRequestDto(this.dto);
        new JsonCallCmd("LogRouletteWindowOpen", requestDto, "POST").ifResult(function (param1:*):void {
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(function ():void {
        }).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
