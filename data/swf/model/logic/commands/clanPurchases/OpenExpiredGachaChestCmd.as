package model.logic.commands.clanPurchases {
import model.data.clanPurchases.GachaChestItem;
import model.data.users.blackMarket.UserBmiData;
import model.data.users.misc.UserBlackMarketData;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemsNode;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.dtoSerializer.DtoDeserializer;

public class OpenExpiredGachaChestCmd extends BaseCmd {


    private var _requestDto;

    public function OpenExpiredGachaChestCmd() {
        super();
        this._requestDto = UserRefreshCmd.makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("GachaChest.OpenExpiredItems", this._requestDto, "POST").ifResult(function (param1:*):void {
            if (!UserRefreshCmd.updateUserByResultDto(param1, _requestDto)) {
                if (param1.o.c != null) {
                    updateGachaData(param1.o.c);
                }
                if (param1.o.i != null) {
                    updateBMData(param1.o.i);
                }
                UserManager.user.gameData.blackMarketData.chestsDirty = true;
            }
            if (_onResult != null) {
                _onResult(null);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }

    private function updateGachaData(param1:Object):void {
        var _loc2_:Array = DtoDeserializer.toArray(param1, GachaChestItem.fromDto);
        UserManager.user.gameData.clanPurchaseData.updateExpiredChests(_loc2_);
    }

    private function updateBMData(param1:Array):void {
        var _loc6_:UserBmiData = null;
        var _loc7_:BlackMarketItemsNode = null;
        var _loc8_:int = 0;
        var _loc2_:Array = param1;
        var _loc3_:int = _loc2_.length;
        var _loc4_:UserBlackMarketData = UserManager.user.gameData.blackMarketData;
        var _loc5_:int = 0;
        while (_loc5_ < _loc3_) {
            _loc6_ = UserBmiData.fromDto(_loc2_[_loc5_]);
            _loc7_ = _loc4_.boughtItems[_loc6_.typeId];
            if (_loc7_ != null && _loc6_.expireDate != null) {
                _loc8_ = _loc7_.concreteItems.length - 1;
                while (_loc8_ >= 0) {
                    if (_loc7_.concreteItems[_loc8_].expireDate != null && _loc7_.concreteItems[_loc8_].expireDate.time == _loc6_.expireDate.time) {
                        _loc7_.concreteItems.splice(_loc8_, 1);
                        _loc7_.paidCount--;
                    }
                    _loc8_--;
                }
                if (_loc7_.totalCount() <= 0) {
                    delete _loc4_.boughtItems[_loc6_.typeId];
                }
            }
            _loc5_++;
        }
    }
}
}
