package model.logic.blackMarketModel.core {
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicDate;
import model.logic.blackMarketModel.refreshableBehaviours.dates.BlackMarketExpirableDate;
import model.logic.blackMarketModel.refreshableBehaviours.dates.ExpirableDate;

public class ExpirableItemBase extends BlackMarketItemBase {


    public var expirationDate:IDynamicDate;

    public function ExpirableItemBase() {
        super();
    }

    protected function createExpirationDateBehaviour():IDynamicDate {
        return new BlackMarketExpirableDate(id, new ExpirableDate());
    }

    override protected function commitId():void {
        super.commitId();
        this.expirationDate = this.createExpirationDateBehaviour();
    }
}
}
