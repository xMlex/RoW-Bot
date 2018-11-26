package model.logic.commands.inventory {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class ReorderInventoryCmd extends BaseCmd {


    private var _dto;

    private var inventorySlotByItem:Object;

    public function ReorderInventoryCmd(param1:Object) {
        super();
        this._dto = UserRefreshCmd.makeRequestDto({"i": param1});
        this.inventorySlotByItem = param1;
    }

    override public function execute():void {
        new JsonCallCmd("ReorderInventory", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _dto)) {
                _loc2_ = UserManager.user.gameData.inventoryData;
                for each(_loc3_ in _loc2_.inventoryItemsById) {
                    _loc2_.inventoryItemsBySlotId[_loc3_.inventoryItemInfo.slotId] = _loc3_;
                }
            }
            UserManager.user.gameData.inventoryData.dirty = true;
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
