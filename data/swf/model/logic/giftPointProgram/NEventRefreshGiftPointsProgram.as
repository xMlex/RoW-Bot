package model.logic.giftPointProgram {
import model.data.User;
import model.data.giftPoints.UserGiftPointsProgramData;
import model.data.normalization.NEventUser;

public class NEventRefreshGiftPointsProgram extends NEventUser {


    public function NEventRefreshGiftPointsProgram(param1:Date) {
        super(param1);
    }

    override protected function postProcess(param1:User, param2:Date):void {
        new GiftPointsProgramDetermineUserDepositorGroupCmd().execute();
        var _loc3_:UserGiftPointsProgramData = param1.gameData.giftPointsProgramData;
        _loc3_.programActivationTime = null;
        _loc3_.programDeadline = null;
        _loc3_.update(_loc3_);
    }
}
}
