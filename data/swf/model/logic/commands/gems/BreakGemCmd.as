package model.logic.commands.gems {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class BreakGemCmd extends BaseCmd {


    private var _dto;

    private var _gemId:Number;

    private var _gemRemoving:Boolean;

    public function BreakGemCmd(param1:Number, param2:Boolean = true) {
        super();
        this._dto = UserRefreshCmd.makeRequestDto({"i": param1});
        this._gemId = param1;
        this._gemRemoving = param2;
    }

    override public function execute():void {
        new JsonCallCmd("BreakGem", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _dto)) {
                _loc2_ = UserManager.user.gameData.gemData;
                _loc3_ = null;
                for each(_loc4_ in _loc2_.activeGems) {
                    if (_loc4_.id == _gemId) {
                        _loc3_ = _loc4_;
                        break;
                    }
                }
                if (_loc3_ != null) {
                    _loc2_.activeGems.removeItemAt(_loc2_.activeGems.getItemIndex(_loc3_));
                    if (!_gemRemoving) {
                        _loc2_.gems.addItem(_loc3_);
                    }
                }
                _loc2_.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
