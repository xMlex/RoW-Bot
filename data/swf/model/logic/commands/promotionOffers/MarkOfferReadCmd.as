package model.logic.commands.promotionOffers {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class MarkOfferReadCmd extends BaseCmd {


    private var _requestDto;

    public function MarkOfferReadCmd(param1:Number, param2:int) {
        super();
        this._requestDto = new Object();
        this._requestDto.p = param1;
        this._requestDto.e = param2;
    }

    override public function execute():void {
        new JsonCallCmd("MarkOfferReadExtended", this._requestDto, "POST").ifResult(function ():void {
            var _loc1_:* = UserManager.user.gameData.promotionOfferData.getPromotionOfferByOfferId(_requestDto.p);
            if (_loc1_ != null) {
                _loc1_.markRead();
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
