package model.logic.blackMarketModel.core {
import model.data.temporarySkins.TemporarySkin;
import model.logic.blackMarketModel.applyBehaviours.SectorSkinApplyBehaviour;
import model.logic.blackMarketModel.applyBehaviours.TempSectorSkinApplyBehaviour;
import model.logic.blackMarketModel.buyBehaviours.BlackMarketItemBuyBehaviour;
import model.logic.blackMarketModel.buyBehaviours.SectorSkinBuyBehaviour;
import model.logic.blackMarketModel.interfaces.IApplyBehaviour;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;
import model.logic.blackMarketModel.interfaces.IDiscountContext;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.SectorSkinDiscountContext;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.StubDiscountContext;

public class SectorSkinItem extends BlackMarketItemBase {


    public var defencePoints:int;

    public var requiredLevel:int;

    public var isTemporary:Boolean;

    public var isForBankSells:Boolean;

    public var temporarySkinData:TemporarySkin;

    public var skinTypeId:int;

    public function SectorSkinItem() {
        super();
    }

    override protected function createBuyBehaviour():IBuyBehaviour {
        if (this.isTemporary) {
            return new BlackMarketItemBuyBehaviour();
        }
        return new SectorSkinBuyBehaviour();
    }

    override protected function createApplyBehaviour():IApplyBehaviour {
        if (this.isTemporary) {
            return new TempSectorSkinApplyBehaviour();
        }
        return new SectorSkinApplyBehaviour();
    }

    override protected function commitId():void {
        super.commitId();
        discountContext = !!this.isTemporary ? new StubDiscountContext() : new SectorSkinDiscountContext(_id);
    }
}
}
