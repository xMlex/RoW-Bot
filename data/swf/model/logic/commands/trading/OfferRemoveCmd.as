package model.logic.commands.trading {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.trading.TradingManager;

public class OfferRemoveCmd extends BaseCmd {


    private var _offerId:Number;

    private var requestDto;

    public function OfferRemoveCmd(param1:Number) {
        super();
        this._offerId = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto(param1);
    }

    override public function execute():void {
        new JsonCallCmd("TradingOffers.RemoveOffer", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user.gameData.tradingCenter.offers;
                _loc3_ = 0;
                while (_loc3_ < _loc2_.length) {
                    _loc4_ = _loc2_[_loc3_];
                    if (_loc4_.id == _offerId) {
                        _loc2_.removeItemAt(_loc3_);
                        TradingManager.UnloadInfo(UserManager.user, _loc4_.offerInfo);
                        break;
                    }
                    _loc3_++;
                }
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
