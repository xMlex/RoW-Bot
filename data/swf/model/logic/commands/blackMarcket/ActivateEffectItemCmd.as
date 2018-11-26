package model.logic.commands.blackMarcket {
import model.data.effects.EffectItem;
import model.data.effects.EffectsManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class ActivateEffectItemCmd extends BaseCmd {


    private var _requestDto;

    private var _typeId:int;

    public function ActivateEffectItemCmd(param1:int, param2:Number) {
        super();
        this._typeId = param1;
        var _loc3_:Object = {
            "i": param1,
            "t": param2
        };
        this._requestDto = UserRefreshCmd.makeRequestDto(_loc3_);
    }

    override public function execute():void {
        new JsonCallCmd("EffectManager.ActivateEffectItem", this._requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _requestDto)) {
                _loc2_ = UserManager.user.gameData.blackMarketData.boughtItems;
                _loc3_ = _loc2_[_typeId];
                if (_loc3_) {
                    if (_loc3_.freeCount + _loc3_.paidCount == 1) {
                        delete _loc2_[_typeId];
                    }
                    else if (_loc3_.freeCount > 0) {
                        _loc3_.freeCount--;
                    }
                    else {
                        _loc3_.paidCount--;
                    }
                }
                UserManager.user.gameData.blackMarketData.dirty = true;
                _loc4_ = EffectItem.fromDto(param1.o);
                EffectsManager.addEffect(_loc4_);
                EffectsManager.deleteDependentEffectsByItemTypeId(_typeId);
            }
            if (_onResult != null) {
                _onResult(param1.o);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
