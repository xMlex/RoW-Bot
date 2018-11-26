package model.logic.blackMarketModel.core {
import model.logic.blackMarketModel.applyBehaviours.StubApplyBehaviour;
import model.logic.blackMarketModel.buyBehaviours.SaleConsumptionBuyBehaviour;
import model.logic.blackMarketModel.interfaces.IApplyBehaviour;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.SaleConsumptionDiscountContext;

public class SaleConsumptionItem extends BlackMarketItemBase {


    public var saleConsumptionBonus:int;

    public function SaleConsumptionItem() {
        super();
    }

    override protected function createBuyBehaviour():IBuyBehaviour {
        return new SaleConsumptionBuyBehaviour();
    }

    override protected function createApplyBehaviour():IApplyBehaviour {
        return new StubApplyBehaviour();
    }

    override protected function commitId():void {
        super.commitId();
        discountContext = new SaleConsumptionDiscountContext(_id);
    }
}
}
