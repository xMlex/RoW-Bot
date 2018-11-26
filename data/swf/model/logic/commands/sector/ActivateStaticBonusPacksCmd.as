package model.logic.commands.sector {
import model.logic.UserManager;
import model.logic.blackMarketItems.ActivateItemResponse;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class ActivateStaticBonusPacksCmd extends BaseCmd {


    private var requestDto;

    public function ActivateStaticBonusPacksCmd() {
        super();
        this.requestDto = UserRefreshCmd.makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("BlackMarket.ActivateStaticBonusPacks", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = param1.o == null ? null : ActivateItemResponse.fromDto(param1.o);
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                UserManager.user.gameData.blackMarketData.deleteAllActiveAllianceMissionChests();
                if (_loc2_ != null && _loc2_.staticBonusPackActivationResult != null) {
                    _loc2_.staticBonusPackActivationResult.givePrizeToUser();
                }
            }
            if (_onResult != null) {
                _onResult(param1, _loc2_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
