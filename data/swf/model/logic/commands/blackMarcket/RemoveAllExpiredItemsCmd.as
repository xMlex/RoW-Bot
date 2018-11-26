package model.logic.commands.blackMarcket {
import model.data.users.blackMarket.UserBmiData;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class RemoveAllExpiredItemsCmd extends BaseCmd {


    private var requestDto;

    public function RemoveAllExpiredItemsCmd() {
        super();
        this.requestDto = UserRefreshCmd.makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("BlackMarket.RemoveAllExpiredItems", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            var _loc6_:* = undefined;
            var _loc7_:* = undefined;
            if (param1.o) {
                _loc2_ = param1.o.z;
                _loc3_ = UserManager.user.gameData.blackMarketData;
                _loc4_ = 0;
                while (_loc4_ < _loc2_.length) {
                    _loc5_ = UserBmiData.fromDto(_loc2_[_loc4_]);
                    _loc6_ = _loc3_.boughtItems[_loc5_.typeId];
                    if (_loc5_.expireDate != null) {
                        _loc7_ = _loc6_.concreteItems.length - 1;
                        while (_loc7_ >= 0) {
                            if (_loc6_.concreteItems[_loc7_].expireDate != null && _loc6_.concreteItems[_loc7_].expireDate.time == _loc5_.expireDate.time) {
                                _loc6_.concreteItems.splice(_loc7_, 1);
                                _loc6_.paidCount--;
                            }
                            _loc7_--;
                        }
                    }
                    _loc4_++;
                }
                _loc3_.dirty = true;
                if (_onResult != null) {
                    _onResult();
                }
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
