package model.logic.commands.loyalty {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class SetLoyalityViewedData extends BaseCmd {


    public function SetLoyalityViewedData() {
        super();
    }

    override public function execute():void {
        var requestDto:Object = null;
        requestDto = {};
        new JsonCallCmd("LoyalityProgramManager.ViewedLoyalityData", requestDto, "POST").ifResult(function (param1:*):void {
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                UserManager.user.gameData.loyaltyData.viewedLoyalityData = true;
            }
            if (_onResult != null) {
                _onResult.call();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
