package model.data.scenes.types.info {
import common.localization.LocaleUtil;

import gameObjects.sceneObject.SceneObjectType;

import model.data.scenes.types.GeoSceneObjectType;

public class TroopsGroupId {

    public static const CLASS_NAME:String = "TroopsGroupId";

    public static const INFANTRY:int = 0;

    public static const INFANTRY_2:int = 1;

    public static const ARTILLERY:int = 2;

    public static const ARTILLERY_2:int = 3;

    public static const ARMOURED:int = 4;

    public static const ARMOURED_2:int = 5;

    public static const AEROSPACE:int = 6;

    public static const AEROSPACE_2:int = 7;

    public static const ELITE_DEF:int = 8;

    public static const TACTICAL_BUILDING:int = 80;

    public static const BUGS:int = 9;

    public static const STRATEGY:int = 10;

    public static const INCUBATOR_UNITS:int = 11;

    public static const INCUBATOR_UNITS_2:int = 12;

    public static const AVP:int = 13;

    public static const MISSILE:int = 20;

    public static const DEFENSIVE_UNITS:int = 109;

    public static const DEFENSIVE_UNITS_2:int = 110;

    public static const SPECIAL_FORCE_UNITS:int = 111;

    public static const SPECIAL_FORCE_UNITS_2:int = 112;


    public function TroopsGroupId() {
        super();
    }

    public static function getByType(param1:SceneObjectType):int {
        if (param1 == null) {
            return TroopsGroupId.INFANTRY;
        }
        return getByTypeId(param1.id);
    }

    public static function getByTypeId(param1:int):int {
        switch (param1) {
            case BuildingTypeId.Barracks:
            case BuildingTypeId.Quarters:
                return TroopsGroupId.INFANTRY;
            case BuildingTypeId.MotorizedInfantryFactory:
            case BuildingTypeId.ArmouredUnitsFactory:
                return TroopsGroupId.ARMOURED;
            case BuildingTypeId.ArtilleryFactory:
            case BuildingTypeId.ArtillerySystemsCenter:
                return TroopsGroupId.ARTILLERY;
            case BuildingTypeId.Airbase:
            case BuildingTypeId.AerospaceComplex:
                return TroopsGroupId.AEROSPACE;
            case BuildingTypeId.DefensiveUnits:
                return TroopsGroupId.DEFENSIVE_UNITS;
            case BuildingTypeId.SpecialForceUnits:
                return TroopsGroupId.SPECIAL_FORCE_UNITS;
            case BuildingTypeId.Incubator:
                return TroopsGroupId.INCUBATOR_UNITS;
            default:
                trace(CLASS_NAME + "Неправильный тип военного здания.");
                return TroopsGroupId.INFANTRY;
        }
    }

    public static function GetByBuildingTypeId(param1:SceneObjectType):int {
        if (param1 == null) {
            return TroopsGroupId.INFANTRY;
        }
        switch (param1.id) {
            case BuildingTypeId.Barracks:
            case BuildingTypeId.Quarters:
            case BuildingTypeId.DefensiveUnits:
            case BuildingTypeId.SpecialForceUnits:
                return TroopsGroupId.INFANTRY;
            case BuildingTypeId.MotorizedInfantryFactory:
            case BuildingTypeId.ArmouredUnitsFactory:
                return TroopsGroupId.ARMOURED;
            case BuildingTypeId.ArtilleryFactory:
            case BuildingTypeId.ArtillerySystemsCenter:
                return TroopsGroupId.ARTILLERY;
            case BuildingTypeId.Airbase:
            case BuildingTypeId.AerospaceComplex:
            case BuildingTypeId.Incubator:
                return TroopsGroupId.AEROSPACE;
            default:
                trace(CLASS_NAME + "Неправильный тип военного здания.");
                return TroopsGroupId.INFANTRY;
        }
    }

    public static function GetByUnitType(param1:SceneObjectType):int {
        return GetGroupByTypeId(TroopsTypeId.ToRegular(param1.id));
    }

    public static function GetGroupByTroopsId(param1:GeoSceneObjectType):int {
        if (param1 == null) {
            return -1;
        }
        if (param1.id == TroopsTypeId.SectorMissile || param1.id == TroopsTypeId.SectorMissileStrong) {
            return TroopsGroupId.MISSILE;
        }
        if (param1 == null || param1.troopsInfo == null) {
            return TroopsGroupId.INFANTRY;
        }
        if (param1.id >= 37 && param1.id <= 40) {
            return TroopsGroupId.DEFENSIVE_UNITS;
        }
        if (param1.id >= 41 && param1.id <= 44) {
            return TroopsGroupId.DEFENSIVE_UNITS_2;
        }
        if (param1.id >= 45 && param1.id <= 48) {
            return TroopsGroupId.SPECIAL_FORCE_UNITS;
        }
        if (param1.id >= 49 && param1.id <= 52) {
            return TroopsGroupId.SPECIAL_FORCE_UNITS_2;
        }
        if (param1.id >= 53 && param1.id <= 56 || param1.id == 58) {
            return TroopsGroupId.BUGS;
        }
        if (param1.id >= 91 && param1.id <= 98 || param1.id == 9005 || param1.id == 9050 || param1.id == 9051 || param1.id >= TroopsTypeId.StrategyUnitAvp1 && param1.id <= TroopsTypeId.StrategyUnitAvp3) {
            return TroopsGroupId.STRATEGY;
        }
        if (param1.id == 59 || param1.id == 62 || param1.id == TroopsTypeId.IncubatorUnit3 || param1.id == TroopsTypeId.IncubatorUnit4) {
            return TroopsGroupId.INCUBATOR_UNITS;
        }
        if (param1.id == 60 || param1.id == 63 || param1.id == TroopsTypeId.IncubatorUnit3Gold || param1.id == TroopsTypeId.IncubatorUnit4Gold) {
            return TroopsGroupId.INCUBATOR_UNITS_2;
        }
        return param1.troopsInfo.groupId;
    }

    public static function getMorganaNameByTroopsId(param1:int):String {
        trace(" TROOPSID: " + param1.toString());
        if (param1 == TroopsTypeId.TowerGuard1) {
            return "Atata";
        }
        return "empty";
    }

    public static function getIconByGroupId(param1:int):String {
        switch (param1) {
            case INFANTRY:
            case INFANTRY_2:
                return "ui/icons/buildingInfo/infantry.png";
            case ARTILLERY:
            case ARTILLERY_2:
                return "ui/icons/buildingInfo/artillery.png";
            case ARMOURED:
            case ARMOURED_2:
                return "ui/icons/buildingInfo/armoured.png";
            case AEROSPACE:
            case AEROSPACE_2:
                return "ui/icons/buildingInfo/aviation.png";
            default:
                return "";
        }
    }

    public static function GetNameByGroupId(param1:int):String {
        switch (param1) {
            case INFANTRY:
            case INFANTRY_2:
                return LocaleUtil.getText("forms-formChoseTroops_infantry");
            case ARTILLERY:
            case ARTILLERY_2:
                return LocaleUtil.getText("forms-formChoseTroops_artillery");
            case ARMOURED:
            case ARMOURED_2:
                return LocaleUtil.getText("forms-formChoseTroops_armoured");
            case AEROSPACE:
            case AEROSPACE_2:
                return LocaleUtil.getText("forms-formChoseTroops_aviation");
            case ELITE_DEF:
                return LocaleUtil.getText("controls-common-troopsList-troopsListControl_eliteDef");
            case TACTICAL_BUILDING:
                return LocaleUtil.getText("controls-common-troopsList-troopsListControl_tacticalBuilding");
            case BUGS:
                return LocaleUtil.getText("controls-common-troopsList-troopsListControl_bugs");
            case STRATEGY:
                return LocaleUtil.getText("controls-common-troopsList-troopsListControl_strategyForces");
            case MISSILE:
                return LocaleUtil.getText("controls-common-troopsList-troopsListControl_missiles");
            case AVP:
                return LocaleUtil.getText("controls-common-troopsList-troopsListControl_alienPredator");
            default:
                trace(CLASS_NAME + "Неправильный тип военного здания.");
                return LocaleUtil.getText("forms-formChoseTroops_infantry");
        }
    }

    public static function GetShortNameByGroupId(param1:int):String {
        switch (param1) {
            case INFANTRY:
            case INFANTRY_2:
                return LocaleUtil.getText("navigation-menu-troopsControl_button01");
            case ARTILLERY:
            case ARTILLERY_2:
                return LocaleUtil.getText("navigation-menu-troopsControl_button03");
            case ARMOURED:
            case ARMOURED_2:
                return LocaleUtil.getText("navigation-menu-troopsControl_button02");
            case AEROSPACE:
            case AEROSPACE_2:
                return LocaleUtil.getText("navigation-menu-troopsControl_button04");
            case ELITE_DEF:
                return LocaleUtil.getText("controls-common-troopsList-troopsListControl_eliteDef");
            case TACTICAL_BUILDING:
                return LocaleUtil.getText("controls-common-troopsList-troopsListControl_tacticalBuilding");
            case BUGS:
                return LocaleUtil.getText("controls-common-troopsList-troopsListControl_bugs");
            case STRATEGY:
                return LocaleUtil.getText("controls-common-troopsList-troopsListControl_strategyForces");
            case MISSILE:
                return LocaleUtil.getText("controls-common-troopsList-troopsListControl_missiles");
            case AVP:
                return LocaleUtil.getText("controls-common-troopsList-troopsListControl_alienPredator");
            default:
                trace(CLASS_NAME + "Неправильный тип военного здания.");
                return LocaleUtil.getText("forms-formChoseTroops_infantry");
        }
    }

    public static function ToRegularGroupId(param1:int):int {
        switch (param1) {
            case INFANTRY_2:
                return INFANTRY;
            case ARTILLERY_2:
                return ARTILLERY;
            case ARMOURED_2:
                return ARMOURED;
            case AEROSPACE_2:
                return AEROSPACE;
            case DEFENSIVE_UNITS_2:
                return DEFENSIVE_UNITS;
            case SPECIAL_FORCE_UNITS_2:
                return SPECIAL_FORCE_UNITS;
            default:
                return param1;
        }
    }

    public static function GetGroupByTypeId(param1:int):int {
        if (param1 == TroopsTypeId.InfantryUnit1 || param1 == TroopsTypeId.InfantryUnit1Gold || param1 == TroopsTypeId.InfantryUnit1Mutant || param1 == TroopsTypeId.InfantryUnit4 || param1 == TroopsTypeId.InfantryUnit4Gold || param1 == TroopsTypeId.InfantryUnit4Mutant || param1 == TroopsTypeId.RedUnit7 || param1 == TroopsTypeId.CyborgUnit1 || param1 == TroopsTypeId.SpecialForcesInfantryUnit1 || param1 == TroopsTypeId.SpecialForcesInfantryUnit1Gold || param1 == TroopsTypeId.SpecialForcesInfantryUnit1Mutant || param1 == TroopsTypeId.StrategyUnit5 || param1 == TroopsTypeId.EarlyIncubatorUnit2 || param1 == TroopsTypeId.EarlyIncubatorUnit2Gold || param1 == TroopsTypeId.InfantryUnit2 || param1 == TroopsTypeId.InfantryUnit2Gold || param1 == TroopsTypeId.InfantryUnit2Mutant || param1 == TroopsTypeId.InfantryUnit3 || param1 == TroopsTypeId.RedUnit8 || param1 == TroopsTypeId.InfantryUnit3Gold || param1 == TroopsTypeId.InfantryUnit3Mutant || param1 == TroopsTypeId.DefensiveInfantryUnit1 || param1 == TroopsTypeId.DefensiveInfantryUnit1Gold || param1 == TroopsTypeId.DefensiveInfantryUnit1Mutant || param1 == TroopsTypeId.DefensiveInfantryUnit2 || param1 == TroopsTypeId.DefensiveInfantryUnit2Gold || param1 == TroopsTypeId.DefensiveInfantryUnit2Mutant || param1 == TroopsTypeId.DefensiveInfantryUnit3 || param1 == TroopsTypeId.DefensiveInfantryUnit3Gold || param1 == TroopsTypeId.DefensiveInfantryUnit3Mutant || param1 == TroopsTypeId.DefensiveInfantryUnit4 || param1 == TroopsTypeId.DefensiveInfantryUnit4Gold || param1 == TroopsTypeId.DefensiveInfantryUnit4Mutant || param1 == TroopsTypeId.SpecialForcesInfantryUnit2 || param1 == TroopsTypeId.SpecialForcesInfantryUnit2Gold || param1 == TroopsTypeId.SpecialForcesInfantryUnit2Mutant || param1 == TroopsTypeId.StrategyUnit9 || param1 == TroopsTypeId.EarlyIncubatorUnit1 || param1 == TroopsTypeId.EarlyIncubatorUnit1Gold) {
            return INFANTRY;
        }
        if (param1 == TroopsTypeId.ArmoredUnit2 || param1 == TroopsTypeId.ArmoredUnit2Gold || param1 == TroopsTypeId.ArmoredUnit2Mutant || param1 == TroopsTypeId.ArmoredUnit4 || param1 == TroopsTypeId.ArmoredUnit4Gold || param1 == TroopsTypeId.ArmoredUnit4Mutant || param1 == TroopsTypeId.SpecialForcesInfantryUnit3 || param1 == TroopsTypeId.SpecialForcesInfantryUnit3Gold || param1 == TroopsTypeId.SpecialForcesInfantryUnit3Mutant || param1 == TroopsTypeId.StrategyUnit2 || param1 == TroopsTypeId.RedUnit2 || param1 == TroopsTypeId.EarlyIncubatorUnit4 || param1 == TroopsTypeId.EarlyIncubatorUnit4Gold || param1 == TroopsTypeId.ArmoredUnit1 || param1 == TroopsTypeId.ArmoredUnit1Gold || param1 == TroopsTypeId.ArmoredUnit1Mutant || param1 == TroopsTypeId.ArmoredUnit3 || param1 == TroopsTypeId.ArmoredUnit3Gold || param1 == TroopsTypeId.ArmoredUnit3Mutant || param1 == TroopsTypeId.StrategyUnit6 || param1 == TroopsTypeId.RedUnit1 || param1 == TroopsTypeId.EarlyIncubatorUnit3 || param1 == TroopsTypeId.EarlyIncubatorUnit3Gold) {
            return ARMOURED;
        }
        if (param1 == TroopsTypeId.ArtilleryUnit2 || param1 == TroopsTypeId.ArtilleryUnit2Gold || param1 == TroopsTypeId.ArtilleryUnit2Mutant || param1 == TroopsTypeId.ArtilleryUnit4 || param1 == TroopsTypeId.ArtilleryUnit4Gold || param1 == TroopsTypeId.ArtilleryUnit4Mutant || param1 == TroopsTypeId.IncubatorUnit4 || param1 == TroopsTypeId.IncubatorUnit4Gold || param1 == TroopsTypeId.StrategyUnit7 || param1 == TroopsTypeId.StrategyUnit11 || param1 == TroopsTypeId.RedUnit4 || param1 == TroopsTypeId.ArtilleryUnit1 || param1 == TroopsTypeId.ArtilleryUnit1Gold || param1 == TroopsTypeId.ArtilleryUnit1Mutant || param1 == TroopsTypeId.ArtilleryUnit3 || param1 == TroopsTypeId.ArtilleryUnit3Gold || param1 == TroopsTypeId.ArtilleryUnit3Mutant || param1 == TroopsTypeId.StrategyUnit4 || param1 == TroopsTypeId.StrategyUnit10 || param1 == TroopsTypeId.RedUnit3) {
            return ARTILLERY;
        }
        if (param1 >= TroopsTypeId.TowerGuard1 && param1 <= TroopsTypeId.TowerGuard4 || param1 == TroopsTypeId.TowerGuard6) {
            return TroopsGroupId.BUGS;
        }
        if (param1 == TroopsTypeId.SpecialForcesInfantryUnit4 || param1 == TroopsTypeId.SpecialForcesInfantryUnit4Gold || param1 == TroopsTypeId.SpecialForcesInfantryUnit4Mutant || param1 == TroopsTypeId.SpecialForcesInfantryUnit5 || param1 == TroopsTypeId.StrategyUnit3 || param1 == TroopsTypeId.StrategyUnit11 || param1 == TroopsTypeId.RedUnit6 || param1 == TroopsTypeId.AirUnit1 || param1 == TroopsTypeId.AirUnit1Gold || param1 == TroopsTypeId.AirUnit1Mutant || param1 == TroopsTypeId.AirUnit3 || param1 == TroopsTypeId.AirUnit3Gold || param1 == TroopsTypeId.AirUnit3Mutant || param1 == TroopsTypeId.AirUnit4 || param1 == TroopsTypeId.AirUnit4Gold || param1 == TroopsTypeId.AirUnit4Mutant || param1 == TroopsTypeId.AirUnit4Exclusive || param1 == TroopsTypeId.AirUnit2 || param1 == TroopsTypeId.AirUnit2Gold || param1 == TroopsTypeId.AirUnit2Mutant || param1 == TroopsTypeId.AirUnit2Exclusive || param1 == TroopsTypeId.IncubatorUnit2 || param1 == TroopsTypeId.IncubatorUnit2Gold || param1 == TroopsTypeId.IncubatorUnit2Mutant || param1 == TroopsTypeId.StrategyUnit8 || param1 == TroopsTypeId.StrategyUnit10 || param1 == TroopsTypeId.RedUnit5 || param1 == TroopsTypeId.IncubatorUnit1 || param1 == TroopsTypeId.IncubatorUnit1Gold || param1 == TroopsTypeId.IncubatorUnit1Mutant || param1 == TroopsTypeId.IncubatorUnit3 || param1 == TroopsTypeId.IncubatorUnit3Gold || param1 == TroopsTypeId.IncubatorUnit3Mutant) {
            return AEROSPACE;
        }
        return -1;
    }

    public static function GetGroupFormCommandCenterSorting(param1:int):int {
        if (param1 == TroopsTypeId.StrategyUnit5 || param1 == TroopsTypeId.StrategyUnit9 || param1 == TroopsTypeId.StrategyUnit1 || param1 == TroopsTypeId.StrategyUnit2 || param1 == TroopsTypeId.StrategyUnit6 || param1 == TroopsTypeId.StrategyUnit7 || param1 == TroopsTypeId.StrategyUnit11 || param1 == TroopsTypeId.StrategyUnit8 || param1 == TroopsTypeId.StrategyUnit3 || param1 == TroopsTypeId.StrategyUnit4 || param1 == TroopsTypeId.StrategyUnit10 || param1 == TroopsTypeId.StrategyUnitAvp1 || param1 == TroopsTypeId.StrategyUnitAvp2 || param1 == TroopsTypeId.StrategyUnitAvp3) {
            return STRATEGY;
        }
        if (param1 == TroopsTypeId.RobotUnit1 || param1 == TroopsTypeId.RobotUnit2 || param1 == TroopsTypeId.RobotUnit21 || param1 == TroopsTypeId.RobotUnit22 || param1 == TroopsTypeId.RobotUnit23 || param1 == TroopsTypeId.RobotUnit3 || param1 == TroopsTypeId.GunTurrets || param1 == TroopsTypeId.GunTurrets2 || param1 == TroopsTypeId.GunTurrets3 || param1 == TroopsTypeId.GunTurrets4 || param1 == TroopsTypeId.GunTurrets5 || param1 == TroopsTypeId.GunTurrets6 || param1 == TroopsTypeId.GunTurrets7 || param1 == TroopsTypeId.GunTurrets8 || param1 == TroopsTypeId.GunTurrets9 || param1 == TroopsTypeId.GunTurrets10 || param1 == TroopsTypeId.MissileTurrets || param1 == TroopsTypeId.MissileTurrets2 || param1 == TroopsTypeId.MissileTurrets3 || param1 == TroopsTypeId.MissileTurrets4 || param1 == TroopsTypeId.MissileTurrets5 || param1 == TroopsTypeId.MissileTurrets6 || param1 == TroopsTypeId.MissileTurrets7 || param1 == TroopsTypeId.MissileTurrets8 || param1 == TroopsTypeId.MissileTurrets9 || param1 == TroopsTypeId.MissileTurrets10 || param1 == TroopsTypeId.Catapult || param1 == TroopsTypeId.Mortira) {
            return ELITE_DEF;
        }
        if (param1 == TroopsTypeId.RobotUnitBoostResources) {
            return TACTICAL_BUILDING;
        }
        if (param1 == TroopsTypeId.InfantryUnit1 || param1 == TroopsTypeId.InfantryUnit1Gold || param1 == TroopsTypeId.InfantryUnit1Mutant || param1 == TroopsTypeId.InfantryUnit4 || param1 == TroopsTypeId.InfantryUnit4Gold || param1 == TroopsTypeId.InfantryUnit4Mutant || param1 == TroopsTypeId.RedUnit7 || param1 == TroopsTypeId.SpecialForcesInfantryUnit1 || param1 == TroopsTypeId.SpecialForcesInfantryUnit1Gold || param1 == TroopsTypeId.SpecialForcesInfantryUnit1Mutant || param1 == TroopsTypeId.EarlyIncubatorUnit2 || param1 == TroopsTypeId.EarlyIncubatorUnit2Gold || param1 == TroopsTypeId.CyborgUnit1 || param1 == TroopsTypeId.InfantryUnit2 || param1 == TroopsTypeId.InfantryUnit2Gold || param1 == TroopsTypeId.InfantryUnit2Mutant || param1 == TroopsTypeId.InfantryUnit3 || param1 == TroopsTypeId.RedUnit8 || param1 == TroopsTypeId.InfantryUnit3Gold || param1 == TroopsTypeId.InfantryUnit3Mutant || param1 == TroopsTypeId.DefensiveInfantryUnit1 || param1 == TroopsTypeId.DefensiveInfantryUnit1Gold || param1 == TroopsTypeId.DefensiveInfantryUnit1Mutant || param1 == TroopsTypeId.DefensiveInfantryUnit2 || param1 == TroopsTypeId.DefensiveInfantryUnit2Gold || param1 == TroopsTypeId.DefensiveInfantryUnit2Mutant || param1 == TroopsTypeId.DefensiveInfantryUnit3 || param1 == TroopsTypeId.DefensiveInfantryUnit3Gold || param1 == TroopsTypeId.DefensiveInfantryUnit3Mutant || param1 == TroopsTypeId.DefensiveInfantryUnit4 || param1 == TroopsTypeId.DefensiveInfantryUnit4Gold || param1 == TroopsTypeId.DefensiveInfantryUnit4Mutant || param1 == TroopsTypeId.SpecialForcesInfantryUnit2 || param1 == TroopsTypeId.SpecialForcesInfantryUnit2Gold || param1 == TroopsTypeId.SpecialForcesInfantryUnit2Mutant || param1 == TroopsTypeId.EarlyIncubatorUnit1 || param1 == TroopsTypeId.EarlyIncubatorUnit1Gold) {
            return INFANTRY;
        }
        if (param1 == TroopsTypeId.ArmoredUnit2 || param1 == TroopsTypeId.ArmoredUnit2Gold || param1 == TroopsTypeId.ArmoredUnit2Mutant || param1 == TroopsTypeId.ArmoredUnit4 || param1 == TroopsTypeId.ArmoredUnit4Gold || param1 == TroopsTypeId.ArmoredUnit4Mutant || param1 == TroopsTypeId.SpecialForcesInfantryUnit3 || param1 == TroopsTypeId.SpecialForcesInfantryUnit3Gold || param1 == TroopsTypeId.SpecialForcesInfantryUnit3Mutant || param1 == TroopsTypeId.RedUnit2 || param1 == TroopsTypeId.EarlyIncubatorUnit4 || param1 == TroopsTypeId.EarlyIncubatorUnit4Gold || param1 == TroopsTypeId.ArmoredUnit1 || param1 == TroopsTypeId.ArmoredUnit1Gold || param1 == TroopsTypeId.ArmoredUnit1Mutant || param1 == TroopsTypeId.ArmoredUnit3 || param1 == TroopsTypeId.ArmoredUnit3Gold || param1 == TroopsTypeId.ArmoredUnit3Mutant || param1 == TroopsTypeId.RedUnit1 || param1 == TroopsTypeId.EarlyIncubatorUnit3 || param1 == TroopsTypeId.EarlyIncubatorUnit3Gold) {
            return ARMOURED;
        }
        if (param1 == TroopsTypeId.ArtilleryUnit2 || param1 == TroopsTypeId.ArtilleryUnit2Gold || param1 == TroopsTypeId.ArtilleryUnit2Mutant || param1 == TroopsTypeId.ArtilleryUnit4 || param1 == TroopsTypeId.ArtilleryUnit4Gold || param1 == TroopsTypeId.ArtilleryUnit4Mutant || param1 == TroopsTypeId.IncubatorUnit4 || param1 == TroopsTypeId.IncubatorUnit4Gold || param1 == TroopsTypeId.RedUnit4 || param1 == TroopsTypeId.ArtilleryUnit1 || param1 == TroopsTypeId.ArtilleryUnit1Gold || param1 == TroopsTypeId.ArtilleryUnit1Mutant || param1 == TroopsTypeId.ArtilleryUnit3 || param1 == TroopsTypeId.ArtilleryUnit3Gold || param1 == TroopsTypeId.ArtilleryUnit3Mutant || param1 == TroopsTypeId.RedUnit3) {
            return ARTILLERY;
        }
        if (param1 >= TroopsTypeId.TowerGuard1 && param1 <= TroopsTypeId.TowerGuard6) {
            return TroopsGroupId.BUGS;
        }
        if (param1 == TroopsTypeId.SpecialForcesInfantryUnit4 || param1 == TroopsTypeId.SpecialForcesInfantryUnit4Gold || param1 == TroopsTypeId.SpecialForcesInfantryUnit4Mutant || param1 == TroopsTypeId.SpecialForcesInfantryUnit5 || param1 == TroopsTypeId.RedUnit6 || param1 == TroopsTypeId.AirUnit1 || param1 == TroopsTypeId.AirUnit1Gold || param1 == TroopsTypeId.AirUnit1Mutant || param1 == TroopsTypeId.AirUnit3 || param1 == TroopsTypeId.AirUnit3Gold || param1 == TroopsTypeId.AirUnit3Mutant || param1 == TroopsTypeId.AirUnit4 || param1 == TroopsTypeId.AirUnit4Gold || param1 == TroopsTypeId.AirUnit4Mutant || param1 == TroopsTypeId.AirUnit4Exclusive || param1 == TroopsTypeId.AirUnit2 || param1 == TroopsTypeId.AirUnit2Gold || param1 == TroopsTypeId.AirUnit2Mutant || param1 == TroopsTypeId.AirUnit2Exclusive || param1 == TroopsTypeId.IncubatorUnit2 || param1 == TroopsTypeId.IncubatorUnit2Gold || param1 == TroopsTypeId.IncubatorUnit2Mutant || param1 == TroopsTypeId.RedUnit5 || param1 == TroopsTypeId.IncubatorUnit1Gold || param1 == TroopsTypeId.IncubatorUnit3 || param1 == TroopsTypeId.IncubatorUnit3Gold || param1 == TroopsTypeId.IncubatorUnit3Mutant || param1 == TroopsTypeId.IncubatorUnit1 || param1 == TroopsTypeId.IncubatorUnit1Gold || param1 == TroopsTypeId.IncubatorUnit1Mutant) {
            return AEROSPACE;
        }
        if (param1 == TroopsTypeId.SectorMissile || param1 == TroopsTypeId.SectorMissileStrong) {
            return TroopsGroupId.MISSILE;
        }
        if (param1 >= TroopsTypeId.AlienUnit1Off && param1 <= TroopsTypeId.AlienUnit4 || param1 >= TroopsTypeId.PredatorUnit1Off && param1 <= TroopsTypeId.PredatorUnit4 || param1 == TroopsTypeId.AvpRecon) {
            return TroopsGroupId.AVP;
        }
        return -1;
    }
}
}
