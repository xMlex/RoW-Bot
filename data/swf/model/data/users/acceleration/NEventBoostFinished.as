package model.data.users.acceleration {
import model.data.User;
import model.data.acceleration.types.BoostTypeId;
import model.data.acceleration.types.ResourceMiningBoostType;
import model.data.normalization.NEventUser;
import model.logic.StaticDataManager;
import model.logic.UserManager;

public class NEventBoostFinished extends NEventUser {


    private var _miningBoost:ResourceMiningBoost;

    public function NEventBoostFinished(param1:ResourceMiningBoost, param2:Date) {
        super(param2);
        this._miningBoost = param1;
    }

    override protected function postProcess(param1:User, param2:Date):void {
        super.postProcess(param1, param2);
        var _loc3_:ConstructionData = UserManager.user.gameData.constructionData;
        var _loc4_:ResourceMiningBoostType = StaticDataManager.getResourceMiningBoostType(this._miningBoost.typeId, this._miningBoost.boostPercentage);
        if (this.canBoostAutoRenewal(_loc3_)) {
            if (_loc4_ && UserManager.user.gameData.account.isEnough(_loc4_.price)) {
                if (_loc4_.price) {
                    UserManager.user.gameData.account.resources.substract(_loc4_.price);
                }
                this._miningBoost.until = new Date(this._miningBoost.until.time + _loc4_.period * 60 * 60 * 1000);
            }
            else {
                _loc3_.resourceMiningBoosts.removeItemAt(_loc3_.resourceMiningBoosts.getItemIndex(this._miningBoost));
                _loc3_.resourceMiningBoostAutoRenewal = false;
            }
        }
        else {
            _loc3_.resourceMiningBoosts.removeItemAt(_loc3_.resourceMiningBoosts.getItemIndex(this._miningBoost));
        }
        _loc3_.resourcesBoostChanged = true;
    }

    protected function canBoostAutoRenewal(param1:ConstructionData):Boolean {
        return param1.resourceMiningBoostAutoRenewalMoney && this._miningBoost.typeId == BoostTypeId.RESOURCES_MONEY || param1.resourceMiningBoostAutoRenewalTitanite && this._miningBoost.typeId == BoostTypeId.RESOURCES_TITANITE || param1.resourceMiningBoostAutoRenewalUranium && this._miningBoost.typeId == BoostTypeId.RESOURCES_TITANITE;
    }
}
}
