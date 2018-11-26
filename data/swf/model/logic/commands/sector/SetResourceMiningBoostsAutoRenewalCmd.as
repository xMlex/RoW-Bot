package model.logic.commands.sector {
import model.data.acceleration.types.BoostTypeId;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class SetResourceMiningBoostsAutoRenewalCmd extends BaseCmd {


    private var _requestDto;

    private var _miningBoostAutoRenewal:Boolean;

    private var _miningBoostAutoRenewalType:int;

    public function SetResourceMiningBoostsAutoRenewalCmd(param1:Boolean, param2:int = -1) {
        super();
        this._miningBoostAutoRenewal = param1;
        this._miningBoostAutoRenewalType = param2;
        var _loc3_:* = {};
        _loc3_.a = param1;
        _loc3_.t = param2;
        this._requestDto = UserRefreshCmd.makeRequestDto(_loc3_);
    }

    override public function execute():void {
        new JsonCallCmd("SetResourceMiningBoostsAutoRenewal", this._requestDto, "POST").ifResult(function (param1:*):void {
            switch (_miningBoostAutoRenewalType) {
                case BoostTypeId.RESOURCES_URANIUM:
                    UserManager.user.gameData.constructionData.resourceMiningBoostAutoRenewalUranium = _miningBoostAutoRenewal;
                    break;
                case BoostTypeId.RESOURCES_TITANITE:
                    UserManager.user.gameData.constructionData.resourceMiningBoostAutoRenewalTitanite = _miningBoostAutoRenewal;
                    break;
                case BoostTypeId.RESOURCES_MONEY:
                    UserManager.user.gameData.constructionData.resourceMiningBoostAutoRenewalMoney = _miningBoostAutoRenewal;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
