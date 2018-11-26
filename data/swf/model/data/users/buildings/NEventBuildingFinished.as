package model.data.users.buildings {
import Events.EventWithTargetObject;

import model.data.User;
import model.data.normalization.NEventConstruction;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.info.BuildingGroupId;
import model.logic.UserLevelManager;
import model.logic.UserStatsManager;
import model.logic.quests.completions.QuestCompletionByBuilding;
import model.logic.quests.completions.QuestCompletionPeriodic;
import model.logic.quests.data.TournamentStatisticsType;
import model.logic.quests.periodicQuests.ComplexSource;
import model.logic.quests.periodicQuests.enums.PeriodicQuestPrototypeId;
import model.logic.ratings.TournamentBonusManager;

public class NEventBuildingFinished extends NEventConstruction {


    private var _building:GeoSceneObject;

    public function NEventBuildingFinished(param1:GeoSceneObject, param2:Date) {
        super(param1, param2);
        this._building = param1;
    }

    override protected function postProcess(param1:User, param2:Date):void {
        var _loc3_:Sector = null;
        var _loc4_:Boolean = false;
        var _loc5_:Boolean = false;
        var _loc6_:int = 0;
        if (this._building.objectType.buildingInfo.canBeBroken == true && this._building.getLevel() > 0 && this._building.buildingInfo.broken == true) {
            this._building.constructionInfo.constructionStartTime = null;
            this._building.constructionInfo.constructionFinishTime = null;
            this._building.buildingInfo.broken = false;
        }
        else {
            super.postProcess(param1, param2);
            _loc3_ = param1.gameData.sector;
            _loc4_ = _loc3_.buildingsDeletedByUserTypeIds != null && _loc3_.buildingsDeletedByUserTypeIds.contains(this._building.type.id);
            _loc5_ = this._building.objectType.buildingInfo != null && this._building.objectType.buildingInfo.notApplyBonusForBuilding;
            if (!_loc4_ && !_loc5_) {
                UserLevelManager.addPointsForObjectFinished(param1, this._building);
                UserStatsManager.objectFinished(param1, this._building);
            }
            _loc6_ = UserLevelManager.getPoints(this._building);
            param1.gameData.questData.addCollectibleItemsFromBuilding(_loc6_);
            if (this._building.objectType.buildingInfo.groupId == BuildingGroupId.DEFENSIVE) {
                param1.gameData.buyingData.updateStatus(param1.gameData, true, true);
            }
            param1.gameData.sector.lastBuildedOrUpdatedBuilding = this._building;
            QuestCompletionByBuilding.tryComplete(this._building.objectType.id, this._building.getLevel());
            param1.gameData.constructionData.availableWorkersChanged = true;
            QuestCompletionPeriodic.tryComplete(ComplexSource.fromSceneObject(this._building), [PeriodicQuestPrototypeId.BuildBuilding]);
            TournamentBonusManager.applyUserPointsDiffForSceneObject(TournamentStatisticsType.BuildingsFinished, this._building);
        }
        this._building.dirtyNormalized = true;
        param1.gameData.resetBuyStatusBySceneObject();
        param1.gameData.sector.recalcBuildings();
        param1.gameData.constructionData.updateAcceleration(param1.gameData, time);
        param1.gameData.sector.events.dispatchEvent(new EventWithTargetObject(Sector.BUILDING_UPGRADE_COMPLETED, this._building));
    }
}
}
