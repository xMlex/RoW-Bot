package model.data.users.technologies {
import Events.EventWithTargetObject;

import configs.Global;

import model.data.User;
import model.data.normalization.NEventConstruction;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.info.TechnologyTypeId;
import model.data.users.buildings.Sector;
import model.logic.MessageManager;
import model.logic.UserLevelManager;
import model.logic.UserStatsManager;
import model.logic.messages.MessageSender;
import model.logic.quests.completions.QuestCompletionByTechnology;
import model.logic.quests.completions.QuestCompletionPeriodic;
import model.logic.quests.data.TournamentStatisticsType;
import model.logic.quests.periodicQuests.ComplexSource;
import model.logic.quests.periodicQuests.enums.PeriodicQuestPrototypeId;
import model.logic.ratings.TournamentBonusManager;

public class NEventTechnologyFinished extends NEventConstruction {


    private var _technology:GeoSceneObject;

    public function NEventTechnologyFinished(param1:GeoSceneObject, param2:Date) {
        super(param1, param2);
        this._technology = param1;
    }

    override protected function postProcess(param1:User, param2:Date):void {
        super.postProcess(param1, param2);
        this._technology.dirtyNormalized = true;
        UserLevelManager.addPointsForObjectFinished(param1, this._technology);
        UserStatsManager.objectFinished(param1, this._technology);
        var _loc3_:int = UserLevelManager.getPoints(this._technology);
        param1.gameData.questData.addCollectibleItemsFromTechnology(_loc3_);
        if (this._technology.constructionObjInfo.instantFinish) {
            this._technology.constructionInfo.instantFinish = false;
        }
        else {
            MessageManager.waitWhenMessagesIsReadOnServer = true;
            MessageSender.TechnologyResearched(param1, time, this._technology.type.id, this._technology.constructionInfo.level);
        }
        QuestCompletionByTechnology.tryComplete(this._technology.objectType.id, this._technology.getLevel());
        QuestCompletionPeriodic.tryComplete(ComplexSource.fromSceneObject(this._technology), [PeriodicQuestPrototypeId.LearnTechnologies]);
        param1.gameData.resetBuyStatusBySceneObject();
        if (this._technology.constructionObjInfo.level == 1) {
            param1.gameData.technologyCenter.raiseTechnologyResearched(this._technology.type.id);
        }
        param1.gameData.technologyCenter.recalcTechnologies();
        param1.gameData.constructionData.updateAcceleration(param1.gameData, time);
        param1.gameData.sector.events.dispatchEvent(new EventWithTargetObject(Sector.TECHNOLOGY_RESEARCH_COMPLETED, this._technology));
        TournamentBonusManager.applyUserPointsDiffForSceneObject(TournamentStatisticsType.TechnologiesFinished, this._technology);
        if (Global.STORAGE_ENABLED && this._technology.constructionInfo.level == 1 && this._technology.objectType.id == TechnologyTypeId.TechIdCommandCenter) {
            param1.gameData.technologyCenter.setLevelTechnology(TechnologyTypeId.TechMicroroboticDrill, 1);
            param1.gameData.technologyCenter.raiseTechnologyResearched(TechnologyTypeId.TechMicroroboticDrill);
        }
    }
}
}
