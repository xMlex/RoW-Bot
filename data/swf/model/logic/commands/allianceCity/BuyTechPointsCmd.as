package model.logic.commands.allianceCity {
import model.data.Resources;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class BuyTechPointsCmd extends BaseCmd {


    private var _dto;

    public function BuyTechPointsCmd(param1:int, param2:Boolean = false) {
        super();
        this._dto = UserRefreshCmd.makeRequestDto({
            "t": param1,
            "b": param2
        });
    }

    override public function execute():void {
        new JsonCallCmd("BuyTechPoints", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _dto)) {
                _loc2_ = Resources.fromDto(param1.o);
                UserManager.user.gameData.account.resources.substract(_loc2_);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
