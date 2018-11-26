package model.data.users.acceleration {
import model.data.User;
import model.data.normalization.NEventUser;

public class NEventAdditionalInventoryDestroyerExpired extends NEventUser {


    private var _indexExpiredDestroyer:int;

    public function NEventAdditionalInventoryDestroyerExpired(param1:int, param2:Date) {
        this._indexExpiredDestroyer = param1;
        super(param2);
    }

    override protected function postProcess(param1:User, param2:Date):void {
        var _loc3_:Array = null;
        super.postProcess(param1, param2);
        if (param1.gameData.constructionData && param1.gameData.constructionData.additionalInventoryDestroyerExpireDateTimes) {
            _loc3_ = param1.gameData.constructionData.additionalInventoryDestroyerExpireDateTimes;
            _loc3_.splice(this._indexExpiredDestroyer, 1);
            param1.gameData.constructionData.additionalInventoryDestroyerChanged = true;
        }
    }
}
}
