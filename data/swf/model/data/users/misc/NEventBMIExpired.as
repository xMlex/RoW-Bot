package model.data.users.misc {
import model.data.User;
import model.data.normalization.NEventUser;

public class NEventBMIExpired extends NEventUser {


    public function NEventBMIExpired(param1:Date) {
        super(param1);
    }

    override protected function postProcess(param1:User, param2:Date):void {
        param1.gameData.blackMarketData.chestsDirty = true;
        param1.gameData.blackMarketData.dispatchEvents();
    }
}
}
