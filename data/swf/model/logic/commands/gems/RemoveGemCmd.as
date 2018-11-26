package model.logic.commands.gems {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class RemoveGemCmd extends BaseCmd {


    private var _dto;

    private var _gemId:Number;

    private var _itemTypeId:int;

    public function RemoveGemCmd(param1:Number, param2:int) {
        super();
        this._dto = UserRefreshCmd.makeRequestDto({
            "g": param1,
            "i": param2
        });
        this._gemId = param1;
        this._itemTypeId = param2;
    }

    override public function execute():void {
        new JsonCallCmd("RemoveGem", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _dto)) {
                _loc2_ = UserManager.user.gameData.blackMarketData.boughtItems;
                if (_loc2_[_itemTypeId] != undefined) {
                    if (_loc2_[_itemTypeId].freeCount > 0) {
                        _loc2_[_itemTypeId].freeCount--;
                    }
                    else {
                        _loc2_[_itemTypeId].paidCount--;
                    }
                }
                _loc3_ = UserManager.user.gameData.gemData;
                _loc4_ = null;
                for each(_loc5_ in _loc3_.activeGems) {
                    if (_loc5_.id == _gemId) {
                        _loc4_ = _loc5_;
                        break;
                    }
                }
                if (_loc4_ != null) {
                    _loc4_.gemInfo.slotId = -1;
                    _loc3_.activeGems.removeItemAt(_loc3_.activeGems.getItemIndex(_loc4_));
                    _loc3_.gems.addItem(_loc4_);
                }
            }
            _loc3_.dirty = true;
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
