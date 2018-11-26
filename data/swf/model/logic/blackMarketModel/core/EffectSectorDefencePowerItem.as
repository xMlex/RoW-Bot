package model.logic.blackMarketModel.core {
import model.logic.blackMarketModel.applyBehaviours.EffectSectorDefensePowerBonusApplyBehaviour;
import model.logic.blackMarketModel.buyBehaviours.BlackMarketItemBuyBehaviour;
import model.logic.blackMarketModel.interfaces.IApplyBehaviour;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.BlackMarketItemDiscountContext;

public class EffectSectorDefencePowerItem extends BlackMarketItemBase {


    public var timeSeconds:Number;

    public var power:Number;

    public function EffectSectorDefencePowerItem() {
        super();
    }

    override protected function createBuyBehaviour():IBuyBehaviour {
        return new BlackMarketItemBuyBehaviour();
    }

    override protected function createApplyBehaviour():IApplyBehaviour {
        return new EffectSectorDefensePowerBonusApplyBehaviour();
    }

    override protected function commitId():void {
        super.commitId();
        discountContext = new BlackMarketItemDiscountContext(id);
    }
}
}
