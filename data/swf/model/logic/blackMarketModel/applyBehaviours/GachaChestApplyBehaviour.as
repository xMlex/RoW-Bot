package model.logic.blackMarketModel.applyBehaviours {
import model.data.users.blackMarket.UserBmiData;
import model.logic.blackMarketItems.ActivateItemResponse;
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;
import model.logic.blackMarketModel.applyBehaviours.contexts.ExpirableItemApplyContext;
import model.logic.commands.clanPurchases.OpenGachaChestCmd;

public class GachaChestApplyBehaviour extends ApplyBehaviourBase {


    private var _commandCache:OpenGachaChestCmd;

    private var _itemId:int;

    public function GachaChestApplyBehaviour() {
        super();
    }

    override public function prepareApply(param1:int, param2:ApplyContext):void {
        var _loc4_:UserBmiData = null;
        var _loc3_:ExpirableItemApplyContext = param2 as ExpirableItemApplyContext;
        if (_loc3_ != null) {
            _loc4_ = new UserBmiData();
            _loc4_.typeId = param1;
            _loc4_.expireDate = _loc3_.expirationDate;
        }
        this._itemId = param1;
        if (this._commandCache == null) {
            this._commandCache = new OpenGachaChestCmd(_loc4_, param2.applyAll);
        }
        else {
            this._commandCache.fillRequestDto(_loc4_, param2.applyAll);
        }
    }

    override public function invoke():void {
        this._commandCache.ifResult(this.resultHandler).ifFault(this.faultHandler).execute();
    }

    private function resultHandler(param1:*, param2:ActivateItemResponse):void {
        param1.activateItemResponse = param2;
        dispatchResult(param1);
    }

    private function faultHandler(param1:*):void {
        trace("OpenGachaChestCmd fault, itemId: " + this._itemId.toString());
        dispatchFault(param1);
    }
}
}
