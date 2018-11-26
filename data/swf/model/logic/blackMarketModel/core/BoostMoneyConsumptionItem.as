package model.logic.blackMarketModel.core {
import model.data.Resources;
import model.logic.blackMarketModel.applyBehaviours.BlackMarketItemApplyBehaviour;
import model.logic.blackMarketModel.buyBehaviours.BlackMarketItemBuyBehaviour;
import model.logic.blackMarketModel.interfaces.IApplyBehaviour;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.BlackMarketItemDiscountContext;

public class BoostMoneyConsumptionItem extends BlackMarketItemBase {


    public var durationSecond:Number;

    public var resources:Resources;

    public function BoostMoneyConsumptionItem() {
        super();
    }

    override protected function createBuyBehaviour():IBuyBehaviour {
        return new BlackMarketItemBuyBehaviour();
    }

    override protected function createApplyBehaviour():IApplyBehaviour {
        return new BlackMarketItemApplyBehaviour();
    }

    override protected function commitId():void {
        super.commitId();
        discountContext = new BlackMarketItemDiscountContext(id);
    }
}
}
