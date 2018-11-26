package model.data.users.acceleration {
import model.data.User;
import model.data.normalization.NEventUser;

public class NEventAdditionalWorkerExpired extends NEventUser {


    private var indexExpiredWorker:int;

    public function NEventAdditionalWorkerExpired(param1:int, param2:Date) {
        this.indexExpiredWorker = param1;
        super(param2);
    }

    override protected function postProcess(param1:User, param2:Date):void {
        var _loc3_:Array = null;
        super.postProcess(param1, param2);
        if (param1.gameData.constructionData && param1.gameData.constructionData.additionalWorkersExpireDateTimes) {
            _loc3_ = param1.gameData.constructionData.additionalWorkersExpireDateTimes;
            _loc3_.splice(this.indexExpiredWorker, 1);
            param1.gameData.constructionData.constructionAdditionalWorkersChanged = true;
        }
    }
}
}
