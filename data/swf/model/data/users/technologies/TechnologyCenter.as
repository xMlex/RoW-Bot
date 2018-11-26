package model.data.users.technologies {
import common.ArrayCustom;
import common.GameType;

import gameObjects.observableObject.ObservableObject;
import gameObjects.sceneObject.SceneObject;
import gameObjects.sceneObject.SceneObjectType;

import model.data.LocationTypeId;
import model.data.Resources;
import model.data.User;
import model.data.normalization.INEvent;
import model.data.normalization.INormalizable;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.RequiredObject;
import model.data.scenes.types.info.TechnologyLevelInfo;
import model.data.scenes.types.info.TechnologyTypeId;
import model.data.scenes.types.info.TechnologyTypeInfo;
import model.data.scenes.types.info.TroopsTypeId;
import model.data.users.technologies.models.UnitTechnologyData;
import model.logic.StaticDataManager;

public class TechnologyCenter extends ObservableObject implements INormalizable {

    public static const CLASS_NAME:String = "TechnologyCenter";

    public static const TECHNOLOGIES_CHANGED:String = CLASS_NAME + "TechnologiesChanged";

    public static const TECHNOLOGY_RESEARCHED:String = CLASS_NAME + "TechnologyResearched";


    public var technologies:Vector.<SceneObject>;

    private var _technologyByType:Object;

    public var researchedTechnologiesCount:int = 0;

    public var drawingPartCount:int = 0;

    public var technologiesResearching:int = 0;

    public function TechnologyCenter() {
        super();
    }

    public static function technologyRequiresDrawings(param1:GeoSceneObjectType):Boolean {
        var _loc2_:RequiredObject = null;
        var _loc3_:GeoSceneObjectType = null;
        if (param1.technologyInfo == null || param1.saleableInfo == null) {
            return false;
        }
        for each(_loc2_ in param1.saleableInfo.requiredObjects) {
            _loc3_ = StaticDataManager.getObjectType(_loc2_.typeId);
            if (_loc3_.drawingInfo != null) {
                return true;
            }
        }
        return false;
    }

    private static function getResearchFinishedTime(param1:GeoSceneObject, param2:Date):Date {
        if (param1.constructionObjInfo.constructionStartTime == null || param1.constructionInfo.canceling == true) {
            return null;
        }
        param1.constructionObjInfo.updatePercentage(param2);
        param1.dirtyNormalized = true;
        return param1.constructionObjInfo.constructionFinishTime;
    }

    public static function fromDto(param1:*):TechnologyCenter {
        var _loc3_:GeoSceneObjectType = null;
        var _loc2_:TechnologyCenter = new TechnologyCenter();
        _loc2_.setTechnologies(GeoSceneObject.fromDtos(param1.tl));
        for each(_loc3_ in StaticDataManager.types) {
            if (_loc3_.technologyInfo != null) {
                if (_loc2_.getTechnology(_loc3_.id) == null) {
                    _loc2_.addTechnology(GeoSceneObject.makeByingTechnology(_loc3_));
                }
            }
        }
        return _loc2_;
    }

    private function setTechnologies(param1:Vector.<SceneObject>):void {
        var _loc2_:GeoSceneObject = null;
        this.technologies = param1;
        this._technologyByType = {};
        for each(_loc2_ in param1) {
            this._technologyByType[_loc2_.objectType.id] = _loc2_;
        }
    }

    public function raiseTechnologyResearched(param1:int):void {
        var _loc2_:TechnologyResearchedEvent = new TechnologyResearchedEvent(TECHNOLOGY_RESEARCHED, this, param1);
        dispatch(_loc2_);
    }

    public function recalcTechnologies():void {
        var _loc5_:GeoSceneObject = null;
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc4_:Boolean = false;
        for each(_loc5_ in this.technologies) {
            if (_loc5_.buildingInProgress) {
                _loc3_++;
            }
            if (_loc5_.getLevel() > 0) {
                _loc1_++;
            }
            if (_loc5_.drawingInfo != null && _loc5_.drawingInfo.drawingParts != null) {
                _loc2_ = _loc2_ + _loc5_.drawingInfo.drawingParts.length;
            }
        }
        if (this.technologiesResearching != _loc3_) {
            this.technologiesResearching = _loc3_;
            _loc4_ = true;
        }
        if (this.researchedTechnologiesCount != _loc1_) {
            this.researchedTechnologiesCount = _loc1_;
            _loc4_ = true;
        }
        if (this.drawingPartCount != _loc2_) {
            this.drawingPartCount = _loc2_;
            _loc4_ = true;
        }
        if (_loc4_) {
            dispatchEvent(TECHNOLOGIES_CHANGED);
        }
    }

    public function dispatchEvents():void {
        var _loc1_:GeoSceneObject = null;
        for each(_loc1_ in this.technologies) {
            _loc1_.dispatchEvents();
        }
    }

    public function addTechnology(param1:GeoSceneObject):void {
        if (this.getTechnology(param1.objectType.id) != null) {
            throw new Error("Technology is already added");
        }
        this.technologies.push(param1);
        this._technologyByType[param1.objectType.id] = param1;
    }

    public function setLevelTechnology(param1:int, param2:int):void {
        var _loc4_:SceneObjectType = null;
        var _loc3_:GeoSceneObject = this.getTechnology(param1);
        if (_loc3_ == null) {
            _loc4_ = StaticDataManager.getObjectType(TechnologyTypeId.TechMicroroboticDrill);
            _loc3_ = GeoSceneObject.makeByingTechnology(_loc4_);
            this.addTechnology(_loc3_);
        }
        _loc3_.constructionInfo.level = param2;
    }

    public function getTechnology(param1:int):GeoSceneObject {
        return this._technologyByType[param1];
    }

    public function hasActiveTechnology(param1:int, param2:int):Boolean {
        var _loc3_:GeoSceneObject = this.getTechnology(param1);
        return _loc3_ != null && _loc3_.constructionObjInfo.level >= param2;
    }

    public function getNextEvent(param1:User, param2:Date):INEvent {
        var _loc3_:* = this.GetNextResearchedTechnology(param2);
        var _loc4_:GeoSceneObject = _loc3_.technology;
        param2 = _loc3_.time;
        return _loc4_ == null ? null : new NEventTechnologyFinished(_loc4_, param2);
    }

    private function GetNextResearchedTechnology(param1:Date):* {
        var _loc2_:GeoSceneObject = null;
        var _loc4_:GeoSceneObject = null;
        var _loc5_:Date = null;
        var _loc3_:Date = new Date(param1);
        for each(_loc4_ in this.technologies) {
            _loc5_ = getResearchFinishedTime(_loc4_, _loc3_);
            if (!(_loc5_ == null || _loc5_ > param1)) {
                _loc2_ = _loc4_;
                param1 = _loc5_;
            }
        }
        return {
            "technology": _loc2_,
            "time": param1
        };
    }

    public function GetNearestUnlearnedTechnologiesWithDrawings():ArrayCustom {
        var _loc2_:GeoSceneObject = null;
        var _loc3_:Boolean = false;
        var _loc4_:ArrayCustom = null;
        var _loc5_:GeoSceneObjectType = null;
        var _loc6_:GeoSceneObject = null;
        var _loc1_:ArrayCustom = new ArrayCustom();
        for each(_loc2_ in this.technologies) {
            if (!(_loc2_.getLevel() > 0 || _loc2_.buildingInProgress || !technologyRequiresDrawings(_loc2_.objectType))) {
                _loc3_ = true;
                _loc4_ = this.GetPrecedingTechnologies(_loc2_.objectType);
                for each(_loc5_ in _loc4_) {
                    _loc6_ = this.getTechnology(_loc5_.id);
                    if (technologyRequiresDrawings(_loc5_) && (_loc6_.getLevel() == 0 && _loc6_.buildingInProgress == false)) {
                        _loc3_ = false;
                        break;
                    }
                }
                if (_loc3_) {
                    _loc1_.addItem(_loc2_.objectType);
                }
            }
        }
        return _loc1_;
    }

    public function GetPrecedingTechnologies(param1:GeoSceneObjectType):ArrayCustom {
        var _loc3_:RequiredObject = null;
        var _loc4_:GeoSceneObjectType = null;
        var _loc5_:ArrayCustom = null;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1.saleableInfo.requiredObjects) {
            _loc4_ = StaticDataManager.getObjectType(_loc3_.typeId);
            if (_loc4_.technologyInfo != null && _loc4_.saleableInfo != null) {
                _loc2_.addItem(_loc4_);
                _loc5_ = this.GetPrecedingTechnologies(_loc4_);
                _loc2_.addAll(_loc5_);
            }
        }
        return _loc2_;
    }

    public function getLevelForTroops(param1:GeoSceneObjectType):UnitTechnologyData {
        var _loc3_:GeoSceneObject = null;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:TechnologyTypeInfo = null;
        var _loc7_:Array = null;
        var _loc8_:int = 0;
        var _loc2_:UnitTechnologyData = new UnitTechnologyData();
        for each(_loc3_ in this.technologies) {
            _loc4_ = _loc3_.getLevel();
            _loc5_ = (GameType.isMilitary || GameType.isSparta) && param1.isMutant ? int(TroopsTypeId.ToRegular(param1.id)) : int(param1.id);
            _loc6_ = _loc3_.objectType.technologyInfo;
            if (!(_loc4_ == 0 || _loc6_.maxLevel < _loc4_)) {
                _loc7_ = _loc6_.getLevelInfo(_loc4_).getUnitTypes();
                _loc8_ = 0;
                while (_loc8_ < _loc7_.length) {
                    if (_loc7_[_loc8_] && _loc7_[_loc8_].id == _loc5_) {
                        _loc2_.currentLevel = _loc4_;
                        _loc2_.maxLevel = _loc6_.maxLevel;
                        break;
                    }
                    _loc8_++;
                }
            }
        }
        return _loc2_;
    }

    public function getSpeedToStorage(param1:int):int {
        var _loc3_:TechnologyLevelInfo = null;
        var _loc4_:GeoSceneObject = null;
        var _loc5_:int = 0;
        var _loc6_:Resources = null;
        var _loc2_:int = 0;
        for each(_loc4_ in this.technologies) {
            _loc5_ = _loc4_.getLevel();
            _loc3_ = _loc4_.objectType.technologyInfo.getLevelInfo(_loc5_);
            if (_loc3_ && _loc3_.dynamicResourceMiningSpeedPerHour) {
                _loc6_ = _loc4_.objectType.technologyInfo.getLevelInfo(_loc5_).dynamicResourceMiningSpeedPerHour;
                switch (param1) {
                    case LocationTypeId.STORAGE_CREDIT:
                        _loc2_ = _loc2_ + _loc6_.money;
                        continue;
                    case LocationTypeId.STORAGE_BIOPLASM:
                        _loc2_ = _loc2_ + _loc6_.biochips;
                        continue;
                    case LocationTypeId.STORAGE_GOLD_MONEY:
                        _loc2_ = _loc2_ + _loc6_.goldMoney;
                        continue;
                    case LocationTypeId.STORAGE_TITAN:
                        _loc2_ = _loc2_ + _loc6_.titanite;
                        continue;
                    case LocationTypeId.STORAGE_URAN:
                        _loc2_ = _loc2_ + _loc6_.uranium;
                        continue;
                    case LocationTypeId.STORAGE_AVP_MONEY:
                        _loc2_ = _loc2_ + _loc6_.avpMoney;
                        continue;
                    default:
                        continue;
                }
            }
            else {
                continue;
            }
        }
        return _loc2_;
    }
}
}
