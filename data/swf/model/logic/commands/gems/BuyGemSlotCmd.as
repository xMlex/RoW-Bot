package model.logic.commands.gems {
import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class BuyGemSlotCmd extends BaseCmd {


    private var _dto;

    private var _slotId:int;

    public function BuyGemSlotCmd(param1:Number = -1) {
        super();
        this._slotId = param1;
        if (param1 != -1) {
            this._dto = UserRefreshCmd.makeRequestDto({"i": param1});
        }
        else {
            this._dto = UserRefreshCmd.makeRequestDto();
        }
    }

    override public function execute():void {
        new JsonCallCmd("BuyGemSlot", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _dto)) {
                _loc2_ = UserManager.user.gameData.gemData;
                _loc3_ = 0;
                _loc4_ = UserManager.user.gameData.blackMarketData.boughtItems;
                for (_loc5_ in _loc4_) {
                    _loc3_ = _loc4_[_loc5_] != undefined ? _loc4_[_loc5_].freeCount + _loc4_[_loc5_].paidCount : 0;
                    if (_loc5_ == BlackMarketItemsTypeId.Slot_Rock && _loc3_ > 0) {
                        if (param1) {
                            _loc4_[_loc5_].paidCount--;
                        }
                        else {
                            _loc4_[_loc5_].freeCount--;
                        }
                        break;
                    }
                }
                _loc2_.activeGemsCount = !!_loc2_.activeGemsCount ? _loc2_.activeGemsCount + 1 : 2;
                if (_loc2_.activatedSlots != null) {
                    _loc2_.activatedSlots.push(_slotId);
                }
                else {
                    _loc2_.activatedSlots = [_slotId];
                }
                _loc2_.dirty = true;
                _loc2_.dispatchEvents();
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
