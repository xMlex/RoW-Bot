package model.logic.blackMarketModel.core {
import model.logic.blackMarketModel.applyBehaviours.StubApplyBehaviour;
import model.logic.blackMarketModel.buyBehaviours.StubBuyBehaviour;
import model.logic.blackMarketModel.interfaces.IApplyBehaviour;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.BuildingDiscountContext;
import model.logic.filterSystem.dataProviders.ILevelProvider;

public class BuildingItem extends BlackMarketItemBase implements ILevelProvider {


    public var isDefence:Boolean;

    public var defenceBonus:int;

    public var techLevel:int;

    public var requiredLevel:int;

    public function BuildingItem() {
        super();
    }

    public function get level():int {
        return this.requiredLevel;
    }

    override protected function createBuyBehaviour():IBuyBehaviour {
        return new StubBuyBehaviour();
    }

    override protected function createApplyBehaviour():IApplyBehaviour {
        return new StubApplyBehaviour();
    }

    override protected function commitId():void {
        super.commitId();
        discountContext = new BuildingDiscountContext(_id);
    }
}
}
