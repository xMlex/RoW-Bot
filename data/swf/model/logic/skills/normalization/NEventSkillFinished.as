package model.logic.skills.normalization {
import Events.EventWithTargetObject;

import model.data.User;
import model.data.normalization.NEventUser;
import model.data.users.buildings.Sector;
import model.logic.StaticDataManager;
import model.logic.quests.completions.QuestCompletionPeriodic;
import model.logic.quests.periodicQuests.ComplexSource;
import model.logic.quests.periodicQuests.enums.PeriodicQuestPrototypeId;
import model.logic.skills.data.Skill;
import model.logic.skills.data.SkillEffectTypeId;
import model.logic.skills.data.SkillType;

public class NEventSkillFinished extends NEventUser {


    private var _skill:Skill;

    public function NEventSkillFinished(param1:Skill, param2:Date) {
        super(param2);
        this._skill = param1;
    }

    override protected function postProcess(param1:User, param2:Date):void {
        this._skill.constructionInfo.level++;
        this._skill.constructionInfo.constructionStartTime = null;
        this._skill.constructionInfo.constructionFinishTime = null;
        var _loc3_:SkillType = StaticDataManager.skillData.getSkillType(this._skill.typeId);
        if (_loc3_.effectTypeId == SkillEffectTypeId.TROOPS_TRAINING_SPEED || _loc3_.effectTypeId == SkillEffectTypeId.TECHNOLOGY_RESEARCH_SPEED) {
            param1.gameData.constructionData.updateAcceleration(param1.gameData, time);
        }
        this._skill.dirtyNormalized = true;
        param1.gameData.skillData.updateStatus();
        param1.gameData.skillData.dirty = true;
        param1.gameData.sector.events.dispatchEvent(new EventWithTargetObject(Sector.SKILL_RESEARCH_COMPLETED, this._skill));
        QuestCompletionPeriodic.tryComplete(ComplexSource.fromSkill(this._skill), [PeriodicQuestPrototypeId.LearnSkills]);
    }
}
}
