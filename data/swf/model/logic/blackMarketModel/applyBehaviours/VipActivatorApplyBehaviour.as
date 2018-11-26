package model.logic.blackMarketModel.applyBehaviours {
import common.ArrayCustom;

import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.ActivateItemResponse;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;
import model.logic.commands.sector.ActivateBlackMarketItemCmd;

public class VipActivatorApplyBehaviour extends ApplyBehaviourBase {


    private var _commandCache:ActivateBlackMarketItemCmd;

    private var _itemId:int;

    public function VipActivatorApplyBehaviour() {
        super();
    }

    private function findId():int {
        var _loc1_:BlackMarketItemRaw = StaticDataManager.blackMarketData.itemsById[this._itemId];
        var _loc2_:ArrayCustom = UserManager.user.gameData.blackMarketData.boughtActivatorsByTime[_loc1_.vipActivatorData.durationSeconds];
        var _loc3_:BlackMarketItemRaw = !!_loc2_ ? _loc2_[0] : null;
        if (_loc3_) {
            return _loc3_.id;
        }
        return this._itemId;
    }

    override public function prepareApply(param1:int, param2:ApplyContext):void {
        this._itemId = param1;
        this._commandCache = new ActivateBlackMarketItemCmd(this.findId(), param2.useAutoBuying);
    }

    override public function invoke():void {
        this._commandCache.ifResult(this.resultHandler).ifFault(this.faultHandler).execute();
    }

    private function resultHandler(param1:*, param2:ActivateItemResponse):void {
        param1.activateItemResponse = param2;
        dispatchResult(param1);
    }

    private function faultHandler(param1:*):void {
        trace("BlackMarketItem Activation fault, itemId: " + this._itemId.toString());
        dispatchFault(param1);
    }
}
}
