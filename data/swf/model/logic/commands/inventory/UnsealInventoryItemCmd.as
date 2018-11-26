package model.logic.commands.inventory {
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class UnsealInventoryItemCmd extends BaseCmd {


    private var _dto;

    private var itemId:Number;

    private var keyId:Number;

    public function UnsealInventoryItemCmd(param1:int, param2:int) {
        super();
        this._dto = UserRefreshCmd.makeRequestDto({"i": param1});
        this.itemId = param1;
        this.keyId = param2;
    }

    override public function execute():void {
        new JsonCallCmd("UnsealInventoryItem", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _dto)) {
                _loc2_ = UserManager.user.gameData.inventoryData.inventoryItemsById[_dto.o.i];
                _loc2_.type = StaticDataManager.getObjectType(param1.o.i);
                _loc2_.inventoryItemInfo.baseAttackBonus = param1.o.a;
                _loc2_.inventoryItemInfo.baseDefenseBonus = param1.o.d;
                _loc2_.inventoryItemInfo.sealed = false;
                _loc3_ = UserManager.user.gameData.blackMarketData.boughtItems;
                _loc4_ = _loc3_[keyId];
                if (_loc4_.freeCount > 0) {
                    _loc4_.freeCount--;
                }
                else if (_loc4_.paidCount > 0) {
                    _loc4_.paidCount--;
                }
                UserManager.user.gameData.blackMarketData.dirty = true;
            }
            UserManager.user.gameData.inventoryData.dirty = true;
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
