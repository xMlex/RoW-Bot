package model.logic.freeGifts.commands {
import model.data.users.UserAccount;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class AcceptFreeGiftsCmd extends BaseCmd {


    private var requestDto:Object;

    public function AcceptFreeGiftsCmd(param1:Array, param2:String) {
        super();
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "i": param1,
            "t": param2
        });
    }

    override public function execute():void {
        new JsonCallCmd("AcceptFreeGifts", this.requestDto, "POST").ifResult(function (param1:Object):void {
            var _loc2_:* = undefined;
            if (!param1 || !param1.o) {
                return;
            }
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                if (param1.o.a != null) {
                    _loc2_ = UserAccount.fromDto(param1.o.a);
                    UserManager.user.gameData.account.update(_loc2_);
                }
            }
            if (_onResult != null && param1.o.r != null && param1.o.m != null) {
                _onResult(param1.o.r, param1.o.m);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
