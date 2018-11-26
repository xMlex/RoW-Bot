package model.data.rewardIcons {
import model.logic.UserManager;
import model.logic.quests.data.Quest;
import model.logic.quests.data.QuestState;

public class ThemedEventRewardUrl extends RewardUrl {

    private static const FOLDER:String = "themedEvents/";

    private static var _questPrototypeId:int;

    private static var _themedEventFolder:String;


    public function ThemedEventRewardUrl(param1:int) {
        super(FOLDER + this.currentFolderThemedItemsEvent() + param1);
    }

    protected function currentFolderThemedItemsEvent():String {
        var _loc2_:Quest = null;
        var _loc1_:QuestState = UserManager.user.gameData.questData.activeThemedEvent;
        if (_loc1_ == null) {
            return "";
        }
        if (_questPrototypeId != _loc1_.prototypeId) {
            _questPrototypeId = _loc1_.prototypeId;
            _loc2_ = UserManager.user.gameData.questData.getQuestById(_loc1_.questId);
            _themedEventFolder = _loc2_.collectibleThemedItemsEvent.itemIcons + "/";
        }
        return _themedEventFolder;
    }
}
}
