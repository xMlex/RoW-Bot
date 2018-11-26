package model.logic.commands.promotionOffers {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class MarkOfferPurchaseNotificationReadCmd extends BaseCmd {


    private var _requestDto;

    public function MarkOfferPurchaseNotificationReadCmd(param1:Number) {
        super();
        this._requestDto = param1;
    }

    override public function execute():void {
        new JsonCallCmd("MarkOfferPurchaseNotificationRead", this._requestDto, "POST").ifResult(function ():void {
            var _loc1_:* = UserManager.user.gameData.promotionOfferData.getPromotionOfferByOfferId(_requestDto);
            _loc1_.markReadPurchaseInfo();
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
