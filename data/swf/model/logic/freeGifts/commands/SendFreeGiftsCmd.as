package model.logic.freeGifts.commands {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class SendFreeGiftsCmd extends BaseCmd {


    private var requestDto:Object;

    public function SendFreeGiftsCmd(param1:Array, param2:Boolean, param3:String) {
        super();
        var _loc4_:Object = {
            "u": param1,
            "b": param2,
            "r": param3
        };
        this.requestDto = UserRefreshCmd.makeRequestDto(_loc4_);
    }

    override public function execute():void {
        new JsonCallCmd("SendFreeGifts", this.requestDto, "POST").ifResult(function (param1:Object):void {
            UserRefreshCmd.updateUserByResultDto(param1, requestDto);
            if (_onResult != null) {
                _onResult(param1.o);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
