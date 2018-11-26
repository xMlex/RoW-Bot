package model.data.users.acceleration {
import model.data.User;
import model.data.normalization.NEventUser;

public class NEventUserProcessCityHistory extends NEventUser {


    public function NEventUserProcessCityHistory(param1:Date) {
        super(param1);
    }

    override protected function postProcess(param1:User, param2:Date):void {
        param1.gameData.allianceData.lastHistoryProcessedDate = time;
    }
}
}
