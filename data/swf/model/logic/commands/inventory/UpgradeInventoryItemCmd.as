package model.logic.commands.inventory {
import model.data.effects.EffectSource;
import model.data.effects.EffectTypeId;
import model.logic.ServerTimeManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class UpgradeInventoryItemCmd extends BaseCmd {


    private var _dto;

    private var itemId:Number;

    public function UpgradeInventoryItemCmd(param1:int) {
        super();
        this._dto = UserRefreshCmd.makeRequestDto({"i": param1});
        this.itemId = param1;
    }

    override public function execute():void {
        new JsonCallCmd("UpgradeInventoryItem", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            var _loc2_:* = UserManager.user.gameData;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _dto)) {
                _loc3_ = _loc2_.inventoryData.inventoryItemsById[_dto.o.i];
                _loc3_.constructionInfo.constructionStartTime = ServerTimeManager.serverTimeNow;
                _loc3_.constructionInfo.constructionFinishTime = new Date(param1.o.t);
                _loc4_ = _loc2_.effectData.getFirstActiveEffectBySource(EffectTypeId.GppInventoryItemUpgradeBonus, EffectSource.GiftPointsProgram);
                if (_loc4_ != null && _loc4_.activeState.usageCount > 0) {
                    _loc3_.constructionInfo.constructionBonusPowerByEffectTypeId[EffectTypeId.GppInventoryItemUpgradeBonus] = _loc4_.activeState.power;
                    _loc2_.effectData.decrementEffectUseCount(EffectTypeId.GppInventoryItemUpgradeBonus, EffectSource.GiftPointsProgram);
                }
                _loc5_ = _loc2_.inventoryData;
                _loc5_.dustAmount = _loc5_.dustAmount - param1.o.d;
            }
            _loc2_.inventoryData.dirty = true;
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
