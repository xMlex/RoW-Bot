package model.logic.commands.loyalty {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.loyalty.UserLoyaltyProgramData;

public class GetLoyaltyAllDayPrizeCmd extends BaseCmd {


    public function GetLoyaltyAllDayPrizeCmd() {
        super();
    }

    override public function execute():void {
        var requestDto:Object = null;
        requestDto = {};
        new JsonCallCmd("LoyalityProgramManager.GiveAllLoyalityProgramPrizes", requestDto, "POST").ifResult(function (param1:*):void {
            UserManager.user.gameData.loyaltyData.markAllDaysAsComplete();
            if (!param1) {
                return;
            }
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                UserLoyaltyProgramData.updateUserFromDto(param1.o, UserManager.user.gameData.loyaltyData.daysWithPrize);
            }
            if (_onResult != null) {
                _onResult.call();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
