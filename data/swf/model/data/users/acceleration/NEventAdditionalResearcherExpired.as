package model.data.users.acceleration {
import model.data.User;
import model.data.normalization.NEventUser;

public class NEventAdditionalResearcherExpired extends NEventUser {


    private var _indexExpiredResearcher:int;

    public function NEventAdditionalResearcherExpired(param1:int, param2:Date) {
        this._indexExpiredResearcher = param1;
        super(param2);
    }

    override protected function postProcess(param1:User, param2:Date):void {
        var _loc3_:Array = null;
        super.postProcess(param1, param2);
        if (param1.gameData.constructionData && param1.gameData.constructionData.additionalResearchersExpireDateTimes) {
            _loc3_ = param1.gameData.constructionData.additionalResearchersExpireDateTimes;
            _loc3_.splice(this._indexExpiredResearcher, 1);
            param1.gameData.constructionData.additionalResearcherChanged = true;
        }
    }
}
}
