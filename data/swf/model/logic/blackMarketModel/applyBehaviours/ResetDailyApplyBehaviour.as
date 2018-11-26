package model.logic.blackMarketModel.applyBehaviours {
import flash.utils.Dictionary;

import model.data.scenes.types.info.BlackMarketUnionTypeIds;
import model.logic.UserManager;
import model.logic.blackMarketItems.ActivateItemResponse;
import model.logic.blackMarketItems.BlackMarketItemsNode;
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;
import model.logic.commands.sector.ActivateBlackMarketItemCmd;

public class ResetDailyApplyBehaviour extends ApplyBehaviourBase {


    private const FIRST_UNION_TYPE_ID:int = BlackMarketUnionTypeIds.RESET_DAILY_CRYSTAL;

    private const SECOND_UNION_TYPE_ID:int = BlackMarketUnionTypeIds.RESET_DAILY_BLACK_CRYSTAL;

    private var _commandCache:ActivateBlackMarketItemCmd;

    private var _itemId:int;

    public function ResetDailyApplyBehaviour() {
        super();
    }

    override public function prepareApply(param1:int, param2:ApplyContext):void {
        var _loc4_:Dictionary = null;
        var _loc5_:BlackMarketItemsNode = null;
        this._itemId = param1;
        var _loc3_:int = param1;
        if (param1 == this.FIRST_UNION_TYPE_ID || param1 == this.SECOND_UNION_TYPE_ID) {
            _loc4_ = UserManager.user.gameData.blackMarketData.boughtItems;
            _loc5_ = _loc4_[param1];
            if (_loc5_ != null && _loc5_.freeCount + _loc5_.paidCount > 0) {
                _loc3_ = param1;
            }
            else if (param1 == this.FIRST_UNION_TYPE_ID) {
                _loc5_ = _loc4_[this.SECOND_UNION_TYPE_ID];
                if (_loc5_ != null && _loc5_.freeCount + _loc5_.paidCount > 0) {
                    _loc3_ = this.SECOND_UNION_TYPE_ID;
                }
            }
            else if (param1 == this.SECOND_UNION_TYPE_ID) {
                _loc5_ = _loc4_[this.FIRST_UNION_TYPE_ID];
                if (_loc5_ != null && _loc5_.freeCount + _loc5_.paidCount > 0) {
                    _loc3_ = this.FIRST_UNION_TYPE_ID;
                }
            }
        }
        this._commandCache = new ActivateBlackMarketItemCmd(_loc3_, param2.useAutoBuying, param2.applyAll);
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
