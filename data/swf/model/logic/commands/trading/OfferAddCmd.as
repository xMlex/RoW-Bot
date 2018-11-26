package model.logic.commands.trading {
import model.data.normalization.Normalizer;
import model.data.users.trading.TradingOffer;
import model.logic.ServerTimeManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.trading.TradingManager;

public class OfferAddCmd extends BaseCmd {


    private var _offer:TradingOffer;

    private var requestDto;

    public function OfferAddCmd(param1:TradingOffer) {
        super();
        param1.userId = UserManager.user.id;
        this._offer = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto(param1.toDto());
    }

    override public function execute():void {
        new JsonCallCmd("TradingOffers.AddOffer", this.requestDto, "POST").ifResult(function (param1:*):void {
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _offer.id = param1.o as Number;
                _offer.time = ServerTimeManager.serverTimeNow;
                UserManager.user.gameData.tradingCenter.offers.addItem(_offer);
                TradingManager.LoadInfo(UserManager.user, _offer.offerInfo);
                Normalizer.normalize(UserManager.user);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
