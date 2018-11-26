package model.logic.blackMarketModel.core {
import common.TimeSpan;

import model.logic.blackMarketModel.applyBehaviours.BlackMarketItemApplyBehaviour;
import model.logic.blackMarketModel.buyBehaviours.ForMoneyItemBuyBehaviour;
import model.logic.blackMarketModel.interfaces.IApplyBehaviour;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.BlackMarketItemDiscountContext;

public class AdditionalResearcherItem extends BlackMarketItemBase {


    public var duration:TimeSpan;

    public function AdditionalResearcherItem() {
        super();
    }

    override protected function createBuyBehaviour():IBuyBehaviour {
        return new ForMoneyItemBuyBehaviour();
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
