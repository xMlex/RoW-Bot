package model.logic.blackMarketModel.core {
import model.logic.blackMarketModel.applyBehaviours.StubApplyBehaviour;
import model.logic.blackMarketModel.buyBehaviours.StubBuyBehaviour;
import model.logic.blackMarketModel.interfaces.IApplyBehaviour;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;

public class DrawingPartItem extends BlackMarketItemBase {


    public var drawingId:int;

    public var partNumber:int;

    public function DrawingPartItem() {
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
