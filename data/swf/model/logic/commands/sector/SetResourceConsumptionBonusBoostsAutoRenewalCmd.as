package model.logic.commands.sector {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class SetResourceConsumptionBonusBoostsAutoRenewalCmd extends BaseCmd {


    private var _requestDto;

    private var _consumptionBonusBoostAutoRenewal:Boolean;

    public function SetResourceConsumptionBonusBoostsAutoRenewalCmd(param1:Boolean) {
        super();
        this._consumptionBonusBoostAutoRenewal = param1;
        var _loc2_:* = {};
        _loc2_.a = param1;
        this._requestDto = UserRefreshCmd.makeRequestDto(_loc2_);
    }

    override public function execute():void {
        new JsonCallCmd("SetResourceConsumptionBonusBoostsAutoRenewal", this._requestDto, "POST").ifResult(function (param1:*):void {
            UserManager.user.gameData.constructionData.resourceConsumptionBonusBoostAutoRenewal = _consumptionBonusBoostAutoRenewal;
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
