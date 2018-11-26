package model.data.users.acceleration {
import model.data.User;
import model.data.UserGameData;
import model.data.normalization.NEventUser;

public class NEventEffectsFinished extends NEventUser {


    public function NEventEffectsFinished(param1:Date) {
        super(param1);
    }

    override protected function postProcess(param1:User, param2:Date):void {
        super.postProcess(param1, param2);
        var _loc3_:UserGameData = param1.gameData;
        _loc3_.effectData.removeOldActiveState(param2);
        _loc3_.constructionData.updateAcceleration(_loc3_, _loc3_.normalizationTime);
        if (_loc3_.sectorSkinsData != null) {
            _loc3_.sectorSkinsData.updateCurrentSkin(param2);
        }
        _loc3_.giftPointsProgramData.refreshAvailableBonuses();
        _loc3_.effectData.dirty = true;
        _loc3_.effectData.dispatchEvents();
    }
}
}
