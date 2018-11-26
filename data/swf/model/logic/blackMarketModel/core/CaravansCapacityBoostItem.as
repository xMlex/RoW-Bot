package model.logic.blackMarketModel.core {
import model.logic.blackMarketModel.applyBehaviours.StubApplyBehaviour;
import model.logic.blackMarketModel.buyBehaviours.CaravansCapacityBoostBuyBehaviour;
import model.logic.blackMarketModel.interfaces.IApplyBehaviour;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;

public class CaravansCapacityBoostItem extends BlackMarketItemBase {


    public var boostValue:int;

    public function CaravansCapacityBoostItem() {
        super();
    }

    override protected function createBuyBehaviour():IBuyBehaviour {
        return new CaravansCapacityBoostBuyBehaviour();
    }

    override protected function createApplyBehaviour():IApplyBehaviour {
        return new StubApplyBehaviour();
    }
}
}
