package model.logic.commands.inventory {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class RemoveInventoryItemCmd extends BaseCmd {


    private var _dto;

    private var itemId:Number;

    public function RemoveInventoryItemCmd(param1:int) {
        super();
        this._dto = UserRefreshCmd.makeRequestDto({"i": param1});
        this.itemId = param1;
    }

    override public function execute():void {
        new JsonCallCmd("RemoveInventoryItem", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _dto)) {
                _loc2_ = UserManager.user.gameData.inventoryData.inventoryItemsById[_dto.o.i];
                _loc2_.inventoryItemInfo.slotId = -1;
                UserManager.user.gameData.inventoryData.updateInventoryItemsBySlotId();
            }
            UserManager.user.gameData.inventoryData.dirty = true;
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
