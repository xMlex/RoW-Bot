package model.logic.blackMarketModel.refreshableBehaviours.itemCounts {
import model.logic.UserManager;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicInteger;

public class ConstructionBlockCount implements IDynamicInteger {


    public function ConstructionBlockCount() {
        super();
    }

    public function get value():int {
        if (UserManager.user.gameData.invitationData) {
            return UserManager.user.gameData.invitationData.constructionBlockCount;
        }
        return 0;
    }

    public function refresh():void {
    }

    public function onChange(param1:Function):void {
    }
}
}
