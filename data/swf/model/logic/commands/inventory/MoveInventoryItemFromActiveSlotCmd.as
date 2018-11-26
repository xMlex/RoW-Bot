package model.logic.commands.inventory {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class MoveInventoryItemFromActiveSlotCmd extends BaseCmd {


    private var _dto;

    public var inventoryItemId:Number;

    public var targetInventorySlotId:Number;

    public function MoveInventoryItemFromActiveSlotCmd(param1:Number, param2:Number) {
        super();
        this._dto = UserRefreshCmd.makeRequestDto({
            "i": param1,
            "s": param2
        });
        this.inventoryItemId = param1;
        this.targetInventorySlotId = param2;
    }

    override public function execute():void {
        new JsonCallCmd("MoveInventoryItemFromActiveSlot", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _dto)) {
                _loc2_ = UserManager.user.gameData.inventoryData.inventoryItemsById[inventoryItemId];
                _loc2_.inventoryItemInfo.slotId = targetInventorySlotId;
                UserManager.user.gameData.inventoryData.updateInventoryItemsBySlotId();
                UserManager.user.gameData.inventoryData.updateTroopsBonusData();
                UserManager.user.gameData.inventoryData.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
