package model.logic.blackMarketModel.refreshableBehaviours.itemCounts {
import flash.utils.Dictionary;

import model.data.UserGameData;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemsNode;

public class GachaChestCount extends BlackMarketItemCount {


    public function GachaChestCount(param1:int) {
        super(param1);
    }

    override protected function boughtItemsById(param1:int):int {
        var _loc2_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        var _loc3_:UserGameData = UserManager.user.gameData;
        var _loc4_:Dictionary = _loc3_.blackMarketData.boughtItems;
        if (_loc4_ == null || _loc4_[param1] == undefined) {
            _loc5_ = 0;
        }
        else {
            _loc5_ = (_loc4_[param1] as BlackMarketItemsNode).totalCount();
        }
        var _loc7_:Array = _loc3_.clanPurchaseData.getExpiredChestsByBMItemId(param1);
        _loc6_ = _loc7_ != null ? int(_loc7_.length) : 0;
        _loc2_ = _loc5_ + _loc6_;
        return _loc2_;
    }
}
}
