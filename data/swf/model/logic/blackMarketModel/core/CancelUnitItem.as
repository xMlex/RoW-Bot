package model.logic.blackMarketModel.core {
import model.logic.blackMarketModel.applyBehaviours.CancelUnitApplyBehaviour;
import model.logic.blackMarketModel.buyBehaviours.BlackMarketItemBuyBehaviour;
import model.logic.blackMarketModel.interfaces.IApplyBehaviour;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.BlackMarketItemDiscountContext;

public class CancelUnitItem extends BlackMarketItemBase {


    public function CancelUnitItem() {
        super();
    }

    override protected function createBuyBehaviour():IBuyBehaviour {
        return new BlackMarketItemBuyBehaviour();
    }

    override protected function createApplyBehaviour():IApplyBehaviour {
        return new CancelUnitApplyBehaviour();
    }

    override protected function commitId():void {
        super.commitId();
        discountContext = new BlackMarketItemDiscountContext(id);
    }
}
}
