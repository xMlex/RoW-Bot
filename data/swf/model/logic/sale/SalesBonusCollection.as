package model.logic.sale {
import common.ArrayCustom;

import model.data.UserPrize;
import model.logic.sale.bonusItem.BonusItemCollection;
import model.logic.sale.bonusItem.BonusItemDescriptions;
import model.logic.sale.bonusItem.BonusItemFullNames;
import model.logic.sale.bonusItem.BonusItemImages;
import model.logic.sale.bonusItem.BonusItemTitles;
import model.logic.sale.bonusItem.IBonusItemActionBehaviour;

public class SalesBonusCollection {


    protected var bonusItemsCollection:BonusItemCollection;

    public function SalesBonusCollection() {
        super();
        this.bonusItemsCollection = new BonusItemCollection();
        this.bonusItemsCollection.setImageCreator(this.createBonusItemImages()).setFullNameCreator(new BonusItemFullNames()).setTitleCreator(new BonusItemTitles()).setDescriptionCreator(new BonusItemDescriptions()).setActionBehaviourCreator(this.createBonusItemActionBehaviour());
    }

    protected function createBonusItemImages():BonusItemImages {
        return new BonusItemImages();
    }

    protected function createBonusItemActionBehaviour():IBonusItemActionBehaviour {
        return null;
    }

    public function getCollection(param1:UserPrize, param2:Boolean = true):ArrayCustom {
        return this.bonusItemsCollection.createBonusesArray(param1, param2);
    }
}
}
