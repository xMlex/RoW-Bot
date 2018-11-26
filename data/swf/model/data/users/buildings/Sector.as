package model.data.users.buildings {
import common.ArrayCustom;
import common.GameType;
import common.queries.util.query;

import flash.utils.Dictionary;

import gameObjects.observableObject.ObservableObject;
import gameObjects.sceneObject.SceneObject;

import model.data.SectorSlotExtension;
import model.data.User;
import model.data.normalization.INEvent;
import model.data.normalization.INormalizable;
import model.data.scenes.GeoScene;
import model.data.scenes.SectorScene;
import model.data.scenes.WarCampScene;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.BuildingGroupId;
import model.data.scenes.types.info.BuildingLevelInfo;
import model.data.scenes.types.info.BuildingTypeId;
import model.data.scenes.types.info.DefensiveKind;
import model.data.scenes.types.info.RequiredObject;
import model.data.scenes.types.info.SaleableLevelInfo;
import model.data.scenes.types.info.TroopsGroupId;
import model.logic.StaticDataManager;
import model.logic.UserDemoManager;
import model.logic.UserManager;
import model.logic.UserNoteManager;

public class Sector extends ObservableObject implements INormalizable {

    public static const MAX_TURRETS_COUNT:int = 12;

    public static const MAX_GATES_COUNT:int = 4;

    public static const WALL_OFFSET:int = 11;

    public static const MAX_NAME_LENGTH:int = 19;

    public static const CLASS_NAME:String = "Sector";

    public static const BUILDINGS_CHANGED:String = CLASS_NAME + "BuildingsChanged";

    public static const BUILDINGS_CHANGED_ANY:String = CLASS_NAME + "BuildingsChangedAny";

    public static const SECTOR_NAME_CHANGED:String = CLASS_NAME + "SectorNameChanged";

    public static const SLOTS_CHANGED:String = CLASS_NAME + "SlotsChanged";

    public static const BUILDING_REPAIREDfOR_USER_CHANGE_EVENT:String = "buildingRepairedForUserChanged";

    public static const BUILDING_UPGRADE_COMPLETED:String = CLASS_NAME + "BuildingUpgradeCompleted";

    public static const TECHNOLOGY_RESEARCH_COMPLETED:String = CLASS_NAME + "TechnologyResearchCompleted";

    public static const SKILL_RESEARCH_COMPLETED:String = CLASS_NAME + "SkillResearchCompleted";

    private static const BUILDINGS_WITH_LIMIT_BONUSES:Array = [BuildingTypeId.Consulate];


    private var _name:String;

    private var _slots:ArrayCustom;

    private var _totalBoughtExtensionPacks:int;

    public var nextObjectId:int;

    public var sectorScene:GeoScene;

    public var warcampScene:GeoScene;

    public var buildingRepairedByUserIds:ArrayCustom;

    private var _buildingRepairedForUserIds:ArrayCustom;

    public var buildingsDeletedByUserTypeIds:ArrayCustom;

    public var lastDateBuildingRepairedByUser:Date;

    public var militaryBildingsCount:int = 0;

    public var civilBuildingsCount:int = 0;

    public var decorativeBuildingsCount:int = 0;

    public var perimeterDefenseLevel:int = 0;

    public var defensivePoints:int = 0;

    public var defensiveIntelligencePoints:int = 0;

    public var lastBuildedOrUpdatedBuilding:GeoSceneObject;

    public var lastClickId:Number;

    public var buildingsCountByTypeId:Dictionary = null;

    public var towersCount:int;

    public var gatesCount:int;

    public var defensiveObjectsWall:int;

    public var bRepairRobotInSector:Boolean = false;

    public var maxLevelBuildingDictionary:Dictionary;

    private var _hasConsulate:Boolean;

    public function Sector() {
        this.maxLevelBuildingDictionary = new Dictionary();
        super();
    }

    private static function getBuildingFinishedTime(param1:GeoSceneObject, param2:Date):Date {
        if (param1.constructionObjInfo.constructionStartTime == null) {
            return null;
        }
        param1.constructionObjInfo.updatePercentage(param2);
        param1.dirtyNormalized = true;
        return param1.constructionObjInfo.constructionFinishTime;
    }

    public static function fromDto(param1:*, param2:Boolean = false):Sector {
        var _loc3_:Sector = new Sector();
        _loc3_.name = param1.i;
        _loc3_.nextObjectId = param1.n;
        _loc3_.sectorScene = SectorScene.fromDto(param1.s, param2);
        _loc3_.warcampScene = WarCampScene.fromDto(param1.w);
        _loc3_.buildingRepairedByUserIds = new ArrayCustom(param1.f);
        _loc3_.buildingRepairedForUserIds = new ArrayCustom(param1.o);
        _loc3_.buildingsDeletedByUserTypeIds = new ArrayCustom(param1.r);
        _loc3_.lastDateBuildingRepairedByUser = param1.d == null ? null : new Date(param1.d);
        _loc3_.setSlots(!!param1.t ? param1.t : null);
        _loc3_.setTotalBoughtExtensionPacks(!!param1.b ? int(param1.b) : -1);
        _loc3_.lastClickId = param1.c == null ? Number(-1) : Number(param1.c);
        return _loc3_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function toDtos(param1:ArrayCustom):Array {
        var _loc3_:Sector = null;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function get name():String {
        if (this._name.length > MAX_NAME_LENGTH) {
            this._name = this._name.slice(0, MAX_NAME_LENGTH);
        }
        return this._name;
    }

    public function set name(param1:String):void {
        if (param1 == "[demo_sector_name]") {
            param1 = UserNoteManager.getById(UserDemoManager.DemoUserId).sectorName;
        }
        else if (param1.length > MAX_NAME_LENGTH) {
            param1 = param1.slice(0, MAX_NAME_LENGTH);
        }
        if (this._name == null) {
            this._name = param1;
        }
        else if (this._name != param1) {
            this._name = param1;
            dispatchEvent(SECTOR_NAME_CHANGED);
        }
    }

    public function get buildingRepairedForUserIds():ArrayCustom {
        return this._buildingRepairedForUserIds;
    }

    public function set buildingRepairedForUserIds(param1:ArrayCustom):void {
        this._buildingRepairedForUserIds = param1;
        dispatchEvent(BUILDING_REPAIREDfOR_USER_CHANGE_EVENT);
    }

    private function isSameArrays(param1:ArrayCustom, param2:ArrayCustom):Boolean {
        var _loc3_:Number = NaN;
        if (!param1 || !param2 || param1.length != param2.length) {
            return false;
        }
        for each(_loc3_ in param1) {
            if (param2.getItemIndex(_loc3_) == -1) {
                return false;
            }
        }
        return true;
    }

    public function recalcBuildings():void {
        var b:GeoSceneObject = null;
        var changed:Boolean = false;
        var isMilitaryDefenceObject:Boolean = false;
        var buildingGroup:int = 0;
        var military:int = 0;
        var civil:int = 0;
        var decorative:int = 0;
        var perimeter:int = 0;
        var defensive:int = 0;
        var defensiveIntelligence:int = 0;
        var defensiveWallObjects:int = 0;
        var countByTypeId:Dictionary = new Dictionary();
        var towers:int = 0;
        var gates:int = 0;
        for each(b in this.sectorScene.sceneObjects) {
            if (countByTypeId[b.objectType.id] == null) {
                countByTypeId[b.objectType.id] = 1;
            }
            else {
                countByTypeId[b.objectType.id]++;
            }
            if (b.objectType == null) {
                continue;
            }
            if (b.getLevel() == 0 || b.buildingInfo.broken) {
                continue;
            }
            if (BuildingTypeId.RobotRepair == b.objectType.id && !this.bRepairRobotInSector) {
                this.bRepairRobotInSector = true;
            }
            if (b.objectType.buildingInfo.groupId == BuildingGroupId.DEFENSIVE || GameType.isMilitary && b.objectType.buildingInfo.groupId == BuildingGroupId.DECOR_FOR_SECTOR_AND_WALLS) {
                if (b.objectType.buildingInfo.defensiveKind == DefensiveKind.TOWER) {
                    towers++;
                }
                if (b.objectType.buildingInfo.defensiveKind == DefensiveKind.GATE) {
                    gates++;
                }
            }
            isMilitaryDefenceObject = GameType.isMilitary && b.objectType.isRobot && !b.objectType.isNotMilitaryBuilding;
            if (b.objectType.isDecorForWalls && b.objectType.isTurret || isMilitaryDefenceObject) {
                defensiveWallObjects++;
            }
            try {
                if (b.objectType.buildingInfo.getLevelInfo(b.constructionInfo.level).defenceBonusPoints > 0) {
                    defensive = defensive + b.objectType.buildingInfo.getLevelInfo(b.constructionInfo.level).defenceBonusPoints;
                }
                if (b.objectType.buildingInfo.getLevelInfo(b.constructionInfo.level).defenceIntelligencePoints > 0) {
                    defensiveIntelligence = defensiveIntelligence + b.objectType.buildingInfo.getLevelInfo(b.constructionInfo.level).defenceIntelligencePoints;
                }
            }
            catch (err:Error) {
            }
            buildingGroup = b.objectType.buildingInfo.groupId;
            switch (buildingGroup) {
                case BuildingGroupId.ADMINISTRATIVE:
                    civil++;
                    continue;
                case BuildingGroupId.MILITARY:
                case BuildingGroupId.DEFENSIVE:
                case BuildingGroupId.DECOR_FOR_WALLS:
                    military++;
                    perimeter++;
                    continue;
                case BuildingGroupId.DECOR_FOR_LAND:
                case BuildingGroupId.DECOR_FOR_SECTOR:
                case BuildingGroupId.DECOR_FOR_SECTOR_AND_WALLS:
                    decorative++;
                    continue;
                case BuildingGroupId.RESOURCE:
                    if (!this.maxLevelBuildingDictionary[b.type.id]) {
                        this.maxLevelBuildingDictionary[b.type.id] = b;
                    }
                    else if (this.maxLevelBuildingDictionary[b.type.id].getLevel() < b.getLevel()) {
                        this.maxLevelBuildingDictionary[b.type.id] = b;
                    }
                    continue;
                default:
                    continue;
            }
        }
        changed = this.militaryBildingsCount != military || this.civilBuildingsCount != civil || this.decorativeBuildingsCount != decorative || this.perimeterDefenseLevel != perimeter || this.defensivePoints != defensive || this.defensiveIntelligencePoints != defensiveIntelligence;
        this.militaryBildingsCount = military;
        this.civilBuildingsCount = civil;
        this.decorativeBuildingsCount = decorative;
        this.perimeterDefenseLevel = perimeter;
        this.defensivePoints = defensive;
        this.defensiveIntelligencePoints = defensiveIntelligence;
        this.buildingsCountByTypeId = countByTypeId;
        this.towersCount = towers;
        this.gatesCount = gates;
        this.defensiveObjectsWall = defensiveWallObjects;
        if (changed) {
            dispatchEvent(BUILDINGS_CHANGED);
        }
        dispatchEvent(BUILDINGS_CHANGED_ANY);
    }

    public function extendSlots(param1:SectorSlotExtension):void {
        var _loc2_:Array = param1.slotIds;
        this.updateSlots(_loc2_);
    }

    public function extend(param1:int):void {
        var _loc5_:GeoSceneObject = null;
        var _loc2_:int = this.sectorScene.sizeX - SectorScene.WALL_AREA_DEPTH + (SectorScene.WALL_AREA_DEPTH - SectorScene.WALL_OFFSET);
        var _loc3_:int = param1 + SectorScene.WALL_AREA_DEPTH + (SectorScene.WALL_AREA_DEPTH - SectorScene.WALL_OFFSET);
        var _loc4_:int = _loc3_ - _loc2_;
        this.sectorScene.setSize(param1 + SectorScene.WALL_AREA_DEPTH * 2, param1 + SectorScene.WALL_AREA_DEPTH * 2);
        for each(_loc5_ in this.sectorScene.sceneObjects) {
            if (_loc5_.objectType.buildingInfo.isFunctional != true) {
                if (_loc5_.row >= _loc2_) {
                    _loc5_.row = _loc5_.row + _loc4_;
                }
                if (_loc5_.column >= _loc2_) {
                    _loc5_.column = _loc5_.column + _loc4_;
                }
            }
        }
        if (this.warcampScene != null) {
            this.warcampScene.setSize(this.sectorScene.sizeX, this.sectorScene.sizeY);
        }
    }

    public function getActiveBuildings():Vector.<GeoSceneObject> {
        var _loc2_:GeoSceneObject = null;
        var _loc1_:Vector.<GeoSceneObject> = new Vector.<GeoSceneObject>();
        for each(_loc2_ in this.sectorScene.sceneObjects) {
            if (!_loc2_.isBuying) {
                if (_loc2_.constructionObjInfo && _loc2_.constructionObjInfo.level > 0) {
                    _loc1_[_loc1_.length] = _loc2_;
                }
            }
        }
        return _loc1_;
    }

    public function hasActiveBuilding(param1:int, param2:int, param3:int = 1):Boolean {
        var _loc5_:SceneObject = null;
        var _loc6_:GeoSceneObject = null;
        if (GameType.isNords && this.pseudoActiveBuildings(param1)) {
            return true;
        }
        var _loc4_:int = 0;
        for each(_loc5_ in this.sectorScene.sceneObjects) {
            _loc6_ = _loc5_ as GeoSceneObject;
            if (_loc6_.objectType && _loc6_.objectType.id == param1 && _loc6_.constructionObjInfo.level >= param2) {
                if (param3 == 1) {
                    return true;
                }
                _loc4_++;
                if (_loc4_ >= param3) {
                    return true;
                }
            }
        }
        return _loc4_ >= param3;
    }

    public function get hasConsulate():Boolean {
        if (!this._hasConsulate) {
            this._hasConsulate = this.hasActiveBuilding(BuildingTypeId.Consulate, 1);
        }
        return this._hasConsulate;
    }

    public function buildingLimitBonuses(param1:int):int {
        var _loc3_:int = 0;
        var _loc5_:GeoSceneObject = null;
        var _loc6_:BuildingLevelInfo = null;
        var _loc2_:int = 0;
        var _loc4_:Array = this.getBuildingsWithLimitBonuses();
        for each(_loc5_ in _loc4_) {
            _loc3_ = _loc5_.getLevel();
            if (!(_loc3_ <= 0 || _loc5_.objectType.buildingInfo.levelInfos.length == 0)) {
                _loc6_ = _loc5_.objectType.buildingInfo.getLevelInfo(_loc3_);
                if (_loc6_ != null && _loc6_.buildingsLimitBonus != null && param1 in _loc6_.buildingsLimitBonus) {
                    _loc2_ = _loc2_ + _loc6_.buildingsLimitBonus[param1];
                }
            }
        }
        return _loc2_;
    }

    private function getBuildingsWithLimitBonuses():Array {
        var _loc3_:GeoSceneObject = null;
        var _loc1_:int = this.sectorScene.sceneObjects.length;
        var _loc2_:Array = [];
        var _loc4_:int = 0;
        while (_loc4_ < _loc1_) {
            _loc3_ = this.sectorScene.sceneObjects[_loc4_] as GeoSceneObject;
            if (_loc3_ != null) {
                if (BUILDINGS_WITH_LIMIT_BONUSES.indexOf(_loc3_.objectType.id) != -1) {
                    _loc2_.push(_loc3_);
                    break;
                }
            }
            _loc4_++;
        }
        return _loc2_;
    }

    public function getPaidResurrectionBonusPercents():Number {
        var _loc2_:SceneObject = null;
        var _loc3_:GeoSceneObject = null;
        var _loc4_:int = 0;
        var _loc5_:BuildingLevelInfo = null;
        var _loc1_:Number = 0;
        for each(_loc2_ in this.sectorScene.sceneObjects) {
            _loc3_ = _loc2_ as GeoSceneObject;
            if (_loc3_ != null) {
                _loc4_ = _loc3_.getLevel();
                if (_loc4_ > 0 && _loc3_.objectType.buildingInfo.levelInfos.length > 0) {
                    _loc5_ = _loc3_.objectType.buildingInfo.getLevelInfo(_loc4_);
                    if (_loc5_ != null && !isNaN(_loc5_.paidResurrectionBonusPercents) && _loc5_.paidResurrectionBonusPercents > 0) {
                        _loc1_ = _loc1_ + _loc5_.paidResurrectionBonusPercents;
                    }
                }
            }
        }
        return _loc1_;
    }

    public function hasMoveTroopsToBunkerBonus(param1:int):Boolean {
        var _loc2_:Boolean = false;
        var _loc3_:SceneObject = null;
        var _loc4_:GeoSceneObject = null;
        var _loc5_:int = 0;
        var _loc6_:BuildingLevelInfo = null;
        for each(_loc3_ in this.sectorScene.sceneObjects) {
            _loc4_ = _loc3_ as GeoSceneObject;
            if (_loc4_ != null) {
                _loc5_ = _loc4_.getLevel();
                if (_loc5_ > 0 && _loc4_.objectType.buildingInfo.levelInfos.length > 0) {
                    _loc6_ = _loc4_.objectType.buildingInfo.getLevelInfo(_loc5_);
                    if (_loc6_ != null && _loc6_.troopsMoveToBunker != null) {
                        _loc2_ = query(_loc6_.troopsMoveToBunker).contains(TroopsGroupId.ToRegularGroupId(param1));
                    }
                }
            }
        }
        return _loc2_;
    }

    public function pseudoActiveBuildings(param1:int):Boolean {
        switch (param1) {
            case BuildingTypeId.Senate:
            case BuildingTypeId.IndustrialSyndicate:
            case BuildingTypeId.ChamberOfCommerce:
            case BuildingTypeId.TransportService:
            case BuildingTypeId.TradeGate:
                return true;
            default:
                return false;
        }
    }

    public function getBuilding(param1:Number):GeoSceneObject {
        var _loc2_:GeoSceneObject = null;
        for each(_loc2_ in this.sectorScene.sceneObjects) {
            if (_loc2_.id == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public function getBuildingByType(param1:Number):GeoSceneObject {
        var _loc2_:GeoSceneObject = null;
        for each(_loc2_ in this.sectorScene.sceneObjects) {
            if (_loc2_.type.id == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public function getCountRequiredBuildings(param1:GeoSceneObject):int {
        var _loc4_:int = 0;
        var _loc5_:RequiredObject = null;
        var _loc6_:Array = null;
        var _loc7_:int = 0;
        var _loc8_:GeoSceneObject = null;
        var _loc2_:int = 0;
        var _loc3_:SaleableLevelInfo = param1.getSaleableLevelInfo();
        if (_loc3_ && _loc3_.requiredObjects) {
            _loc4_ = 0;
            while (_loc4_ < _loc3_.requiredObjects.length) {
                _loc5_ = _loc3_.requiredObjects[_loc4_] as RequiredObject;
                _loc6_ = UserManager.user.gameData.sector.getBuildings(_loc5_.typeId);
                if (_loc6_.length == 0) {
                    _loc2_ = _loc2_ + _loc5_.count;
                }
                else {
                    _loc7_ = 0;
                    while (_loc7_ < _loc6_.length) {
                        _loc8_ = _loc6_[_loc7_];
                        if (_loc8_.constructionInfo.level < _loc5_.level) {
                            _loc2_++;
                        }
                        _loc7_++;
                    }
                    if (_loc6_.length < _loc5_.count) {
                        _loc2_ = _loc2_ + (_loc5_.count - _loc6_.length);
                    }
                }
                _loc4_++;
            }
        }
        return _loc2_;
    }

    public function getBuildings(param1:int, param2:int = 0):Array {
        var _loc4_:GeoSceneObject = null;
        var _loc3_:Array = [];
        for each(_loc4_ in this.sectorScene.sceneObjects) {
            if (_loc4_.type.id == param1 && _loc4_.getLevel() >= param2) {
                _loc3_.push(_loc4_);
            }
        }
        return _loc3_;
    }

    public function getBuildingsCount(param1:int, param2:int = 0):int {
        if (param2 > 0) {
            return this.getBuildings(param1, param2).length;
        }
        if (this.buildingsCountByTypeId[param1] == 0) {
            return 0;
        }
        return this.buildingsCountByTypeId[param1];
    }

    public function hasAnyBuilding(param1:Array, param2:GeoSceneObject = null):Boolean {
        var _loc3_:GeoSceneObject = null;
        for each(_loc3_ in this.sectorScene.sceneObjects) {
            if ((param2 == null || param2.id != _loc3_.id) && param1.indexOf(_loc3_.type.id) != -1) {
                return true;
            }
        }
        return false;
    }

    public function getWalls():Array {
        var _loc2_:GeoSceneObject = null;
        var _loc1_:Array = [];
        for each(_loc2_ in this.sectorScene.sceneObjects) {
            if (_loc2_.objectType.isPerimeter && _loc2_.objectType.isDefensiveKind(DefensiveKind.WALL)) {
                _loc1_.push(_loc2_);
            }
        }
        return _loc1_;
    }

    public function getTowers():Array {
        var _loc2_:GeoSceneObject = null;
        var _loc1_:Array = [];
        for each(_loc2_ in this.sectorScene.sceneObjects) {
            if (_loc2_.objectType.isPerimeter && _loc2_.objectType.isDefensiveKind(DefensiveKind.TOWER)) {
                _loc1_.push(_loc2_);
            }
        }
        return _loc1_;
    }

    public function getCountTowers():int {
        var _loc2_:GeoSceneObject = null;
        var _loc1_:int = 0;
        for each(_loc2_ in this.sectorScene.sceneObjects) {
            if (BuildingTypeId.BUILDING_IDS_TURRETS.indexOf(_loc2_.objectType.id) != -1) {
                _loc1_++;
            }
        }
        return _loc1_;
    }

    public function getGates():Array {
        var _loc2_:GeoSceneObject = null;
        var _loc1_:Array = [];
        for each(_loc2_ in this.sectorScene.sceneObjects) {
            if (_loc2_.objectType.buildingInfo.groupId == BuildingGroupId.DEFENSIVE && _loc2_.objectType.buildingInfo.defensiveKind == DefensiveKind.GATE) {
                _loc1_.push(_loc2_);
            }
        }
        return _loc1_;
    }

    public function getDefenseObjects():Array {
        var _loc2_:GeoSceneObject = null;
        var _loc1_:Array = [];
        for each(_loc2_ in this.sectorScene.sceneObjects) {
            if (_loc2_.objectType && _loc2_.objectType.isDecorForWalls && _loc2_.objectType.isTurret) {
                _loc1_.push(_loc2_);
            }
        }
        return _loc1_;
    }

    public function hasDefensiveBuilding(param1:int, param2:GeoSceneObject = null):Boolean {
        var _loc3_:GeoSceneObject = null;
        for each(_loc3_ in this.sectorScene.sceneObjects) {
            if (_loc3_.objectType && _loc3_.objectType.isPerimeter && _loc3_.objectType.isDefensiveKind(param1) && (param2 == null || param2.id != _loc3_.id)) {
                return true;
            }
        }
        return false;
    }

    public function hasRobotBuilding():Boolean {
        var _loc2_:GeoSceneObject = null;
        var _loc1_:Boolean = false;
        for each(_loc2_ in this.sectorScene.sceneObjects) {
            if (_loc2_.objectType.isRobot) {
                _loc1_ = true;
                break;
            }
        }
        return _loc1_;
    }

    public function hasOutsideRobotBuilding():Boolean {
        var _loc2_:GeoSceneObject = null;
        var _loc1_:Boolean = false;
        for each(_loc2_ in this.sectorScene.sceneObjects) {
            if (this.isOutsideRobotBuilding(_loc2_.objectType.id)) {
                _loc1_ = true;
                break;
            }
        }
        return _loc1_;
    }

    private function isOutsideRobotBuilding(param1:int):Boolean {
        return param1 == BuildingTypeId.Robot1 || param1 == BuildingTypeId.Robot2 || param1 == BuildingTypeId.Robot3 || param1 == BuildingTypeId.Robot4 || param1 == BuildingTypeId.Robot5 || param1 == BuildingTypeId.Robot6 || param1 == BuildingTypeId.Robot7;
    }

    public function hasDecorForSectorBuilding(param1:int, param2:GeoSceneObject = null):Boolean {
        var _loc3_:GeoSceneObject = null;
        for each(_loc3_ in this.sectorScene.sceneObjects) {
            if (_loc3_.objectType.buildingInfo.groupId == BuildingGroupId.DECOR_FOR_SECTOR && _loc3_.objectType.buildingInfo.defensiveKind == param1 && (param2 == null || param2.id != _loc3_.id)) {
                return true;
            }
        }
        return false;
    }

    public function hasDecorForSectorAndWallsBuilding(param1:int, param2:GeoSceneObject = null):Boolean {
        var _loc3_:GeoSceneObject = null;
        for each(_loc3_ in this.sectorScene.sceneObjects) {
            if (_loc3_.objectType.buildingInfo.groupId == BuildingGroupId.DECOR_FOR_SECTOR_AND_WALLS && _loc3_.objectType.buildingInfo.defensiveKind == param1 && (param2 == null || param2.id != _loc3_.id)) {
                return true;
            }
        }
        return false;
    }

    public function markBuildingDeletedByUser(param1:int):void {
        if (this.buildingsDeletedByUserTypeIds == null) {
            this.buildingsDeletedByUserTypeIds = new ArrayCustom();
        }
        if (!this.buildingsDeletedByUserTypeIds.contains(param1)) {
            this.buildingsDeletedByUserTypeIds.addItem(param1);
        }
    }

    public function getMaxDefenseObjectsAllowed():int {
        return this.gatesCount * StaticDataManager.DefenseObjectsPerGates + this.towersCount;
    }

    public function getCyborgsPerDay():int {
        var _loc2_:GeoSceneObject = null;
        var _loc3_:GeoSceneObjectType = null;
        var _loc4_:int = 0;
        var _loc1_:int = 0;
        for each(_loc2_ in this.sectorScene.sceneObjects) {
            _loc3_ = _loc2_.objectType;
            _loc4_ = _loc2_.getLevel() - 1;
            if (_loc3_.buildingInfo != null && _loc2_.getLevel() > 0 && _loc2_.getLevel() <= _loc3_.buildingInfo.levelInfos.length) {
                if (_loc4_ >= 0) {
                    _loc1_ = _loc1_ + (_loc3_.buildingInfo.levelInfos[_loc4_] as BuildingLevelInfo).cyborgsPerDay;
                }
            }
        }
        return _loc1_;
    }

    public function getNextEvent(param1:User, param2:Date):INEvent {
        var _loc3_:* = this.getNextFinishedBuilding(param2);
        var _loc4_:GeoSceneObject = _loc3_.building;
        param2 = _loc3_.time;
        return _loc4_ == null ? null : new NEventBuildingFinished(_loc4_, param2);
    }

    private function getNextFinishedBuilding(param1:Date):* {
        var _loc4_:GeoSceneObject = null;
        var _loc5_:Date = null;
        var _loc2_:GeoSceneObject = null;
        var _loc3_:Date = new Date(param1);
        for each(_loc4_ in this.sectorScene.sceneObjects) {
            if (!(_loc4_.buildingInfo == null || _loc4_.constructionInfo.canceling)) {
                _loc5_ = getBuildingFinishedTime(_loc4_, _loc3_);
                if (!(_loc5_ == null || _loc5_ > param1)) {
                    _loc2_ = _loc4_;
                    param1 = _loc5_;
                }
            }
        }
        return {
            "building": _loc2_,
            "time": param1
        };
    }

    public function dispatchEvents():void {
        this.sectorScene.dispatchEvents();
        this.warcampScene.dispatchEvents();
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.name,
            "n": this.nextObjectId,
            "s": this.sectorScene.toDto(),
            "w": this.warcampScene.toDto()
        };
        return _loc1_;
    }

    public function get slots():ArrayCustom {
        return this._slots;
    }

    private function setSlots(param1:*):void {
        if (param1) {
            this._slots = new ArrayCustom(param1);
            dispatchEvent(SLOTS_CHANGED);
        }
    }

    public function get totalBoughtExtensionPacks():int {
        return this._totalBoughtExtensionPacks;
    }

    private function setTotalBoughtExtensionPacks(param1:int):void {
        if (param1 != -1) {
            this._totalBoughtExtensionPacks = param1;
        }
    }

    public function updateSlots(param1:Array):void {
        this._slots.addAll(new ArrayCustom(param1));
        this._totalBoughtExtensionPacks++;
        dispatchEvent(SLOTS_CHANGED);
    }

    public function getSectorDefence(param1:int = -1):int {
        var _loc3_:GeoSceneObject = null;
        var _loc4_:GeoSceneObjectType = null;
        var _loc5_:int = 0;
        var _loc2_:int = 0;
        for each(_loc3_ in this.sectorScene.sceneObjects) {
            _loc4_ = _loc3_.type as GeoSceneObjectType;
            if (!(_loc3_.constructionInfo.level == 0 || param1 != _loc4_.buildingInfo.slotKindId)) {
                _loc5_ = _loc4_.buildingInfo.getLevelInfo(_loc3_.constructionInfo.level).defenceBonusPoints;
                if (_loc5_ != 0) {
                    _loc2_ = _loc2_ + _loc5_;
                }
            }
        }
        return _loc2_;
    }
}
}
