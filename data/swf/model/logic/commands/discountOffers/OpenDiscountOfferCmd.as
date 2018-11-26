package model.logic.commands.discountOffers {
import model.data.UserPrize;
import model.data.discountOffers.ActiveDiscountOffer;
import model.data.discountOffers.DiscountOfferType;
import model.data.discountOffers.UserDiscountOfferData;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.discountOffers.UserDiscountOfferManager;

public class OpenDiscountOfferCmd extends BaseCmd {


    public var _dto;

    public function OpenDiscountOfferCmd() {
        super();
        this._dto = UserRefreshCmd.makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("DiscountOffer.Open", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            UserDiscountOfferManager.discountOfferTypes = DiscountOfferType.fromDtos(param1.o.t);
            if (!UserRefreshCmd.updateUserByResultDto(param1, _dto)) {
                if (UserManager.user.gameData.discountOfferData == null) {
                    UserManager.user.gameData.discountOfferData = new UserDiscountOfferData();
                }
                UserManager.user.gameData.discountOfferData.activeDiscountOffers = ActiveDiscountOffer.fromDtos(param1.o.a);
                UserManager.user.gameData.discountOfferData.lastDiscountOpenTime = param1.o.d == null ? new Date() : new Date(param1.o.d);
                UserDiscountOfferManager.lastDiscountOpenTime = UserManager.user.gameData.discountOfferData.lastDiscountOpenTime;
                UserDiscountOfferManager.activeDiscountOffers = ActiveDiscountOffer.fromDtos(param1.o.a);
                _loc2_ = param1.o.p == null ? null : UserPrize.fromDto(param1.o.p);
                if (_loc2_ != null) {
                    UserManager.user.gameData.account.resources.add(_loc2_.resources);
                }
                UserManager.user.gameData.discountOfferData.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
