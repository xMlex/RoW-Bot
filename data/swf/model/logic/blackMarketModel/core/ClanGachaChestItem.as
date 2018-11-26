package model.logic.blackMarketModel.core {
import model.logic.blackMarketModel.applyBehaviours.GachaChestApplyBehaviour;
import model.logic.blackMarketModel.buyBehaviours.StubBuyBehaviour;
import model.logic.blackMarketModel.deleteBehaviours.GachaExpirableItemDeleteBehaviour;
import model.logic.blackMarketModel.interfaces.IApplyBehaviour;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.BlackMarketItemDiscountContext;
import model.logic.blackMarketModel.services.ItemDeleteService;
import model.logic.blackMarketModel.services.interfaces.IDeleteService;

public class ClanGachaChestItem extends BlackMarketItemBase {


    public var gachaChestTypeId:int;

    public var deleteService:IDeleteService;

    public function ClanGachaChestItem() {
        super();
    }

    override protected function createBuyBehaviour():IBuyBehaviour {
        return new StubBuyBehaviour();
    }

    override protected function createApplyBehaviour():IApplyBehaviour {
        return new GachaChestApplyBehaviour();
    }

    override protected function commitId():void {
        super.commitId();
        this.deleteService = new ItemDeleteService(id, new GachaExpirableItemDeleteBehaviour());
        discountContext = new BlackMarketItemDiscountContext(id);
    }
}
}
