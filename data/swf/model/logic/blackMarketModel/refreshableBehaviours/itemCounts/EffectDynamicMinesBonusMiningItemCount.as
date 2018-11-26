package model.logic.blackMarketModel.refreshableBehaviours.itemCounts {
import model.data.scenes.types.info.BlackMarketUnionTypeIds;

public class EffectDynamicMinesBonusMiningItemCount extends BlackMarketItemCount {


    private const FIRST_TYPE_ID:int = BlackMarketUnionTypeIds.DYNAMIC_MINES_BONUS_MINING_25P_CRYSTAL;

    private const SECOND_TYPE_ID:int = BlackMarketUnionTypeIds.DYNAMIC_MINES_BONUS_MINING_25P_BLACK_CRYSTAL;

    public function EffectDynamicMinesBonusMiningItemCount(param1:int) {
        super(param1);
    }

    override public function refresh():void {
        var _loc1_:int = 0;
        if (itemId == this.FIRST_TYPE_ID || itemId == this.SECOND_TYPE_ID) {
            _loc1_ = _loc1_ + boughtItemsById(this.FIRST_TYPE_ID);
            _loc1_ = _loc1_ + boughtItemsById(this.SECOND_TYPE_ID);
        }
        else {
            _loc1_ = _loc1_ + boughtItemsById(itemId);
        }
        checkAndDispatch(_loc1_);
    }
}
}
