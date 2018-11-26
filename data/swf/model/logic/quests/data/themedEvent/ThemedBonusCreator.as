package model.logic.quests.data.themedEvent {
import configs.Global;

import model.logic.UserManager;
import model.logic.quests.data.Quest;
import model.logic.quests.data.QuestState;

public class ThemedBonusCreator {


    public function ThemedBonusCreator() {
        super();
    }

    public function bonus():Array {
        return [];
    }

    protected function collectibleThemedItemsEvent():Quest {
        if (!Global.COLLECTIBLE_THEMED_ITEMS_EVENT_ENABLED) {
            return null;
        }
        var _loc1_:QuestState = UserManager.user.gameData.questData.activeThemedEvent;
        return _loc1_ == null ? null : UserManager.user.gameData.questData.questById[_loc1_.questId];
    }
}
}
