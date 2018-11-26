package model.logic.blackMarketModel.core {
import model.logic.blackMarketModel.buyBehaviours.BlackCrystalDrawingPartBuyBehaviour;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.StubDiscountContext;

public class BlackCrystalDrawingItem extends DrawingItem {


    public function BlackCrystalDrawingItem() {
        super();
    }

    override protected function createBuyBehaviour():IBuyBehaviour {
        return new BlackCrystalDrawingPartBuyBehaviour();
    }

    override protected function commitId():void {
        super.commitId();
        discountContext = new StubDiscountContext();
    }
}
}
