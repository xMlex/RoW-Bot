package model.logic.commands.inventory {
import model.data.Resources;
import model.data.inventory.UserInventorySlot;
import model.data.stats.GoldMoneySourceType;
import model.logic.PaymentManager;
import model.logic.ServerTimeManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class BuyInventoryStorageSlotCmd extends BaseCmd {


    private var slotsInfo:Vector.<UserInventorySlot>;

    private var _dto;

    public function BuyInventoryStorageSlotCmd(param1:Vector.<UserInventorySlot>) {
        super();
        this.slotsInfo = param1;
        this._dto = UserRefreshCmd.makeRequestDto();
    }

    override public function execute():void {
        new JsonCallCmd("BuyInventoryStorageSlots", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _dto)) {
                _loc2_ = param1.o.p == null ? null : Resources.fromDto(param1.o.p);
                if (_loc2_ != null) {
                    UserManager.user.gameData.account.resources.substract(_loc2_);
                }
                _loc3_ = 0;
                while (_loc3_ < slotsInfo.length) {
                    slotsInfo[_loc3_].locked = false;
                    _loc3_++;
                }
                PaymentManager.addPayment(_loc2_.goldMoney, int(UserManager.user.gameData.account.resources.goldMoney), ServerTimeManager.serverTimeNow, GoldMoneySourceType.InventoryStorageSlotBuying);
            }
            UserManager.user.gameData.inventoryData.dirty = true;
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
