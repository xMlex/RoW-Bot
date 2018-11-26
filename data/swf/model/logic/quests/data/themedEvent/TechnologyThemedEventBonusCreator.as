package model.logic.quests.data.themedEvent {
import model.logic.quests.data.Quest;

public class TechnologyThemedEventBonusCreator extends ThemedBonusCreator {


    public function TechnologyThemedEventBonusCreator() {
        super();
    }

    override public function bonus():Array {
        var _loc1_:Quest = collectibleThemedItemsEvent();
        if (_loc1_ == null || _loc1_.collectibleThemedItemsEvent.itemsOnUpgradingTechnologies == null) {
            return [];
        }
        return _loc1_.collectibleThemedItemsEvent.itemsOnUpgradingTechnologies;
    }
}
}
