package model.logic.blackMarketModel.core {
import model.logic.blackMarketModel.applyBehaviours.StubApplyBehaviour;
import model.logic.blackMarketModel.buyBehaviours.DrawingPartBuyBehaviour;
import model.logic.blackMarketModel.interfaces.IApplyBehaviour;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.SceneObjectTypeDiscountContext;
import model.logic.filterSystem.dataProviders.ILevelProvider;

public class DrawingItem extends BlackMarketItemBase implements ILevelProvider {


    public var drawingId:int;

    public var parts:Vector.<DrawingPartItem>;

    public var requiredLevel:int;

    public function DrawingItem() {
        super();
        this.parts = new Vector.<DrawingPartItem>();
    }

    public function get level():int {
        return this.requiredLevel;
    }

    override protected function createBuyBehaviour():IBuyBehaviour {
        return new DrawingPartBuyBehaviour();
    }

    override protected function createApplyBehaviour():IApplyBehaviour {
        return new StubApplyBehaviour();
    }

    override protected function commitId():void {
        super.commitId();
        discountContext = new SceneObjectTypeDiscountContext(_id);
    }
}
}
