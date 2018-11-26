package model.logic.blackMarketModel.core {
import model.logic.blackMarketModel.applyBehaviours.EffectItemApplyBehaviour;
import model.logic.blackMarketModel.buyBehaviours.ForMoneyItemBuyBehaviour;
import model.logic.blackMarketModel.interfaces.IApplyBehaviour;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.BlackMarketItemDiscountContext;

public class EffectUserAttackAndDefencePowerItem extends BlackMarketItemBase {


    public var timeSeconds:Number;

    public var power:Number;

    public function EffectUserAttackAndDefencePowerItem() {
        super();
    }

    override protected function createBuyBehaviour():IBuyBehaviour {
        return new ForMoneyItemBuyBehaviour();
    }

    override protected function createApplyBehaviour():IApplyBehaviour {
        return new EffectItemApplyBehaviour();
    }

    override protected function commitId():void {
        super.commitId();
        discountContext = new BlackMarketItemDiscountContext(id);
    }
}
}
