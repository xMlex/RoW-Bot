package model.data.promotionOffers.conditions {
import gameObjects.sceneObject.SceneObject;

import model.data.promotionOffers.UserPromotionOffer;
import model.data.promotionOffers.contexts.PromotionContext;
import model.data.scenes.objects.GeoSceneObject;
import model.data.specialOfferTriggers.TriggerEventTypeEnum;
import model.logic.UserManager;
import model.logic.conditions.Condition;

public class UpgradeBuildingsPromotionCondition extends Condition {

    public static const CONDITION_LEVEL:int = 20;


    public function UpgradeBuildingsPromotionCondition() {
        super();
    }

    public static function isUpgradeBuildingTrigger(param1:UserPromotionOffer):Boolean {
        return param1.triggerData != null && param1.triggerData.triggerType == TriggerEventTypeEnum.BUILDING_UPGRADE_TO_ADDITIONAL_LEVEL;
    }

    public static function hasAppropriateLevel(param1:GeoSceneObject):Boolean {
        return param1.getLevel() == CONDITION_LEVEL && param1.getMaxLevel() > CONDITION_LEVEL;
    }

    override public function check():Boolean {
        var _loc1_:PromotionContext = PromotionContext(conditionContext);
        if (!isUpgradeBuildingTrigger(_loc1_.promotion)) {
            return false;
        }
        var _loc2_:Vector.<SceneObject> = UserManager.user.gameData.sector.sectorScene.sceneObjects;
        if (_loc2_ == null) {
            return true;
        }
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_.length) {
            if (hasAppropriateLevel(_loc2_[_loc3_] as GeoSceneObject)) {
                return false;
            }
            _loc3_++;
        }
        return true;
    }
}
}
