package model.logic.blackMarketModel.core {
import model.logic.blackMarketModel.applyBehaviours.ClanChestApplyBehaviour;
import model.logic.blackMarketModel.buyBehaviours.BlackMarketItemBuyBehaviour;
import model.logic.blackMarketModel.deleteBehaviours.BlackMarketExpirableItemDeleteBehaviour;
import model.logic.blackMarketModel.interfaces.IApplyBehaviour;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.BlackMarketItemDiscountContext;
import model.logic.blackMarketModel.services.ItemDeleteService;
import model.logic.blackMarketModel.services.interfaces.IDeleteService;

public class ClanItem extends ExpirableItemBase {


    public var packId:int;

    public var deleteService:IDeleteService;

    public function ClanItem() {
        super();
    }

    override protected function createBuyBehaviour():IBuyBehaviour {
        return new BlackMarketItemBuyBehaviour();
    }

    override protected function createApplyBehaviour():IApplyBehaviour {
        return new ClanChestApplyBehaviour();
    }

    override protected function commitId():void {
        super.commitId();
        this.deleteService = new ItemDeleteService(id, new BlackMarketExpirableItemDeleteBehaviour());
        discountContext = new BlackMarketItemDiscountContext(id);
    }
}
}
