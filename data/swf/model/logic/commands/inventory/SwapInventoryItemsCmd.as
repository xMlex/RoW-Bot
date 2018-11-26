package model.logic.commands.inventory {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class SwapInventoryItemsCmd extends BaseCmd {


    private var _dto;

    public var activeItemId:Number;

    public var storageItemId:Number;

    public function SwapInventoryItemsCmd(param1:Number, param2:Number) {
        super();
        this._dto = UserRefreshCmd.makeRequestDto({
            "i": param1,
            "s": param2
        });
        this.activeItemId = param1;
        this.storageItemId = param2;
    }

    override public function execute():void {
        new JsonCallCmd("SwapInventoryItems", this._dto, "POST").ifResult(function (param1:*):void {
            if (!UserRefreshCmd.updateUserByResultDto(param1, _dto)) {
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
