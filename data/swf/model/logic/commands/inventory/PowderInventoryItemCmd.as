package model.logic.commands.inventory {
import model.data.effects.EffectSource;
import model.data.effects.EffectTypeId;
import model.logic.ServerTimeManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class PowderInventoryItemCmd extends BaseCmd {


    private var _dto;

    private var inventoryItemId:Number;

    public function PowderInventoryItemCmd(param1:Number) {
        super();
        this._dto = UserRefreshCmd.makeRequestDto({"i": param1});
        this.inventoryItemId = param1;
    }

    override public function execute():void {
        new JsonCallCmd("PowderInventoryItem", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _dto)) {
                _loc2_ = UserManager.user.gameData.inventoryData.inventoryItemsById[_dto.o.i];
                _loc2_.constructionInfo.constructionStartTime = ServerTimeManager.serverTimeNow;
                _loc2_.constructionInfo.constructionFinishTime = new Date(param1.o.t);
                _loc2_.constructionInfo.isDestruction = true;
                UserManager.user.gameData.effectData.decrementEffectUseCount(EffectTypeId.GppInventoryItemInstantPowdering, EffectSource.GiftPointsProgram);
            }
            UserManager.user.gameData.inventoryData.dirty = true;
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
