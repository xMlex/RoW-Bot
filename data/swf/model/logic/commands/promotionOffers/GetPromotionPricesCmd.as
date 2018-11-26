package model.logic.commands.promotionOffers {
import model.data.DiscountPricePackManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class GetPromotionPricesCmd extends BaseCmd {


    private var _requestDto;

    public function GetPromotionPricesCmd() {
        super();
        this._requestDto = UserRefreshCmd.makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("GetPromotionPrices", this._requestDto, "POST").ifResult(function (param1:*):void {
            if (param1.p != null) {
                DiscountPricePackManager.addPacksDto(param1.p);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
