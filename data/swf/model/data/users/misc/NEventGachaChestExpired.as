package model.data.users.misc {
import model.data.User;
import model.data.normalization.NEventUser;
import model.logic.commands.clanPurchases.OpenExpiredGachaChestCmd;

public class NEventGachaChestExpired extends NEventUser {


    public function NEventGachaChestExpired(param1:Date) {
        super(param1);
    }

    override protected function postProcess(param1:User, param2:Date):void {
        super.postProcess(param1, param2);
        new OpenExpiredGachaChestCmd().execute();
    }
}
}
