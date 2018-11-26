package model.data.users.acceleration.accelerationBehavior {
import model.data.UserGameData;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.info.BuildingLevelInfo;
import model.data.scenes.types.info.BuildingTypeInfo;
import model.data.users.buildings.Sector;
import model.logic.StaticDataManager;

public class AccelerationBehaviorStandard {


    public function AccelerationBehaviorStandard() {
        super();
    }

    protected static function sumAcceleration(param1:Function, param2:Sector):int {
        var _loc4_:GeoSceneObject = null;
        var _loc5_:BuildingTypeInfo = null;
        var _loc6_:int = 0;
        var _loc7_:BuildingLevelInfo = null;
        var _loc3_:int = 0;
        for each(_loc4_ in param2.sectorScene.sceneObjects) {
            _loc5_ = _loc4_.objectType.buildingInfo;
            _loc6_ = _loc4_.getLevel();
            if (!(_loc5_ == null || _loc6_ == 0)) {
                _loc7_ = _loc4_.objectType.buildingInfo.getLevelInfo(_loc6_);
                _loc3_ = _loc3_ + param1(_loc7_);
            }
        }
        return _loc3_;
    }

    public function getCaravanQuantity(param1:UserGameData):int {
        var gameData:UserGameData = param1;
        return sumAcceleration(function (param1:BuildingLevelInfo):int {
            return param1.caravanQuantity;
        }, gameData.sector);
    }

    public function getCaravanCapacity(param1:UserGameData):int {
        var gameData:UserGameData = param1;
        return sumAcceleration(function (param1:BuildingLevelInfo):int {
            return param1.caravanCapacityPercent;
        }, gameData.sector);
    }

    public function getCaravanCapacityPercent(param1:UserGameData):int {
        var _loc2_:int = param1.constructionData.caravanCapacityPercentBoost;
        return this.getCaravanCapacity(param1) + _loc2_ + (param1.vipData != null && param1.vipData.activeState ? StaticDataManager.vipData.getVipLevel(param1.vipData.vipLevel).caravanCapacityBonus : 0);
    }

    public function getCaravanSpeedPercent(param1:UserGameData):int {
        var gameData:UserGameData = param1;
        var acceleration:Number = sumAcceleration(function (param1:BuildingLevelInfo):int {
            return param1.caravanSpeed;
        }, gameData.sector);
        if (gameData.effectData != null) {
            acceleration = acceleration + gameData.effectData.getCaravanSpeedBonus();
        }
        return acceleration;
    }
}
}
