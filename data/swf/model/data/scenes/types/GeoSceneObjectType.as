package model.data.scenes.types {
import common.ArrayCustom;
import common.GameType;
import common.IEquatable;

import configs.Global;

import flash.events.Event;

import gameObjects.sceneObject.SimpleObjectType;

import model.data.inventory.InventoryItemTypeInfo;
import model.data.scenes.types.info.ArtifactTypeInfo;
import model.data.scenes.types.info.BuildingGroupId;
import model.data.scenes.types.info.BuildingLevelInfo;
import model.data.scenes.types.info.BuildingTypeId;
import model.data.scenes.types.info.BuildingTypeInfo;
import model.data.scenes.types.info.ClientSortOrder;
import model.data.scenes.types.info.DefensiveKind;
import model.data.scenes.types.info.DrawingTypeInfo;
import model.data.scenes.types.info.GemTypeInfo;
import model.data.scenes.types.info.GraphicsTypeInfo;
import model.data.scenes.types.info.SaleableTypeInfo;
import model.data.scenes.types.info.TechnologyTypeInfo;
import model.data.scenes.types.info.TroopsGroupId;
import model.data.scenes.types.info.TroopsKindId;
import model.data.scenes.types.info.TroopsLevelInfo;
import model.data.scenes.types.info.TroopsTypeId;
import model.data.scenes.types.info.TroopsTypeInfo;
import model.logic.ServerManager;
import model.logic.ServerTimeManager;

public class GeoSceneObjectType extends SimpleObjectType implements IEquatable {

    public static const CLASS_NAME:String = "GeotopiaSceneObjectType";


    public var slogan:String;

    public var descriptionExtended:String;

    public var graphicsInfo:GraphicsTypeInfo;

    public var saleableInfo:SaleableTypeInfo;

    public var buildingInfo:BuildingTypeInfo;

    public var troopsInfo:TroopsTypeInfo;

    public var technologyInfo:TechnologyTypeInfo;

    public var drawingInfo:DrawingTypeInfo;

    public var artifactInfo:ArtifactTypeInfo;

    public var gemInfo:GemTypeInfo;

    public var inventoryItemInfo:InventoryItemTypeInfo;

    public function GeoSceneObjectType(param1:int = 0, param2:String = "", param3:uint = 0, param4:uint = 0) {
        super();
        this.id = param1;
        this.name = param2;
        this.width = param3;
        this.height = param4;
    }

    public static function fromDto(param1:*):GeoSceneObjectType {
        var _loc2_:GeoSceneObjectType = new GeoSceneObjectType();
        _loc2_.id = param1.i;
        _loc2_.name = param1.n.c;
        _loc2_.description = param1.d == null ? null : param1.d.c;
        if (param1.e == null || param1.e.c == "") {
            _loc2_.descriptionExtended = _loc2_.description;
        }
        else {
            _loc2_.descriptionExtended = param1.e.c;
        }
        _loc2_.slogan = param1.s == null ? null : param1.s.c;
        _loc2_.graphicsInfo = GraphicsTypeInfo.fromDto(param1.gi);
        _loc2_.saleableInfo = SaleableTypeInfo.fromDto(param1.si);
        _loc2_.buildingInfo = BuildingTypeInfo.fromDto(param1.bi);
        _loc2_.troopsInfo = TroopsTypeInfo.fromDto(param1.ti);
        _loc2_.technologyInfo = TechnologyTypeInfo.fromDto(param1.ci);
        _loc2_.drawingInfo = DrawingTypeInfo.fromDto(param1.dc);
        _loc2_.artifactInfo = ArtifactTypeInfo.fromDto(param1.ai);
        _loc2_.gemInfo = GemTypeInfo.fromDto(param1.mi);
        _loc2_.inventoryItemInfo = InventoryItemTypeInfo.fromDto(param1.ri);
        _loc2_.url = _loc2_.graphicsInfo.url;
        _loc2_.width = _loc2_.graphicsInfo.sizeX;
        _loc2_.height = _loc2_.graphicsInfo.sizeY;
        _loc2_.offsetX = _loc2_.graphicsInfo.offsetX;
        _loc2_.offsetY = _loc2_.graphicsInfo.offsetY;
        _loc2_.offsetXRight = _loc2_.graphicsInfo.offsetXRight;
        if (GameType.isNords && !_loc2_.isGroupKind(BuildingGroupId.DECOR_FOR_SECTOR) && _loc2_.troopsInfo == null) {
            _loc2_.description = _loc2_.descriptionExtended;
        }
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public function get isTechnology():Boolean {
        return this.technologyInfo != null;
    }

    public function get isBuilding():Boolean {
        return this.buildingInfo != null;
    }

    public function get isBuildingFunctional():Boolean {
        return this.isBuilding && BuildingGroupId.isFunctional(this.buildingInfo.groupId);
    }

    public function get isOre():Boolean {
        return id == BuildingTypeId.UraniumOre || id == BuildingTypeId.TitaniumOre || id == BuildingTypeId.HousingEstateOre;
    }

    public function get isResource():Boolean {
        return this.isGroupKind(BuildingGroupId.RESOURCE);
    }

    public function get isAdministrative():Boolean {
        return this.isGroupKind(BuildingGroupId.ADMINISTRATIVE);
    }

    public function get isMilitary():Boolean {
        return this.isGroupKind(BuildingGroupId.MILITARY);
    }

    public function get isDecorForWalls():Boolean {
        return this.isGroupKind(BuildingGroupId.DECOR_FOR_WALLS);
    }

    public function get isDecorForSectorAndWalls():Boolean {
        return this.isGroupKind(BuildingGroupId.DECOR_FOR_SECTOR_AND_WALLS);
    }

    public function get isDecorForSector():Boolean {
        return this.isGroupKind(BuildingGroupId.DECOR_FOR_SECTOR);
    }

    public function get isPerimeter():Boolean {
        return this.isGroupKind(BuildingGroupId.DEFENSIVE);
    }

    public function get troopBaseParameters():TroopsLevelInfo {
        return this.troopsInfo == null ? null : this.troopsInfo.baseParameters;
    }

    public function get forceValue():Number {
        if (this.troopsInfo == null) {
            throw new Error("GeoSceneObjectType isn\'t troops. You can get this property only for troops!");
        }
        return !!this.isScout ? Number(this.troopBaseParameters.reconPower) : Number(this.troopBaseParameters.attackPower);
    }

    public function get isScout():Boolean {
        return this.troopsInfo && this.troopsInfo.kindId == TroopsKindId.RECON;
    }

    public function get isIntelligenceUnit():Boolean {
        return this.troopsInfo && (id == TroopsTypeId.StrategyUnit1 || this.troopsInfo.kindId == TroopsKindId.RECON);
    }

    public function get isTacticalBuilding():Boolean {
        return this.troopBaseParameters != null && this.troopBaseParameters.battleBehaviour != null && this.troopBaseParameters.battleBehaviour.civilUnit;
    }

    public function get isNotMilitaryBuilding():Boolean {
        return this.isBuilding && (id == BuildingTypeId.RobotBoostResources || id == BuildingTypeId.RobotRepair);
    }

    public function get isRobotBoostResources():Boolean {
        return this.isBuilding && id == BuildingTypeId.RobotBoostResources;
    }

    public function get isNew():Boolean {
        var _loc1_:* = false;
        var _loc2_:* = false;
        if (this.graphicsInfo) {
            _loc1_ = this.graphicsInfo.clientSortOrder == ClientSortOrder.Holiday;
            if (this.graphicsInfo.newUntil) {
                _loc2_ = this.graphicsInfo.newUntil.time > ServerTimeManager.serverTimeNow.time;
            }
        }
        return _loc1_ || _loc2_;
    }

    public function get clientSortOrder():int {
        var _loc1_:* = false;
        var _loc2_:int = !!this.graphicsInfo ? int(this.graphicsInfo.clientSortOrder) : 0;
        if (this.graphicsInfo && this.graphicsInfo.newUntil) {
            _loc1_ = this.graphicsInfo.newUntil.time > ServerTimeManager.serverTimeNow.time;
        }
        return !!_loc1_ ? int(ClientSortOrder.New) : int(_loc2_);
    }

    public function get isDefensive():Boolean {
        return this.isPerimeter || this.isTurret;
    }

    public function get isTurretLastLvl():Boolean {
        if (Global.WALLS_10LVL_ENABLED) {
            return id == BuildingTypeId.GunTurrets10 || id == BuildingTypeId.MissileTurrets10;
        }
        return id == BuildingTypeId.GunTurrets5 || id == BuildingTypeId.MissileTurrets5;
    }

    public function get isDecor():Boolean {
        return this.isBuilding && BuildingGroupId.isDecor(this.buildingInfo.groupId);
    }

    public function get isTurret():Boolean {
        return this.isDefensiveKind(DefensiveKind.DEFENSE_OBJECTS);
    }

    public function get isDeleteEnabled():Boolean {
        return this.isBuilding && (!BuildingGroupId.isFunctional(this.buildingInfo.groupId) || this.buildingInfo.canBeDeleted);
    }

    public function get isDecorativeBuilding():Boolean {
        return !this.isRobot && !this.isRobotBoostResources && (this.isDecor || this.isDecorMilitary);
    }

    public function get isRobotORDefenciveBuilding():Boolean {
        return !this.isRobotBoostResources && (this.isDefensive || this.isPerimeterBuildings || this.isDefensiveKind(DefensiveKind.ROBOT));
    }

    public function get isRoad():Boolean {
        return this.isDecor && this.isDefensiveKind(DefensiveKind.ROAD);
    }

    public function get isPerimeterBuildings():Boolean {
        return this.isDefensiveKind(DefensiveKind.GATE) || this.isDefensiveKind(DefensiveKind.WALL) || this.isDefensiveKind(DefensiveKind.TOWER);
    }

    public function get isMutant():Boolean {
        return id == TroopsTypeId.ToMutant(id);
    }

    public function get isGold():Boolean {
        return this.troopsInfo.groupId == TroopsGroupId.INFANTRY_2 || this.troopsInfo.groupId == TroopsGroupId.AEROSPACE_2 || this.troopsInfo.groupId == TroopsGroupId.ARMOURED_2 || this.troopsInfo.groupId == TroopsGroupId.ARTILLERY_2 || this.troopsInfo.groupId == TroopsGroupId.DEFENSIVE_UNITS_2 || this.troopsInfo.groupId == TroopsGroupId.SPECIAL_FORCE_UNITS_2;
    }

    public function get isMorganaUnits():Boolean {
        return id == TroopsTypeId.TowerGuard1 || id == TroopsTypeId.TowerGuard2 || id == TroopsTypeId.TowerGuard3 || id == TroopsTypeId.TowerGuard4 || id == TroopsTypeId.TowerGuard5 || id == TroopsTypeId.TowerGuard6;
    }

    public function get isMissile():Boolean {
        return id == TroopsTypeId.SectorMissile || id == TroopsTypeId.SectorMissileStrong;
    }

    public function get isRotateEnabled():Boolean {
        return this.isBuilding && !this.isOre;
    }

    public function get isUpgradeEnabled():Boolean {
        return this.isBuilding && !this.isOre && (id == BuildingTypeId.WallLevel1 || id == BuildingTypeId.WallLevel1Gate || id == BuildingTypeId.WallLevel1Tower || id == BuildingTypeId.WallLevel2 || id == BuildingTypeId.WallLevel2Gate || id == BuildingTypeId.WallLevel2Tower || id == BuildingTypeId.WallLevel3 || id == BuildingTypeId.WallLevel3Gate || id == BuildingTypeId.WallLevel3Tower || id == BuildingTypeId.Detectors || id == BuildingTypeId.Detectors2 || id == BuildingTypeId.Detectors3 || id == BuildingTypeId.GunTurrets || id == BuildingTypeId.GunTurrets2 || id == BuildingTypeId.GunTurrets3 || id == BuildingTypeId.MissileTurrets || id == BuildingTypeId.MissileTurrets2 || id == BuildingTypeId.MissileTurrets3 || id == BuildingTypeId.WallLevel4 || id == BuildingTypeId.WallLevel4Tower || id == BuildingTypeId.WallLevel4Gate || id == BuildingTypeId.WallLevel4Blue || id == BuildingTypeId.WallLevel4TowerBlue || id == BuildingTypeId.WallLevel4GateBlue || id == BuildingTypeId.Detectors4 || id == BuildingTypeId.GunTurrets4 || id == BuildingTypeId.MissileTurrets4 && !GameType.isTotalDomination || Global.WALLS_10LVL_ENABLED && (id == BuildingTypeId.WallLevel5 || id == BuildingTypeId.WallLevel5Gate || id == BuildingTypeId.WallLevel5Tower || id == BuildingTypeId.Detectors5 || id == BuildingTypeId.GunTurrets5 || id == BuildingTypeId.MissileTurrets5 || id == BuildingTypeId.WallLevel6 || id == BuildingTypeId.WallLevel6Gate || id == BuildingTypeId.WallLevel6Tower || id == BuildingTypeId.Detectors6 || id == BuildingTypeId.GunTurrets6 || id == BuildingTypeId.MissileTurrets6 || id == BuildingTypeId.WallLevel7 || id == BuildingTypeId.WallLevel7Gate || id == BuildingTypeId.WallLevel7Tower || id == BuildingTypeId.Detectors7 || id == BuildingTypeId.GunTurrets7 || id == BuildingTypeId.MissileTurrets7 || id == BuildingTypeId.WallLevel8 || id == BuildingTypeId.WallLevel8Gate || id == BuildingTypeId.WallLevel8Tower || id == BuildingTypeId.Detectors8 || id == BuildingTypeId.GunTurrets8 || id == BuildingTypeId.MissileTurrets8 || id == BuildingTypeId.WallLevel9 || id == BuildingTypeId.WallLevel9Gate || id == BuildingTypeId.WallLevel9Tower || id == BuildingTypeId.Detectors9 || id == BuildingTypeId.GunTurrets9 || id == BuildingTypeId.MissileTurrets9));
    }

    public function get isFlag():Boolean {
        return this.isDefensiveKind(DefensiveKind.FLAG) || id >= BuildingTypeId.UkraineFlag && id <= BuildingTypeId.TurkeyFlag;
    }

    public function get isHoliday():Boolean {
        return this.isDefensiveKind(DefensiveKind.HOLIDAYS);
    }

    public function get isMisc():Boolean {
        return this.buildingInfo && this.buildingInfo.defensiveKind != DefensiveKind.DECOR_MILITARY && this.buildingInfo.defensiveKind != DefensiveKind.FLAG && this.buildingInfo.defensiveKind != DefensiveKind.ROBOT && this.buildingInfo.defensiveKind != DefensiveKind.HOLIDAYS;
    }

    public function isDefensiveKind(param1:int):Boolean {
        return this.buildingInfo && this.buildingInfo.defensiveKind == param1;
    }

    public function isGroupKind(param1:int):Boolean {
        return this.buildingInfo && this.buildingInfo.groupId == param1;
    }

    public function get isOutdoorDecor():Boolean {
        return id >= BuildingTypeId.OutdoorDecor && id < BuildingTypeId.OutdoorTreasureGold;
    }

    public function get isOutdoorUnit():Boolean {
        return this.buildingInfo && (id == BuildingTypeId.OutdoorUnitIdDolphin1 || id == BuildingTypeId.OutdoorUnitIdDolphin2 || id == BuildingTypeId.OutdoorUnitIdDolphin3);
    }

    public function get isTreasure():Boolean {
        return this.buildingInfo && (id == BuildingTypeId.OutdoorTreasureGold || id == BuildingTypeId.OutdoorTreasureRom || id == BuildingTypeId.OutdoorTreasureWood);
    }

    public function get isRobot():Boolean {
        var _loc1_:Boolean = this.troopsInfo && this.troopsInfo.groupId == TroopsGroupId.ELITE_DEF;
        return _loc1_ || this.isDefensiveKind(DefensiveKind.ROBOT);
    }

    public function get isStrategyUnit():Boolean {
        return this.troopsInfo && (id >= TroopsTypeId.StrategyUnit1 && id <= TroopsTypeId.StrategyUnit8) || id == TroopsTypeId.StrategyUnit9 || id == TroopsTypeId.StrategyUnit10 || id == TroopsTypeId.StrategyUnit11 || id == TroopsTypeId.StrategyUnitAvp1 || id == TroopsTypeId.StrategyUnitAvp2 || id == TroopsTypeId.StrategyUnitAvp3;
    }

    public function get isCyborg():Boolean {
        return this.troopsInfo != null && id == TroopsTypeId.CyborgUnit1;
    }

    public function get isIncubatorUnit():Boolean {
        return this.troopsInfo && (id == TroopsTypeId.IncubatorUnit1 || id == TroopsTypeId.AirUnit1Gold || id == TroopsTypeId.IncubatorUnit1Mutant || id == TroopsTypeId.IncubatorUnit2 || id == TroopsTypeId.AirUnit2Gold || id == TroopsTypeId.IncubatorUnit2Mutant || id == TroopsTypeId.IncubatorUnit3 || id == TroopsTypeId.AirUnit3Gold || id == TroopsTypeId.IncubatorUnit3Mutant || id == TroopsTypeId.IncubatorUnit4 || id == TroopsTypeId.AirUnit4Gold || id == TroopsTypeId.EarlyIncubatorUnit1 || id == TroopsTypeId.EarlyIncubatorUnit2 || id == TroopsTypeId.EarlyIncubatorUnit3 || id == TroopsTypeId.EarlyIncubatorUnit4 || id == TroopsTypeId.EarlyIncubatorUnit1Gold || id == TroopsTypeId.EarlyIncubatorUnit2Gold || id == TroopsTypeId.EarlyIncubatorUnit3Gold || id == TroopsTypeId.EarlyIncubatorUnit4Gold);
    }

    public function get isRedUnit():Boolean {
        return this.troopsInfo && (id >= TroopsTypeId.RedUnit1 && id <= TroopsTypeId.RedUnit6 || id == TroopsTypeId.RedUnit7 || id == TroopsTypeId.RedUnit8);
    }

    public function get isDecorMilitary():Boolean {
        return this.isRobot || this.isDefensiveKind(DefensiveKind.DECOR_MILITARY);
    }

    public function get robotTroopsId():int {
        if (this.isDefensiveKind(DefensiveKind.ROBOT) && this.buildingInfo.levelInfos[0] as BuildingLevelInfo) {
            return (this.buildingInfo.levelInfos[0] as BuildingLevelInfo).troopsTypeId;
        }
        return id;
    }

    public function get isMutagenBuilding():Boolean {
        return id == BuildingTypeId.CyborgBarrel;
    }

    public function getUpgradeBuildingId():Array {
        var _loc1_:Boolean = GameType.isMilitary || GameType.isSparta;
        var _loc2_:Boolean = Global.WALLS_10LVL_ENABLED;
        if (!_loc1_ && !this.isUpgradeEnabled) {
            return [];
        }
        switch (id) {
            case BuildingTypeId.WallLevel1:
                return [BuildingTypeId.WallLevel2];
            case BuildingTypeId.WallLevel2:
                return [BuildingTypeId.WallLevel3];
            case BuildingTypeId.WallLevel3:
                if (GameType.isTotalDomination) {
                    return [BuildingTypeId.WallLevel4, BuildingTypeId.WallLevel4Blue];
                }
                return [BuildingTypeId.WallLevel4];
            case BuildingTypeId.WallLevel4:
            case BuildingTypeId.WallLevel4Blue:
                return [BuildingTypeId.WallLevel5];
            case BuildingTypeId.WallLevel5:
                return [BuildingTypeId.WallLevel6];
            case BuildingTypeId.WallLevel6:
                return [BuildingTypeId.WallLevel7];
            case BuildingTypeId.WallLevel7:
                return [BuildingTypeId.WallLevel8];
            case BuildingTypeId.WallLevel8:
                return [BuildingTypeId.WallLevel9];
            case BuildingTypeId.WallLevel9:
                return [BuildingTypeId.WallLevel10];
            case BuildingTypeId.WallLevel1Tower:
                return [BuildingTypeId.WallLevel2Tower];
            case BuildingTypeId.WallLevel2Tower:
                return [BuildingTypeId.WallLevel3Tower];
            case BuildingTypeId.WallLevel3Tower:
                if (GameType.isTotalDomination) {
                    return [BuildingTypeId.WallLevel4Tower, BuildingTypeId.WallLevel4TowerBlue];
                }
                return [BuildingTypeId.WallLevel4Tower];
            case BuildingTypeId.WallLevel4Tower:
            case BuildingTypeId.WallLevel4TowerBlue:
                return [BuildingTypeId.WallLevel5Tower];
            case BuildingTypeId.WallLevel5Tower:
                return [BuildingTypeId.WallLevel6Tower];
            case BuildingTypeId.WallLevel6Tower:
                return [BuildingTypeId.WallLevel7Tower];
            case BuildingTypeId.WallLevel7Tower:
                return [BuildingTypeId.WallLevel8Tower];
            case BuildingTypeId.WallLevel8Tower:
                return [BuildingTypeId.WallLevel9Tower];
            case BuildingTypeId.WallLevel9Tower:
                return [BuildingTypeId.WallLevel10Tower];
            case BuildingTypeId.WallLevel1Gate:
                return [BuildingTypeId.WallLevel2Gate];
            case BuildingTypeId.WallLevel2Gate:
                return [BuildingTypeId.WallLevel3Gate];
            case BuildingTypeId.WallLevel3Gate:
                if (GameType.isTotalDomination) {
                    return [BuildingTypeId.WallLevel4Gate, BuildingTypeId.WallLevel4GateBlue];
                }
                return [BuildingTypeId.WallLevel4Gate];
            case BuildingTypeId.WallLevel4Gate:
            case BuildingTypeId.WallLevel4GateBlue:
                return [BuildingTypeId.WallLevel5Gate];
            case BuildingTypeId.WallLevel5Gate:
                return [BuildingTypeId.WallLevel6Gate];
            case BuildingTypeId.WallLevel6Gate:
                return [BuildingTypeId.WallLevel7Gate];
            case BuildingTypeId.WallLevel7Gate:
                return [BuildingTypeId.WallLevel8Gate];
            case BuildingTypeId.WallLevel8Gate:
                return [BuildingTypeId.WallLevel9Gate];
            case BuildingTypeId.WallLevel9Gate:
                return [BuildingTypeId.WallLevel10Gate];
            case BuildingTypeId.Detectors:
                return [BuildingTypeId.Detectors2];
            case BuildingTypeId.Detectors2:
                return [BuildingTypeId.Detectors3];
            case BuildingTypeId.Detectors3:
                return [BuildingTypeId.Detectors4];
            case BuildingTypeId.Detectors4:
                return [BuildingTypeId.Detectors5];
            case BuildingTypeId.Detectors5:
                return [BuildingTypeId.Detectors6];
            case BuildingTypeId.Detectors6:
                return [BuildingTypeId.Detectors7];
            case BuildingTypeId.Detectors7:
                return [BuildingTypeId.Detectors8];
            case BuildingTypeId.Detectors8:
                return [BuildingTypeId.Detectors9];
            case BuildingTypeId.Detectors9:
                return [BuildingTypeId.Detectors10];
            case BuildingTypeId.GunTurrets:
                return [BuildingTypeId.GunTurrets2];
            case BuildingTypeId.GunTurrets2:
                return [BuildingTypeId.GunTurrets3];
            case BuildingTypeId.GunTurrets3:
                return [BuildingTypeId.GunTurrets4];
            case BuildingTypeId.GunTurrets4:
                return [BuildingTypeId.GunTurrets5];
            case BuildingTypeId.GunTurrets5:
                return [BuildingTypeId.GunTurrets6];
            case BuildingTypeId.GunTurrets6:
                return [BuildingTypeId.GunTurrets7];
            case BuildingTypeId.GunTurrets7:
                return [BuildingTypeId.GunTurrets8];
            case BuildingTypeId.GunTurrets8:
                return [BuildingTypeId.GunTurrets9];
            case BuildingTypeId.GunTurrets9:
                return [BuildingTypeId.GunTurrets10];
            case BuildingTypeId.MissileTurrets:
                return [BuildingTypeId.MissileTurrets2];
            case BuildingTypeId.MissileTurrets2:
                return [BuildingTypeId.MissileTurrets3];
            case BuildingTypeId.MissileTurrets3:
                return [BuildingTypeId.MissileTurrets4];
            case BuildingTypeId.MissileTurrets4:
                return [BuildingTypeId.MissileTurrets5];
            case BuildingTypeId.MissileTurrets5:
                return [BuildingTypeId.MissileTurrets6];
            case BuildingTypeId.MissileTurrets6:
                return [BuildingTypeId.MissileTurrets7];
            case BuildingTypeId.MissileTurrets7:
                return [BuildingTypeId.MissileTurrets8];
            case BuildingTypeId.MissileTurrets8:
                return [BuildingTypeId.MissileTurrets9];
            case BuildingTypeId.MissileTurrets9:
                return [BuildingTypeId.MissileTurrets10];
            case TroopsTypeId.GunTurrets:
                return !!_loc1_ ? [BuildingTypeId.GunTurrets2] : [];
            case TroopsTypeId.GunTurrets2:
                return !!_loc1_ ? [BuildingTypeId.GunTurrets3] : [];
            case TroopsTypeId.GunTurrets3:
                return !!_loc1_ ? [BuildingTypeId.GunTurrets4] : [];
            case TroopsTypeId.GunTurrets4:
                return !!_loc1_ ? [BuildingTypeId.GunTurrets5] : [];
            case TroopsTypeId.GunTurrets5:
                return _loc1_ && _loc2_ ? [BuildingTypeId.GunTurrets6] : [];
            case TroopsTypeId.GunTurrets6:
                return _loc1_ && _loc2_ ? [BuildingTypeId.GunTurrets7] : [];
            case TroopsTypeId.GunTurrets7:
                return _loc1_ && _loc2_ ? [BuildingTypeId.GunTurrets8] : [];
            case TroopsTypeId.GunTurrets8:
                return _loc1_ && _loc2_ ? [BuildingTypeId.GunTurrets9] : [];
            case TroopsTypeId.GunTurrets9:
                return _loc1_ && _loc2_ ? [BuildingTypeId.GunTurrets10] : [];
            case TroopsTypeId.MissileTurrets:
                return !!_loc1_ ? [BuildingTypeId.MissileTurrets2] : [];
            case TroopsTypeId.MissileTurrets2:
                return !!_loc1_ ? [BuildingTypeId.MissileTurrets3] : [];
            case TroopsTypeId.MissileTurrets3:
                return !!_loc1_ ? [BuildingTypeId.MissileTurrets4] : [];
            case TroopsTypeId.MissileTurrets4:
                return !!_loc1_ ? [BuildingTypeId.MissileTurrets5] : [];
            case TroopsTypeId.MissileTurrets5:
                return _loc1_ && _loc2_ ? [BuildingTypeId.MissileTurrets6] : [];
            case TroopsTypeId.MissileTurrets6:
                return _loc1_ && _loc2_ ? [BuildingTypeId.MissileTurrets7] : [];
            case TroopsTypeId.MissileTurrets7:
                return _loc1_ && _loc2_ ? [BuildingTypeId.MissileTurrets8] : [];
            case TroopsTypeId.MissileTurrets8:
                return _loc1_ && _loc2_ ? [BuildingTypeId.MissileTurrets9] : [];
            case TroopsTypeId.MissileTurrets9:
                return _loc1_ && _loc2_ ? [BuildingTypeId.MissileTurrets10] : [];
            default:
                return [];
        }
    }

    private function getUrl():String {
        return ServerManager.buildContentUrl(url);
    }

    public function getUrlForShop(param1:Boolean = true):String {
        var _loc2_:String = !!param1 ? this.getUrl() : url;
        var _loc3_:int = _loc2_.length - 4;
        if (_loc3_ <= 0) {
            return _loc2_;
        }
        var _loc4_:* = _loc2_.substring(0, _loc3_);
        _loc4_ = _loc4_ + "_p.jpg";
        return _loc4_;
    }

    public function getUrlForBlackMarket(param1:Boolean = true):String {
        if (TroopsGroupId.GetGroupByTroopsId(this) != TroopsGroupId.STRATEGY) {
            return "";
        }
        var _loc2_:String = !!param1 ? this.getUrl() : url;
        var _loc3_:int = _loc2_.length - 4;
        if (_loc3_ <= 0) {
            return _loc2_;
        }
        var _loc4_:* = _loc2_.substring(0, _loc3_);
        _loc4_ = _loc4_ + "_bm01.jpg";
        return _loc4_;
    }

    public function getUrlForBlackMarketSmall():String {
        var _loc1_:String = this.getUrl();
        var _loc2_:int = _loc1_.length - 4;
        if (_loc2_ <= 0) {
            return _loc1_;
        }
        var _loc3_:* = _loc1_.substring(0, _loc2_);
        _loc3_ = _loc3_ + "_bc.jpg";
        return _loc3_;
    }

    public function getUrlForRequirements(param1:Boolean = true):String {
        var _loc2_:String = !!param1 ? this.getUrl() : url;
        var _loc3_:int = _loc2_.length - 4;
        if (_loc3_ <= 0) {
            return _loc2_;
        }
        var _loc4_:* = _loc2_.substring(0, _loc3_);
        _loc4_ = _loc4_ + "_ps.jpg";
        return _loc4_;
    }

    public function getUrlForBrokenRequirements():String {
        var _loc1_:String = this.getUrl();
        var _loc2_:int = _loc1_.length - 4;
        if (_loc2_ <= 0) {
            return _loc1_;
        }
        var _loc3_:* = _loc1_.substring(0, _loc2_);
        _loc3_ = _loc3_ + "_broken_ps.jpg";
        return _loc3_;
    }

    public function getUrlForBroken():String {
        var _loc1_:String = this.getUrl();
        var _loc2_:int = _loc1_.length - 4;
        if (_loc2_ <= 0) {
            return _loc1_;
        }
        var _loc3_:* = _loc1_.substring(0, _loc2_);
        _loc3_ = _loc3_ + "_broken.swf";
        return _loc3_;
    }

    public function getUrlForTechnologyIcon():String {
        var _loc1_:String = this.getUrl();
        var _loc2_:int = _loc1_.length - 4;
        if (_loc2_ <= 0) {
            return _loc1_;
        }
        var _loc3_:* = _loc1_.substring(0, _loc2_);
        _loc3_ = _loc3_ + "_t.jpg";
        return _loc3_;
    }

    public function getUrlForTechnologyDrawing():String {
        var _loc1_:String = this.getUrl();
        var _loc2_:int = _loc1_.length - 4;
        if (_loc2_ <= 0) {
            return _loc1_;
        }
        var _loc3_:* = _loc1_.substring(0, _loc2_);
        if (GameType.isTotalDomination || GameType.isMilitary || GameType.isSparta) {
            _loc3_ = _loc3_ + "_d.png";
        }
        else {
            _loc3_ = _loc3_ + "_d.jpg";
        }
        return _loc3_;
    }

    override protected function createEvent(param1:String):Event {
        return new Event(param1);
    }

    public function isEqual(param1:*):Boolean {
        var _loc2_:GeoSceneObjectType = param1 as GeoSceneObjectType;
        if (_loc2_ == null) {
            return false;
        }
        return this.id == _loc2_.id;
    }
}
}
