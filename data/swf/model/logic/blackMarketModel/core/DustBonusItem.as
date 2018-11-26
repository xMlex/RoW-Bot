package model.logic.blackMarketModel.core {
import model.logic.blackMarketModel.applyBehaviours.StubApplyBehaviour;
import model.logic.blackMarketModel.buyBehaviours.StubBuyBehaviour;
import model.logic.blackMarketModel.interfaces.IApplyBehaviour;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;

public class DustBonusItem extends BlackMarketItemBase {


    public var amount:Number;

    public function DustBonusItem() {
        super();
    }

    override protected function createBuyBehaviour():IBuyBehaviour {
        return new StubBuyBehaviour();
    }

    override protected function createApplyBehaviour():IApplyBehaviour {
        return new StubApplyBehaviour();
    }
}
}
