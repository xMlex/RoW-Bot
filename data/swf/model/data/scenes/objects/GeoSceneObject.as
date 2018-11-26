package model.data.scenes.objects {
import common.ArrayCustom;
import common.GameType;

import gameObjects.sceneObject.SceneObject;
import gameObjects.sceneObject.SceneObjectType;

import model.data.Resources;
import model.data.inventory.InventoryItemObjInfo;
import model.data.normalization.INConstructible;
import model.data.scenes.objects.info.ArtifactObjInfo;
import model.data.scenes.objects.info.BuildingObjInfo;
import model.data.scenes.objects.info.ConstructionObjInfo;
import model.data.scenes.objects.info.DrawingObjInfo;
import model.data.scenes.objects.info.GemObjInfo;
import model.data.scenes.objects.info.GraphicsObjInfo;
import model.data.scenes.objects.info.TechnologyObjInfo;
import model.data.scenes.objects.info.TroopsObjInfo;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.BuildingLevelInfo;
import model.data.scenes.types.info.DefensiveKind;
import model.data.scenes.types.info.RequiredObject;
import model.data.scenes.types.info.SaleableLevelInfo;
import model.data.scenes.types.info.SaleableTypeInfo;
import model.data.users.BuyStatus;
import model.logic.StaticDataManager;
import model.logic.inventory.InventoryManager;
import model.logic.inventory.TroopsGroupBonus;
import model.logic.slots.SectorSlotsManager;
import model.logic.slots.SlotData;

public class GeoSceneObject extends SceneObject implements INConstructible {

    public static const CLASS_NAME:String = "GeoSceneObject";

    public static const STATUS_UPDATED:String = CLASS_NAME + "StatusUpdated";

    public static const BUILDING_FINISHED:String = CLASS_NAME + "BuildingFinished";


    public var buildingInfo:BuildingObjInfo;

    public var troopsInfo:TroopsObjInfo;

    public var technologyInfo:TechnologyObjInfo;

    public var drawingInfo:DrawingObjInfo;

    public var artifactInfo:ArtifactObjInfo;

    public var gemInfo:GemObjInfo;

    public var constructionInfo:ConstructionObjInfo;

    public var inventoryItemInfo:InventoryItemObjInfo;

    private var _slotId:int;

    public var oldLinkedObjects:ArrayCustom;

    public var _dirtyNormalized:Boolean;

    public var buyStatus:int;

    private var _missingObjects:ArrayCustom;

    private var _missingResources:Resources;

    public function GeoSceneObject(param1:int, param2:SceneObjectType, param3:int, param4:int, param5:Boolean) {
        super(param1, param2, param3, param4, param5);
    }

    private static function objectCollectionsAreDifferent(param1:ArrayCustom, param2:ArrayCustom):Boolean {
        if (param1 == null && param2 != null) {
            return true;
        }
        if (param2 == null && param1 != null) {
            return true;
        }
        if (param1.length != param2.length) {
            return true;
        }
        var _loc3_:int = 0;
        while (_loc3_ < param1.length) {
            if (param1[_loc3_].typeId != param2[_loc3_].typeId || param1[_loc3_].level != param2[_loc3_].level) {
                return true;
            }
            _loc3_++;
        }
        return false;
    }

    public static function makeBuyingBuilding(param1:SceneObjectType, param2:int, param3:int, param4:Boolean, param5:int = -1):GeoSceneObject {
        var _loc6_:GeoSceneObject = new GeoSceneObject(param5, param1, param2, param3, param4);
        _loc6_.buildingInfo = new BuildingObjInfo();
        if ((param1 as GeoSceneObjectType).buildingInfo && (param1 as GeoSceneObjectType).buildingInfo.canBeBroken) {
            _loc6_.buildingInfo.broken = false;
            _loc6_.buildingInfo.canBeBroken = true;
        }
        _loc6_.constructionInfo = new ConstructionObjInfo();
        _loc6_.constructionInfo.level = 0;
        return _loc6_;
    }

    public static function makeByingTechnology(param1:SceneObjectType):GeoSceneObject {
        var _loc2_:GeoSceneObject = new GeoSceneObject(-1, param1, 0, 0, false);
        _loc2_.technologyInfo = new TechnologyObjInfo();
        _loc2_.constructionInfo = new ConstructionObjInfo();
        _loc2_.constructionInfo.level = 0;
        return _loc2_;
    }

    public static function makeBuyingTroops(param1:SceneObjectType, param2:int):GeoSceneObject {
        var _loc3_:GeoSceneObject = new GeoSceneObject(-1, param1, 0, 0, false);
        _loc3_.constructionInfo = new ConstructionObjInfo();
        _loc3_.constructionInfo.level = 0;
        _loc3_.troopsInfo = new TroopsObjInfo();
        _loc3_.troopsInfo.count = param2;
        return _loc3_;
    }

    public static function makeDrawing(param1:SceneObjectType):GeoSceneObject {
        var _loc2_:GeoSceneObject = new GeoSceneObject(-1, param1, 0, 0, false);
        _loc2_.drawingInfo = new DrawingObjInfo();
        _loc2_.drawingInfo.drawingParts = [];
        var _loc3_:int = 0;
        while (_loc3_ < (param1 as GeoSceneObjectType).drawingInfo.partsCount) {
            _loc2_.drawingInfo.drawingParts.push(0);
            _loc3_++;
        }
        return _loc2_;
    }

    public static function fromDto(param1:*):GeoSceneObject {
        var _loc2_:int = param1.i;
        var _loc3_:int = param1.t;
        var _loc4_:GraphicsObjInfo = GraphicsObjInfo.fromDto(param1.gi);
        var _loc5_:GeoSceneObjectType = StaticDataManager.getObjectType(_loc3_);
        var _loc6_:SlotData = null;
        if (GameType.isSparta || GameType.isNords) {
            if (_loc4_) {
                _loc6_ = SectorSlotsManager.instance.getSlotById(_loc4_.slotId);
                if (_loc6_) {
                    _loc4_.x = _loc6_.x;
                    _loc4_.y = _loc6_.y;
                }
            }
        }
        var _loc7_:GeoSceneObject = new GeoSceneObject(_loc2_, _loc5_, _loc4_ == null ? 0 : int(_loc4_.x), _loc4_ == null ? 0 : int(_loc4_.y), _loc4_ == null ? Boolean(0) : Boolean(_loc4_.isMirrored));
        if (_loc6_) {
            _loc7_.slotId = _loc4_.slotId;
            _loc6_.gso = _loc7_;
        }
        _loc7_.buildingInfo = BuildingObjInfo.fromDto(param1.bi);
        _loc7_.troopsInfo = TroopsObjInfo.fromDto(param1.ti);
        _loc7_.technologyInfo = TechnologyObjInfo.fromDto(param1.tci);
        _loc7_.drawingInfo = DrawingObjInfo.fromDto(param1.d);
        _loc7_.artifactInfo = ArtifactObjInfo.fromDto(param1.a);
        _loc7_.gemInfo = GemObjInfo.fromDto(param1.ge);
        _loc7_.constructionInfo = param1.c == null ? null : ConstructionObjInfo.fromDto(param1.c);
        _loc7_.inventoryItemInfo = InventoryItemObjInfo.fromDto(param1.ri);
        return _loc7_;
    }

    public static function fromDtos(param1:*):Vector.<SceneObject> {
        var _loc3_:* = undefined;
        var _loc2_:Vector.<SceneObject> = new Vector.<SceneObject>();
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function fromDtos2(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function toDtos(param1:Vector.<SceneObject>):Array {
        var _loc3_:GeoSceneObject = null;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function get isRoad():Boolean {
        return this.objectType != null && this.objectType.buildingInfo != null && this.objectType.buildingInfo.defensiveKind == DefensiveKind.ROAD;
    }

    public function get dirtyNormalized():Boolean {
        return this._dirtyNormalized;
    }

    public function set dirtyNormalized(param1:Boolean):void {
        this._dirtyNormalized = param1;
    }

    public function get missingObjects():ArrayCustom {
        return this._missingObjects;
    }

    public function set missingObjects(param1:ArrayCustom):void {
        if (this.missingObjects == null && param1 == null) {
            return;
        }
        if (this.missingObjects == param1) {
            return;
        }
        if (objectCollectionsAreDifferent(this._missingObjects, param1)) {
            this._missingObjects = param1;
            this.dirtyNormalized = true;
        }
    }

    public function get missingBuildings():Array {
        var _loc3_:RequiredObject = null;
        var _loc1_:ArrayCustom = this.missingObjects;
        if (_loc1_ == null) {
            return null;
        }
        var _loc2_:Array = [];
        for each(_loc3_ in _loc1_) {
            if (_loc3_.type.buildingInfo != null) {
                _loc2_.push(_loc3_);
            }
        }
        return _loc2_.length == 0 ? null : _loc2_;
    }

    public function get missingTechnologies():Array {
        var _loc3_:RequiredObject = null;
        var _loc1_:ArrayCustom = this.missingObjects;
        if (_loc1_ == null) {
            return null;
        }
        var _loc2_:Array = [];
        for each(_loc3_ in _loc1_) {
            if (_loc3_.type.technologyInfo != null) {
                _loc2_.push(_loc3_);
            }
        }
        return _loc2_.length == 0 ? null : _loc2_;
    }

    public function get missingDrawing():RequiredObject {
        var _loc2_:RequiredObject = null;
        var _loc1_:ArrayCustom = this.missingObjects;
        if (_loc1_ == null) {
            return null;
        }
        for each(_loc2_ in _loc1_) {
            if (_loc2_.type.drawingInfo != null) {
                return _loc2_;
            }
        }
        return null;
    }

    public function get missingResources():Resources {
        return this._missingResources;
    }

    public function set missingResources(param1:Resources):void {
        if (param1 == this._missingResources) {
            return;
        }
        if (param1 != null && this._missingResources != null && this._missingResources.equals(param1)) {
            return;
        }
        this._missingResources = param1;
        this.dirtyNormalized = true;
    }

    public function get buyAllowed():Boolean {
        return this.buyStatus == BuyStatus.OBJECT_CAN_BE_BOUGHT;
    }

    public function get isMaxLevel():Boolean {
        return this.getLevel() == this.getMaxLevel();
    }

    override public function getLevel():int {
        if (this.drawingInfo != null) {
            return !!this.drawingInfo.isCollected() ? 1 : 0;
        }
        return this.constructionInfo != null ? int(this.constructionInfo.level) : 0;
    }

    public function getMaxLevel():int {
        var _loc1_:SaleableTypeInfo = this.objectType.saleableInfo;
        return _loc1_ == null ? 0 : int(_loc1_.levelsCount);
    }

    public function getLevelString():String {
        return this.getLevel() + "/" + this.getMaxLevel();
    }

    public function getSaleableLevelInfo():SaleableLevelInfo {
        var _loc1_:int = this.troopsInfo == null ? int(this.getLevel() + 1) : 1;
        var _loc2_:SaleableTypeInfo = !!this.objectType ? this.objectType.saleableInfo : null;
        if (_loc2_ == null || _loc1_ > _loc2_.levelsCount) {
            return null;
        }
        return _loc2_.getLevelInfo(_loc1_);
    }

    public function getNextLevel():int {
        var _loc1_:int = this.troopsInfo == null ? int(this.getLevel() + 1) : 1;
        var _loc2_:SaleableTypeInfo = this.objectType.saleableInfo;
        if (_loc2_ == null || _loc1_ > _loc2_.levelsCount) {
            return -1;
        }
        return _loc1_;
    }

    public function getRequiredObjects():ArrayCustom {
        var _loc1_:int = this.troopsInfo == null ? int(this.getLevel()) : 0;
        var _loc2_:SaleableTypeInfo = this.objectType.saleableInfo;
        if (_loc1_ != 0 || _loc2_ == null) {
            return null;
        }
        return _loc2_.requiredObjects;
    }

    public function getProgress():Number {
        return this.constructionInfo.progressPercentage;
    }

    public function get buildingInProgress():Boolean {
        return this.constructionInfo != null && this.constructionInfo.constructionStartTime != null;
    }

    public function get isBuying():Boolean {
        return id < 0;
    }

    public function getBuildingLevelInfo():BuildingLevelInfo {
        return this.buildingInfo == null ? null : this.objectType.buildingInfo.getLevelInfo(this.constructionObjInfo.level);
    }

    public function dispatchEvents():void {
        if (!this.dirtyNormalized) {
            return;
        }
        this.dirtyNormalized = false;
        dispatchEvent(STATUS_UPDATED);
    }

    public function get objectType():GeoSceneObjectType {
        return type as GeoSceneObjectType;
    }

    public function set objectType(param1:GeoSceneObjectType):void {
        type = param1;
    }

    public function get constructionObjInfo():ConstructionObjInfo {
        return this.constructionInfo;
    }

    public function set constructionObjInfo(param1:ConstructionObjInfo):void {
        this.constructionInfo = param1;
    }

    override public function get isBroken():Boolean {
        return this.buildingInfo && this.buildingInfo.broken;
    }

    public function toDto():* {
        var _loc1_:GraphicsObjInfo = this.createGraphicsObj(column, row, isMirrored);
        var _loc2_:* = {
            "i": id,
            "t": type.id,
            "gi": (_loc1_ == null ? null : _loc1_.toDto()),
            "bi": (this.buildingInfo == null ? null : this.buildingInfo.toDto()),
            "ti": (this.troopsInfo == null ? null : this.troopsInfo.toDto()),
            "tci": (this.technologyInfo == null ? null : this.technologyInfo.toDto()),
            "d": (this.drawingInfo == null ? null : this.drawingInfo.toDto()),
            "c": (this.constructionInfo == null ? null : this.constructionInfo.toDto())
        };
        return _loc2_;
    }

    protected function createGraphicsObj(param1:int, param2:int, param3:Boolean):GraphicsObjInfo {
        var _loc4_:GraphicsObjInfo = new GraphicsObjInfo();
        _loc4_.x = param1;
        _loc4_.y = param2;
        _loc4_.isMirrored = param3;
        if (GameType.isSparta || GameType.isNords) {
            _loc4_.slotId = this.slotId;
        }
        return _loc4_;
    }

    public function get slotId():int {
        return this._slotId;
    }

    public function set slotId(param1:int):void {
        this._slotId = param1;
    }

    public function get troopsGroupBonus():TroopsGroupBonus {
        return InventoryManager.instance.getInventoryItemBonus(this);
    }

    public function clone():GeoSceneObject {
        var _loc1_:GeoSceneObject = new GeoSceneObject(id, type, column, row, isMirrored);
        _loc1_.slotId = this._slotId;
        _loc1_.buildingInfo = this.buildingInfo;
        _loc1_.troopsInfo = this.troopsInfo;
        _loc1_.technologyInfo = this.technologyInfo;
        _loc1_.drawingInfo = this.drawingInfo;
        _loc1_.artifactInfo = this.artifactInfo;
        _loc1_.gemInfo = this.gemInfo;
        if (this.constructionInfo != null) {
            _loc1_.constructionInfo = this.constructionInfo.clone();
        }
        _loc1_.inventoryItemInfo = this.inventoryItemInfo;
        return _loc1_;
    }

    override public function dispose():void {
        super.dispose();
        this._missingObjects = null;
        this._missingResources = null;
        this._slotId = 0;
        this.artifactInfo = null;
        this.buildingInfo = null;
        this.buyStatus = 0;
        this.constructionInfo = null;
        this.dirtyNormalized = false;
        this.drawingInfo = null;
        this.gemInfo = null;
        this.inventoryItemInfo = null;
        this.oldLinkedObjects = null;
        this.technologyInfo = null;
        this.troopsInfo = null;
    }
}
}
