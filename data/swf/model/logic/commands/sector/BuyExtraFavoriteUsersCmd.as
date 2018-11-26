package model.logic.commands.sector {
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class BuyExtraFavoriteUsersCmd extends BaseCmd {


    private var _boostTypeId:int;

    private var requestDto;

    public function BuyExtraFavoriteUsersCmd(param1:int) {
        super();
        this._boostTypeId = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto({"i": this._boostTypeId});
    }

    override public function execute():void {
        new JsonCallCmd("BlackMarket.BuyExtraFavoriteUsers", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc3_:* = undefined;
            var _loc2_:* = StaticDataManager.blackMarketData.getExtraFavoriteUsersBoostType(_boostTypeId);
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto) && _loc2_ != null) {
                _loc3_ = UserManager.user;
                _loc3_.gameData.questData.addCollectibleItemsFromBMI(_loc2_.price.goldMoney);
                _loc3_.gameData.knownUsersData.extraFavoriteUsersCount = _loc3_.gameData.knownUsersData.extraFavoriteUsersCount + _loc2_.boostValue;
                _loc3_.gameData.account.resources.substract(_loc2_.price);
                _loc3_.gameData.blackMarketData.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
