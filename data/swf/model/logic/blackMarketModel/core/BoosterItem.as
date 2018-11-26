package model.logic.blackMarketModel.core {
import model.logic.blackMarketModel.applyBehaviours.BlackMarketItemApplyBehaviour;
import model.logic.blackMarketModel.buyBehaviours.BlackMarketItemBuyBehaviour;
import model.logic.blackMarketModel.interfaces.IApplyBehaviour;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.BoosterItemDiscountContext;

public class BoosterItem extends BlackMarketItemBase {


    public var duration:Number;

    public var boostRatio:Number;

    public var isForSupportTroops:Boolean;

    public function BoosterItem() {
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
        discountContext = new BoosterItemDiscountContext(id);
    }
}
}
