package model.data.users.acceleration {
import model.data.User;
import model.data.acceleration.types.ResourceConsumptionBonusBoostType;
import model.data.normalization.NEventUser;
import model.logic.StaticDataManager;
import model.logic.UserManager;

public class NEventConsumptionBonusBoostFinished extends NEventUser {


    private var _consumtionBonusBoost:ResourceConsumptionBonusBoost;

    public function NEventConsumptionBonusBoostFinished(param1:ResourceConsumptionBonusBoost, param2:Date) {
        super(param2);
        this._consumtionBonusBoost = param1;
    }

    override protected function postProcess(param1:User, param2:Date):void {
        super.postProcess(param1, param2);
        var _loc3_:ConstructionData = UserManager.user.gameData.constructionData;
        var _loc4_:ResourceConsumptionBonusBoostType = StaticDataManager.getResourceConsumptionBonusBoostType(this._consumtionBonusBoost.typeId, this._consumtionBonusBoost.boostPercentage);
        if (_loc3_.resourceConsumptionBonusBoostAutoRenewal) {
            if (UserManager.user.gameData.account.isEnough(_loc4_.price)) {
                UserManager.user.gameData.account.resources.substract(_loc4_.price);
                this._consumtionBonusBoost.until = new Date(this._consumtionBonusBoost.until.time + _loc4_.period * 60 * 60 * 1000);
            }
            else {
                _loc3_.resourceConsumptionBonusBoosts.removeItemAt(_loc3_.resourceConsumptionBonusBoosts.getItemIndex(this._consumtionBonusBoost));
                _loc3_.resourceConsumptionBonusBoostAutoRenewal = false;
            }
        }
        else {
            _loc3_.resourceConsumptionBonusBoosts.removeItemAt(_loc3_.resourceConsumptionBonusBoosts.getItemIndex(this._consumtionBonusBoost));
        }
        _loc3_.resourceConsumptionChangedDirty = true;
    }
}
}
