package model.logic.commands.gems {
import common.ArrayCustom;

import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class ActivateGemCmd extends BaseCmd {


    private var _dto;

    private var _gemId:Number;

    private var _slotId:int;

    public function ActivateGemCmd(param1:Number, param2:int) {
        super();
        this._dto = UserRefreshCmd.makeRequestDto({
            "g": param1,
            "s": param2
        });
        this._gemId = param1;
        this._slotId = param2;
    }

    override public function execute():void {
        new JsonCallCmd("ActivateGem", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _dto)) {
                _loc2_ = UserManager.user.gameData.gemData;
                _loc3_ = null;
                for each(_loc4_ in _loc2_.gems) {
                    if (_loc4_.id == _gemId) {
                        _loc3_ = _loc4_;
                        break;
                    }
                }
                if (_loc3_ != null) {
                    _loc3_.gemInfo.slotId = _slotId;
                    _loc2_.gems.removeItemAt(_loc2_.gems.getItemIndex(_loc3_));
                    if (_loc2_.activeGems == null) {
                        _loc2_.activeGems = new ArrayCustom();
                    }
                    _loc2_.activeGems.addItem(_loc3_);
                }
            }
            UserManager.user.gameData.gemData.dirty = true;
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
