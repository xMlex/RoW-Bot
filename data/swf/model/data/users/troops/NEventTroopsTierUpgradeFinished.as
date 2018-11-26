package model.data.users.troops {
import Events.EventWithTargetObject;

import model.data.User;
import model.data.normalization.NEventUser;

public class NEventTroopsTierUpgradeFinished extends NEventUser {


    private var _troopTierIds:Array;

    public function NEventTroopsTierUpgradeFinished(param1:Array, param2:Date) {
        super(param2);
        this._troopTierIds = param1;
    }

    override protected function postProcess(param1:User, param2:Date):void {
        var _loc5_:TroopsTierObjLevelInfo = null;
        var _loc6_:* = undefined;
        super.postProcess(param1, param2);
        var _loc3_:UserTroopsData = param1.gameData.troopsData;
        var _loc4_:Object = _loc3_.tiersLevelInfoByTierId;
        for each(_loc6_ in this._troopTierIds) {
            _loc5_ = _loc4_[_loc6_];
            if (!(_loc5_ == null || _loc5_.constructionInfo == null)) {
                _loc5_.finishUpgrade();
                _loc5_.normalizeResourcesAfterUpgrade(_loc6_);
            }
        }
        _loc3_.events.dispatchEvent(new EventWithTargetObject(UserTroopsData.TIERS_UPGRADED, this._troopTierIds));
    }
}
}
