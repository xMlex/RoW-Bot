package model.logic.blackMarketModel.core {
import model.logic.blackMarketModel.refreshableBehaviours.discounts.ChestItemDiscountContext;

public class ChestItem extends ExtractorItem {


    public var gemsCount:int;

    public function ChestItem() {
        super();
    }

    override protected function commitId():void {
        super.commitId();
        discountContext = new ChestItemDiscountContext(id);
    }
}
}
