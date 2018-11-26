package model.logic.commands.vipSupport {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class SetRatingCmd extends BaseCmd {


    private var requestDto;

    public function SetRatingCmd(param1:int, param2:String, param3:Object, param4:int) {
        super();
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "r": param1,
            "m": param2,
            "d": param3,
            "a": param4
        });
    }

    override public function execute():void {
        new JsonCallCmd("VipSupport.SetRating", this.requestDto).ifResult(function (param1:*):void {
            UserRefreshCmd.updateUserByResultDto(param1, requestDto);
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
