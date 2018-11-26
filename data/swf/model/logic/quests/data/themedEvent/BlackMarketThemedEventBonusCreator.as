package model.logic.quests.data.themedEvent {
import model.logic.quests.data.Quest;

public class BlackMarketThemedEventBonusCreator extends ThemedBonusCreator {


    public function BlackMarketThemedEventBonusCreator() {
        super();
    }

    override public function bonus():Array {
        var _loc1_:Quest = collectibleThemedItemsEvent();
        if (_loc1_ == null || _loc1_.collectibleThemedItemsEvent.itemsOnBMPurchases == null) {
            return [];
        }
        return _loc1_.collectibleThemedItemsEvent.itemsOnBMPurchases;
    }
}
}
