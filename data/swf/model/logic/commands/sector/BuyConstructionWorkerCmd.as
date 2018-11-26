package model.logic.commands.sector {
import model.data.Resources;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class BuyConstructionWorkerCmd extends BaseCmd {


    private var requestDto;

    public function BuyConstructionWorkerCmd() {
        super();
        this.requestDto = UserRefreshCmd.makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("BuyConstructionWorker", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc3_:* = undefined;
            var _loc2_:* = StaticDataManager.constructionData.getNextWorkerPrice(UserManager.user.gameData.constructionData.constructionWorkersCount);
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = Resources.fromDto(param1.o.r);
                _loc3_ = UserManager.user;
                _loc3_.gameData.account.resources.substract(_loc2_);
                _loc3_.gameData.constructionData.constructionWorkersCount++;
                _loc3_.gameData.constructionData.constructionWorkersChanged = true;
                _loc3_.gameData.constructionData.availableWorkersChanged = false;
                if (_loc3_.gameData.constructionData.constructionWorkersCount == StaticDataManager.constructionData.getMaxWorkersCount()) {
                    _loc3_.gameData.constructionData.additionalWorkersExpireDateTimes = null;
                    _loc3_.gameData.constructionData.constructionAdditionalWorkersChanged = true;
                }
                _loc3_.gameData.updateObjectsBuyStatus(true);
                _loc3_.gameData.dispatchEvents();
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
