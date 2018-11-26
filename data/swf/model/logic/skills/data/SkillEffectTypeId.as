package model.logic.skills.data {
import common.GameType;
import common.localization.LocaleUtil;

import model.logic.StaticDataManager;

public class SkillEffectTypeId {

    public static const NONE:int = 0;

    public static const TROOPS_MOVEMENT_SPEED:int = 1;

    public static const TROOPS_TRAINING_SPEED:int = 2;

    public static const TROOPS_RESOURCES_CONSUMPTION:int = 3;

    public static const TECHNOLOGY_RESEARCH_SPEED:int = 4;

    public static const CYBORGS_COUNT:int = 5;

    public static const BUILDINGS_REPAIR_SPEED:int = 6;

    public static const OCCUPIED_LOCATIONS_LIMIT:int = 7;

    public static const MUTATION_COST:int = 8;

    public static const BATTLE_EXPERIENCE:int = 9;

    public static const ADDITIONAL_ROBBERY:int = 10;


    public function SkillEffectTypeId() {
        super();
    }

    public static function getDescriptionById(param1:int):String {
        switch (param1) {
            case NONE:
                return "";
            case TROOPS_MOVEMENT_SPEED:
                return LocaleUtil.getText("forms-SkillEffectTypeId_TROOPS_MOVEMENT_SPEED");
            case TROOPS_TRAINING_SPEED:
                return LocaleUtil.getText("forms-SkillEffectTypeId_TROOPS_TRAINING_SPEED");
            case TROOPS_RESOURCES_CONSUMPTION:
                return LocaleUtil.getText("forms-SkillEffectTypeId_TROOPS_RESOURCES_CONSUMPTION");
            case TECHNOLOGY_RESEARCH_SPEED:
                return LocaleUtil.getText("forms-SkillEffectTypeId_TECHNOLOGY_RESEARCH_SPEED");
            case CYBORGS_COUNT:
                return LocaleUtil.getText("forms-SkillEffectTypeId_CYBORGS_COUNT");
            case BUILDINGS_REPAIR_SPEED:
                return LocaleUtil.getText("forms-SkillEffectTypeId_BUILDINGS_REPAIR_SPEED");
            case OCCUPIED_LOCATIONS_LIMIT:
                return LocaleUtil.getText("forms-SkillEffectTypeId_OCCUPIED_LOCATIONS_LIMIT");
            case MUTATION_COST:
                return LocaleUtil.getText("forms-SkillEffectTypeId_MUTATION_COST");
            case BATTLE_EXPERIENCE:
                return LocaleUtil.getText("forms-SkillEffectTypeId_BATTLE_EXPERIENCE");
            case ADDITIONAL_ROBBERY:
                return LocaleUtil.getText("forms-SkillEffectTypeId_ADDITIONAL_ROBBERY");
            default:
                return "";
        }
    }

    public static function getSkillNameByType(param1:SkillType):String {
        var _loc2_:String = null;
        switch (param1.effectTypeId) {
            case NONE:
                _loc2_ = LocaleUtil.getText("forms-SkillEffectTypeId_textEchelonIndex01");
                if (param1.requiredSkills.length == 1) {
                    switch ((param1.requiredSkills[0] as RequiredSkill).skillTypeId) {
                        case 1004:
                            _loc2_ = LocaleUtil.getText("forms-SkillEffectTypeId_textEchelonIndex02");
                            break;
                        case 1008:
                            _loc2_ = LocaleUtil.getText("forms-SkillEffectTypeId_textEchelonIndex03");
                            break;
                        case 3:
                        case 5:
                            _loc2_ = LocaleUtil.getText("forms-SkillEffectTypeId_textEchelonIndex04");
                            break;
                        case 6:
                            _loc2_ = LocaleUtil.getText("forms-SkillEffectTypeId_textEchelonIndex05");
                            break;
                        case 1012:
                            _loc2_ = !!GameType.isNords ? LocaleUtil.getText("forms-SkillEffectTypeId_textEchelonIndex05") : LocaleUtil.getText("forms-SkillEffectTypeId_textEchelonIndex06");
                    }
                }
                return LocaleUtil.buildString("forms-SkillEffectTypeId_textEchelonImprovement", _loc2_);
            case TROOPS_RESOURCES_CONSUMPTION:
                return LocaleUtil.getText("forms-SkillEffectTypeId_textRecycleCredits");
            case TROOPS_MOVEMENT_SPEED:
                return LocaleUtil.buildString("forms-SkillEffectTypeId_textMovementsSpeed", StaticDataManager.getObjectType(param1.affectedTypes[0]).name);
            case TROOPS_TRAINING_SPEED:
                return LocaleUtil.buildString("forms-SkillEffectTypeId_textTroopsTrainingSpeed", StaticDataManager.getObjectType(param1.affectedTypes[0]).name);
            case BUILDINGS_REPAIR_SPEED:
                return LocaleUtil.getText("forms-SkillEffectTypeId_textBuildingRepair");
            case TECHNOLOGY_RESEARCH_SPEED:
                return LocaleUtil.getText("forms-SkillEffectTypeId_textTechnologyResearch");
            case CYBORGS_COUNT:
                return LocaleUtil.getText("forms-SkillEffectTypeId_textCyborgsCount");
            case OCCUPIED_LOCATIONS_LIMIT:
                return LocaleUtil.getText("forms-SkillEffectTypeId_textOccupiedLocationsCount");
            case MUTATION_COST:
                return LocaleUtil.getText("forms-SkillEffectTypeId_textMutationCost");
            case BATTLE_EXPERIENCE:
                return LocaleUtil.getText("forms-SkillEffectTypeId_textExperience");
            case ADDITIONAL_ROBBERY:
                return LocaleUtil.getText("forms-SkillEffectTypeId_textRobbery");
            default:
                return param1.name;
        }
    }
}
}
