package model.logic.commands.trading {
import model.data.User;
import model.data.units.Unit;
import model.data.users.trading.TradingOffer;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.units.UnitUtility;

public class OfferAcceptCmd extends BaseCmd {


    private var _offer:TradingOffer;

    private var requestDto;

    public function OfferAcceptCmd(param1:TradingOffer) {
        super();
        this._offer = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto({"o": param1.toDto()});
    }

    private static function loadOffer(param1:User, param2:TradingOffer):void {
        if (param2.offerInfo.resources != null) {
            param1.gameData.account.resources.substract(param2.offerInfo.resources);
        }
        if (param2.offerInfo.drawingPart != null) {
            param1.gameData.drawingArchive.removeDrawingPart(param2.offerInfo.drawingPart);
        }
    }

    override public function execute():void {
        new JsonCallCmd("TradingOffers.AcceptOffer", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user;
                _loc3_ = Unit.fromDto(param1.o);
                if (_loc2_.id == _loc3_.OwnerUserId && _loc3_.StateMovingForward != null) {
                    UnitUtility.LoadUnit(_loc2_, _loc3_);
                }
                UnitUtility.AddUnit(_loc2_, _loc3_);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
