package model.data.users.acceleration.accelerationBehavior {
import model.data.UserGameData;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.info.TechnologyLevelInfo;
import model.data.users.technologies.TechnologyCenter;
import model.logic.StaticDataManager;

public class AccelerationBehaviorTechnology extends AccelerationBehaviorStandard {


    public function AccelerationBehaviorTechnology() {
        super();
    }

    protected static function sumAcceleration(param1:Function, param2:TechnologyCenter):int {
        var _loc4_:GeoSceneObject = null;
        var _loc5_:int = 0;
        var _loc6_:TechnologyLevelInfo = null;
        var _loc3_:int = 0;
        for each(_loc4_ in param2.technologies) {
            _loc5_ = _loc4_.getLevel();
            _loc6_ = _loc4_.objectType.technologyInfo.levelInfos[_loc5_ - 1];
            if (!(_loc5_ == 0 || _loc6_ == null)) {
                _loc3_ = _loc3_ + param1(_loc6_);
            }
        }
        return _loc3_;
    }

    override public function getCaravanCapacity(param1:UserGameData):int {
        var gameData:UserGameData = param1;
        return sumAcceleration(function (param1:TechnologyLevelInfo):int {
            return param1.caravanCapacityPercent;
        }, gameData.technologyCenter);
    }

    override public function getCaravanQuantity(param1:UserGameData):int {
        var gameData:UserGameData = param1;
        return sumAcceleration(function (param1:TechnologyLevelInfo):int {
            return param1.unitCountLimitBonus != null ? int(param1.unitCountLimitBonus.caravansCount) : 0;
        }, gameData.technologyCenter);
    }

    override public function getCaravanSpeedPercent(param1:UserGameData):int {
        var gameData:UserGameData = param1;
        var acceleration:Number = sumAcceleration(function (param1:TechnologyLevelInfo):int {
            return param1.caravanSpeed;
        }, gameData.technologyCenter);
        if (gameData.effectData != null) {
            acceleration = acceleration + gameData.effectData.getCaravanSpeedBonus();
        }
        return acceleration;
    }

    override public function getCaravanCapacityPercent(param1:UserGameData):int {
        var _loc2_:int = param1.constructionData.caravanCapacityPercentBoost;
        return _loc2_ + (param1.vipData != null && param1.vipData.activeState ? StaticDataManager.vipData.getVipLevel(param1.vipData.vipLevel).caravanCapacityBonus : 0);
    }
}
}
