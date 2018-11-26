package model.data.users.artifacts {
import common.ArrayCustom;

import flash.utils.Dictionary;

import gameObjects.observableObject.ObservableObject;

import model.data.Resources;
import model.data.User;
import model.data.normalization.INEvent;
import model.data.normalization.INormalizable;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.objects.info.ArtifactStorageId;
import model.data.scenes.types.info.ArtifactTypeInfo;
import model.logic.StaticDataManager;

public class UserArtifactData extends ObservableObject implements INormalizable {

    public static const CLASS_NAME:String = "UserArtifactData";

    public static const ARTIFACTS_CHANGED:String = CLASS_NAME + "ArtifactsChanged";

    public static const AVAILABLE_SLOTS_CHANGED:String = CLASS_NAME + "AvailableSlotsChanged";

    public static const TEMPORARY_SLOTS_CHANGED:String = CLASS_NAME + "TemporarySlotsChanged";

    public static const ACTIVE_ARTIFACT_EXPIRED:String = CLASS_NAME + "ActiveArtifactExpired";

    public static const ACTIVE_SLOTS_CHANGED:String = CLASS_NAME + "ActiveSlotsChanged";

    private static var unitTypeIds:Array = StaticDataManager.getAllUnitTypeIds();


    public var nextObjectId:Number;

    public var lastTimeGotArtifact:Date;

    public var issuedArtifacts:ArrayCustom;

    public var earnedLossesPoints:Number;

    public var storageSlotsAvailable:int;

    public var artifacts:Dictionary;

    public var artifactsLayout:Array;

    public var storageSlotsGivenForFriends:int;

    public var storageSlotsBought:int;

    public var activeSlotsBought:int;

    public var activeSlotsOpenedForFriends:int;

    private var _bonusesByAllAffectedTypes:Dictionary = null;

    public var _artifactsDirty:Boolean = false;

    public var availableSlotsChanged:Boolean = false;

    public var temporarySlotsChanged:Boolean = false;

    public var activeArtifactExpired:Boolean = false;

    public var activeSlotsChanged:Boolean = false;

    public function UserArtifactData() {
        this.issuedArtifacts = new ArrayCustom();
        this.artifacts = new Dictionary();
        this.artifactsLayout = new Array();
        super();
    }

    public static function getAffectedTypes(param1:Array, param2:ArtifactTypeInfo):Array {
        var _loc6_:int = 0;
        var _loc3_:Array = new Array();
        var _loc4_:Array = new Array();
        if (param2.affectedTypes.length == 0) {
            _loc4_ = StaticDataManager.getAllUnitTypeIds();
        }
        else {
            _loc4_ = param2.affectedTypes;
        }
        var _loc5_:int = 0;
        while (_loc5_ < param1.length) {
            _loc6_ = 0;
            while (_loc6_ < _loc4_.length) {
                if (param1[_loc5_] == _loc4_[_loc6_]) {
                    _loc3_.push(param1[_loc5_]);
                    break;
                }
                _loc6_++;
            }
            _loc5_++;
        }
        return _loc3_;
    }

    public static function AddBonus(param1:ArtifactTypeInfo, param2:ArtifactTypeInfo, param3:Function, param4:Function):void {
        var _loc6_:Number = NaN;
        var _loc5_:Number = param3(param1);
        if (!isNaN(_loc5_)) {
            _loc6_ = param3(param2);
            param4(param2, !isNaN(_loc6_) ? _loc6_ + _loc5_ : _loc5_);
        }
    }

    public static function fromDto(param1:*):UserArtifactData {
        var _loc3_:* = undefined;
        var _loc2_:UserArtifactData = new UserArtifactData();
        _loc2_.nextObjectId = param1.n;
        _loc2_.storageSlotsAvailable = param1.c;
        _loc2_.storageSlotsBought = param1.b;
        _loc2_.lastTimeGotArtifact = param1.t == null ? null : new Date(param1.t);
        _loc2_.earnedLossesPoints = param1.e;
        _loc2_.artifactsLayout = param1.l;
        _loc2_.issuedArtifacts = IssuedArtifact.fromDtos(param1.o);
        _loc2_.storageSlotsGivenForFriends = param1.f;
        _loc2_.activeSlotsBought = param1.x;
        _loc2_.activeSlotsOpenedForFriends = param1.z;
        _loc2_.artifacts = new Dictionary();
        for (_loc3_ in param1.a) {
            _loc2_.artifacts[_loc3_] = GeoSceneObject.fromDto(param1.a[_loc3_]);
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

    public function get artifactsDirty():Boolean {
        return this._artifactsDirty;
    }

    public function set artifactsDirty(param1:Boolean):void {
        this._artifactsDirty = param1;
        if (this._artifactsDirty) {
            this._bonusesByAllAffectedTypes = null;
        }
    }

    public function getNextEvent(param1:User, param2:Date):INEvent {
        var _loc3_:* = this.getNextArtifactWithEvent(param1, param2);
        return _loc3_.artifact == null ? null : new NEventArtifact(_loc3_.artifact, _loc3_.time);
    }

    private function getNextArtifactWithEvent(param1:User, param2:Date):* {
        var _loc4_:* = undefined;
        var _loc5_:GeoSceneObject = null;
        var _loc6_:Date = null;
        var _loc3_:GeoSceneObject = null;
        for (_loc4_ in param1.gameData.artifactData.artifacts) {
            _loc5_ = param1.gameData.artifactData.artifacts[_loc4_];
            _loc6_ = _loc5_.constructionObjInfo.constructionFinishTime;
            if (_loc6_ != null) {
                _loc5_.constructionInfo.updatePercentage(param2);
                _loc5_.dirtyNormalized = true;
            }
            if (!(_loc6_ == null || _loc6_ > param2)) {
                _loc3_ = _loc5_;
                param2 = _loc6_;
            }
        }
        return {
            "artifact": _loc3_,
            "time": param2
        };
    }

    public function dispatchEvents():void {
        var _loc1_:* = undefined;
        if (this.artifactsDirty) {
            this.artifactsDirty = false;
            dispatchEvent(ARTIFACTS_CHANGED);
        }
        if (this.availableSlotsChanged) {
            this.availableSlotsChanged = false;
            dispatchEvent(AVAILABLE_SLOTS_CHANGED);
        }
        if (this.activeArtifactExpired) {
            this.activeArtifactExpired = false;
            dispatchEvent(ACTIVE_ARTIFACT_EXPIRED);
        }
        if (this.temporarySlotsChanged) {
            this.temporarySlotsChanged = false;
            dispatchEvent(TEMPORARY_SLOTS_CHANGED);
        }
        if (this.activeSlotsChanged) {
            this.activeSlotsChanged = false;
            dispatchEvent(ACTIVE_SLOTS_CHANGED);
        }
        for (_loc1_ in this.artifacts) {
            this.artifacts[_loc1_].dispatchEvents();
        }
    }

    public function GetActiveArtifacts():ArrayCustom {
        var _loc2_:* = undefined;
        var _loc3_:GeoSceneObject = null;
        var _loc1_:ArrayCustom = new ArrayCustom();
        for (_loc2_ in this.artifacts) {
            _loc3_ = this.artifacts[_loc2_];
            if (_loc3_.artifactInfo.storageId == ArtifactStorageId.ACTIVE) {
                _loc1_.addItem(_loc3_);
                if (_loc1_.length >= StaticDataManager.artifactData.maxActiveArtifactsNumber) {
                    break;
                }
            }
        }
        return _loc1_;
    }

    public function GetResourceMiningBonus():Resources {
        var _loc2_:GeoSceneObject = null;
        var _loc3_:Resources = null;
        var _loc1_:Resources = new Resources();
        for each(_loc2_ in this.GetActiveArtifacts()) {
            _loc3_ = _loc2_.objectType.artifactInfo.resourcesMiningBonus;
            if (_loc3_ != null) {
                _loc1_.add(_loc3_);
            }
        }
        return _loc1_;
    }

    public function GetResourcesConsumptionBonus():Number {
        return this.GetBonuses(function (param1:*):* {
            return param1.resourcesConsumptionBonus;
        });
    }

    public function GetSectorDefenseBonus():Number {
        return this.GetBonuses(function (param1:*):* {
            return param1.sectorDefenseBonus;
        });
    }

    public function GetSectorIntelligenceDefenseBonus():Number {
        return this.GetBonuses(function (param1:*):* {
            return param1.sectorIntelligenceDefenseBonus;
        });
    }

    public function GetTechnologyResearchSpeedBonus():Number {
        return this.GetBonuses(function (param1:*):* {
            return param1.techResearchSpeedBonus;
        });
    }

    public function GetBonuses(param1:Function):Number {
        var _loc4_:GeoSceneObject = null;
        var _loc5_:Number = NaN;
        var _loc2_:ArrayCustom = this.GetActiveArtifacts();
        var _loc3_:Number = 0;
        for each(_loc4_ in _loc2_) {
            _loc5_ = param1(_loc4_.objectType.artifactInfo);
            if (!isNaN(_loc5_)) {
                _loc3_ = _loc3_ + _loc5_;
            }
        }
        return _loc3_;
    }

    public function getBonusesByAffectedTypes(param1:Array = null):Dictionary {
        var activeArtifact:GeoSceneObject = null;
        var ati:ArtifactTypeInfo = null;
        var effectedTypes:Array = null;
        var typeId:int = 0;
        var bonus:ArtifactTypeInfo = null;
        var typeIds:Array = param1;
        if (typeIds == null) {
            if (this._bonusesByAllAffectedTypes == null) {
                this._bonusesByAllAffectedTypes = this.getBonusesByAffectedTypes(unitTypeIds);
            }
            return this._bonusesByAllAffectedTypes;
        }
        var bonuses:Dictionary = new Dictionary();
        var activeArtifacts:ArrayCustom = this.GetActiveArtifacts();
        for each(activeArtifact in activeArtifacts) {
            ati = activeArtifact.objectType.artifactInfo;
            if (ati.affectedTypes != null) {
                effectedTypes = getAffectedTypes(typeIds, ati);
                for each(typeId in effectedTypes) {
                    bonus = bonuses[typeId];
                    if (bonus == null) {
                        bonus = new ArtifactTypeInfo();
                        bonus.name = activeArtifact.name;
                        bonuses[typeId] = bonus;
                    }
                    AddBonus(ati, bonus, function (param1:*):* {
                        return param1.attackBonus;
                    }, function (param1:*, param2:Number):* {
                        param1.attackBonus = param2;
                    });
                    AddBonus(ati, bonus, function (param1:*):* {
                        return param1.defenseBonus;
                    }, function (param1:*, param2:Number):* {
                        param1.defenseBonus = param2;
                    });
                    AddBonus(ati, bonus, function (param1:*):* {
                        return param1.intelligenceBonus;
                    }, function (param1:*, param2:Number):* {
                        param1.intelligenceBonus = param2;
                    });
                    AddBonus(ati, bonus, function (param1:*):* {
                        return param1.movementSpeedBonus;
                    }, function (param1:*, param2:Number):* {
                        param1.movementSpeedBonus = param2;
                    });
                    AddBonus(ati, bonus, function (param1:*):* {
                        return param1.constructionSpeedBonus;
                    }, function (param1:*, param2:Number):* {
                        param1.constructionSpeedBonus = param2;
                    });
                    AddBonus(ati, bonus, function (param1:*):* {
                        return param1.priceBonus;
                    }, function (param1:*, param2:Number):* {
                        param1.priceBonus = param2;
                    });
                    AddBonus(ati, bonus, function (param1:*):* {
                        return param1.carryingCapacityBonus;
                    }, function (param1:*, param2:Number):* {
                        param1.carryingCapacityBonus = param2;
                    });
                    AddBonus(ati, bonus, function (param1:*):* {
                        return param1.resourcesConsumptionBonus;
                    }, function (param1:*, param2:Number):* {
                        param1.resourcesConsumptionBonus = param2;
                    });
                }
            }
        }
        return bonuses;
    }
}
}
