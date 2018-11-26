package model.logic.quests.periodicQuests {
import common.queries.util.query;

import model.data.scenes.types.GeoSceneObjectType;
import model.logic.StaticDataManager;
import model.logic.quests.completions.QuestCompletionPeriodic;
import model.logic.quests.periodicQuests.enums.PeriodicQuestPrototypeId;

public class PeriodicQuestFilterManager {

    public static var pointsFiltersByPrototypeId:Object = {};

    {
        pointsFiltersByPrototypeId[PeriodicQuestPrototypeId.BuildBuilding] = buildBuildingFilter;
        pointsFiltersByPrototypeId[PeriodicQuestPrototypeId.TrainTroops] = trainTroopsBuildFilter;
        pointsFiltersByPrototypeId[PeriodicQuestPrototypeId.LearnTechnologies] = learnTechnologiesFilter;
        pointsFiltersByPrototypeId[PeriodicQuestPrototypeId.LearnSkills] = learnSkillsFilter;
        pointsFiltersByPrototypeId[PeriodicQuestPrototypeId.PowderItemHero] = powderItemHeroFilter;
        pointsFiltersByPrototypeId[PeriodicQuestPrototypeId.EarningExperience] = earningExperienceFilter;
        pointsFiltersByPrototypeId[PeriodicQuestPrototypeId.ActivateVipStatus] = activateVipStatusFilter;
        pointsFiltersByPrototypeId[PeriodicQuestPrototypeId.UpgradeInventoryItem] = upgradeInventoryItemFilter;
        pointsFiltersByPrototypeId[PeriodicQuestPrototypeId.CollectResourceDynamicMine] = collectResourceDynamicMineFilter;
        pointsFiltersByPrototypeId[PeriodicQuestPrototypeId.ActivateDragon] = activateDragonFilter;
        pointsFiltersByPrototypeId[PeriodicQuestPrototypeId.KillDragonMonster] = killDragonMonsterFilter;
        pointsFiltersByPrototypeId[PeriodicQuestPrototypeId.PerformPack] = performPackFilter;
        pointsFiltersByPrototypeId[PeriodicQuestPrototypeId.AllianceHelpResponse] = allianceHelpResponseFilter;
    }

    public function PeriodicQuestFilterManager() {
        super();
    }

    private static function buildBuildingFilter(param1:ComplexSource, param2:QuestCompletionPeriodic):Number {
        var _loc3_:PeriodicQuestFilter = param2.questData.filter;
        if (param1.sceneObject == null || param1.sceneObject.buildingInfo == null || isNaN(param1.count) || param1.count == 0) {
            return 0;
        }
        var _loc4_:GeoSceneObjectType = param1.sceneObject.objectType;
        if (_loc4_ == null || _loc4_.buildingInfo == null) {
            return 0;
        }
        if (_loc3_.buildingGroupIds != null && _loc3_.buildingGroupIds.indexOf(_loc4_.buildingInfo.groupId) == -1) {
            return 0;
        }
        return param1.count;
    }

    private static function trainTroopsBuildFilter(param1:ComplexSource, param2:QuestCompletionPeriodic):Number {
        var _loc4_:GeoSceneObjectType = null;
        var _loc3_:PeriodicQuestFilter = param2.questData.filter;
        if (param1.troopsTypeId <= 0 || isNaN(param1.count) || param1.count == 0) {
            return 0;
        }
        if (_loc3_.minTypeId > 0 && param1.troopsTypeId < _loc3_.minTypeId) {
            return 0;
        }
        if (_loc3_.maxTypeId > 0 && param1.troopsTypeId > _loc3_.maxTypeId) {
            return 0;
        }
        if (_loc3_.troopsTypeIds != null && _loc3_.troopsTypeIds.indexOf(param1.troopsTypeId) == -1) {
            return 0;
        }
        if (_loc3_.troopsGroupId > -1) {
            _loc4_ = StaticDataManager.getObjectType(param1.troopsTypeId);
            if (_loc4_ == null || _loc4_.troopsInfo == null || _loc4_.troopsInfo.groupId != _loc3_.troopsGroupId) {
                return 0;
            }
        }
        return param1.count;
    }

    private static function learnTechnologiesFilter(param1:ComplexSource, param2:QuestCompletionPeriodic):Number {
        var _loc3_:PeriodicQuestFilter = param2.questData.filter;
        if (_loc3_.existTechTypeByLevel != null) {
            return 0;
        }
        if (_loc3_.technologiesTypeIds != null && _loc3_.technologiesTypeIds.indexOf(param1.sceneObject.id) == -1) {
            return 0;
        }
        return 1;
    }

    private static function learnSkillsFilter(param1:ComplexSource, param2:QuestCompletionPeriodic):Number {
        return 1;
    }

    private static function powderItemHeroFilter(param1:ComplexSource, param2:QuestCompletionPeriodic):Number {
        return param1.powderedInventoryItems;
    }

    private static function earningExperienceFilter(param1:ComplexSource, param2:QuestCompletionPeriodic):Number {
        return param1.experience;
    }

    private static function activateVipStatusFilter(param1:ComplexSource, param2:QuestCompletionPeriodic):Number {
        return 1;
    }

    private static function upgradeInventoryItemFilter(param1:ComplexSource, param2:QuestCompletionPeriodic):Number {
        var _loc3_:PeriodicQuestFilter = param2.questData.filter;
        if (_loc3_.minItemTier > 0 && (param1.inventoryItemTier <= 0 || param1.inventoryItemTier < _loc3_.minItemTier)) {
            return 0;
        }
        if (_loc3_.minItemLevel > 0 && param1.inventoryItemLevel < _loc3_.minItemLevel) {
            return 0;
        }
        return 1;
    }

    private static function collectResourceDynamicMineFilter(param1:ComplexSource, param2:QuestCompletionPeriodic):Number {
        var source:ComplexSource = param1;
        var completion:QuestCompletionPeriodic = param2;
        var filter:PeriodicQuestFilter = completion.questData.filter;
        var points:Number = 0;
        if (filter.resourceTypeIds != null && filter.resourceTypeIds.length > 0) {
            points = query(filter.resourceTypeIds).sum(function (param1:int):Number {
                return source.resources.getByType(param1);
            });
        }
        return points;
    }

    private static function activateDragonFilter(param1:ComplexSource, param2:QuestCompletionPeriodic):Number {
        return 1;
    }

    private static function killDragonMonsterFilter(param1:ComplexSource, param2:QuestCompletionPeriodic):Number {
        return 1;
    }

    private static function performPackFilter(param1:ComplexSource, param2:QuestCompletionPeriodic):Number {
        var _loc3_:PeriodicQuestFilter = param2.questData.filter;
        if (_loc3_.questCategoryIds != null && _loc3_.questCategoryIds.indexOf(param1.quest.categoryId) == -1) {
            return 0;
        }
        if (_loc3_.questCategoryIgnoredIds != null && _loc3_.questCategoryIgnoredIds.indexOf(param1.quest.categoryId) != -1) {
            return 0;
        }
        if (_loc3_.periodicQuestGroupIds != null && (param1.questState.periodicQuestGroupId <= 0 || _loc3_.periodicQuestGroupIds.indexOf(param1.questState.periodicQuestGroupId) == -1)) {
            return 0;
        }
        return 1;
    }

    private static function allianceHelpResponseFilter(param1:ComplexSource, param2:QuestCompletionPeriodic):Number {
        var _loc3_:PeriodicQuestFilter = param2.questData.filter;
        if (_loc3_.allianceHelpRespondTypeIds != null && (param1.allianceHelpRequestTypeId != 0 && _loc3_.allianceHelpRespondTypeIds.indexOf(param1.allianceHelpRequestTypeId) == -1)) {
            return 0;
        }
        return param1.count;
    }
}
}
