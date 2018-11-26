package model.logic.blackMarketModel.core {
import model.logic.blackMarketModel.applyBehaviours.StubApplyBehaviour;
import model.logic.blackMarketModel.buyBehaviours.ExtraFavoriteUsersBoostBuyBehaviour;
import model.logic.blackMarketModel.interfaces.IApplyBehaviour;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;

public class ExtraFavoriteUsersBoostItem extends BlackMarketItemBase {


    public var boostValue:int;

    public function ExtraFavoriteUsersBoostItem() {
        super();
    }

    override protected function createBuyBehaviour():IBuyBehaviour {
        return new ExtraFavoriteUsersBoostBuyBehaviour();
    }

    override protected function createApplyBehaviour():IApplyBehaviour {
        return new StubApplyBehaviour();
    }
}
}
