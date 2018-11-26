package model.logic.blackMarketModel.deleteBehaviours {
import model.data.UserPrize;
import model.data.clanPurchases.GachaChestItem;
import model.data.clanPurchases.UserClanPurchaseData;
import model.logic.UserManager;
import model.logic.blackMarketModel.deleteBehaviours.contexts.ChestDeleteContext;
import model.logic.blackMarketModel.deleteBehaviours.contexts.DeleteContext;
import model.logic.commands.clanPurchases.RemoveGachaChestCmd;

public class GachaExpirableItemDeleteBehaviour extends DeleteBehaviourBase {


    private var _commandCache:RemoveGachaChestCmd;

    private var _itemId:int;

    private var _userChestId:int;

    private var _isRemovingAll:Boolean;

    private var _deletingChests:Array;

    public function GachaExpirableItemDeleteBehaviour() {
        super();
    }

    override public function prepareDelete(param1:int, param2:DeleteContext):void {
        var _loc3_:ChestDeleteContext = param2 as ChestDeleteContext;
        if (_loc3_ != null) {
            this._userChestId = _loc3_.userChestId;
        }
        else {
            this._userChestId = -1;
        }
        this._isRemovingAll = param2.itemIds != null && param2.itemIds.length > 0;
        this._itemId = param1;
        this._commandCache = new RemoveGachaChestCmd(this._userChestId, this._isRemovingAll);
    }

    override public function invoke():void {
        var _loc1_:UserClanPurchaseData = UserManager.user.gameData.clanPurchaseData;
        if (this._isRemovingAll) {
            this._deletingChests = _loc1_.expiredGachaChests;
        }
        else {
            this._deletingChests = [_loc1_.getExpiredChestById(this._userChestId)];
        }
        this._commandCache.ifResult(this.resultHandler).ifFault(this.faultHandler).execute();
    }

    private function resultHandler(param1:*):void {
        var _loc4_:GachaChestItem = null;
        var _loc2_:UserPrize = new UserPrize();
        var _loc3_:int = 0;
        if (this._deletingChests != null && this._deletingChests.length > 0) {
            for each(_loc4_ in this._deletingChests) {
                if (_loc4_.reward != null) {
                    _loc2_.sourceMerge(_loc4_.reward);
                    _loc3_++;
                }
            }
        }
        param1.prizes = _loc2_;
        param1.count = _loc3_;
        dispatchResult(param1);
    }

    private function faultHandler(param1:*):void {
        dispatchFault(param1);
    }
}
}
