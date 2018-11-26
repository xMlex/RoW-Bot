package model.logic.occupation.data {
import common.ArrayCustom;

import configs.Global;

import gameObjects.observableObject.ObservableObject;

import model.data.Resources;
import model.logic.ServerTimeManager;
import model.logic.occupation.OccupationManager;

public class UserOccupationInfo extends ObservableObject {

    public static const CLASS_NAME:String = "UserOccupationInfo";

    public static const STATUS_UPDATED:String = CLASS_NAME + "StatusUpdated";


    public var dirtyNormalized:Boolean;

    public var userId:Number;

    public var occupationStartTime:Date;

    public var collectionCoeff:Number;

    public var lastCollectionTime:Date;

    public var resourceTypeId:int;

    public var state:int;

    public var canBeCollected:Boolean;

    public var resourcesCollected:Resources;

    public function UserOccupationInfo() {
        this.resourcesCollected = new Resources();
        super();
    }

    public static function fromDto(param1:*):UserOccupationInfo {
        var _loc2_:UserOccupationInfo = new UserOccupationInfo();
        _loc2_.userId = param1.i;
        _loc2_.occupationStartTime = param1.o == null ? null : new Date(param1.o);
        _loc2_.collectionCoeff = param1.f;
        _loc2_.lastCollectionTime = param1.c == null ? null : new Date(param1.c);
        _loc2_.resourceTypeId = param1.r;
        _loc2_.state = param1.s;
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

    public static function toDtos(param1:ArrayCustom):Array {
        var _loc3_:UserOccupationInfo = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (!this.dirtyNormalized) {
            return;
        }
        this.dirtyNormalized = false;
        dispatchEvent(STATUS_UPDATED);
    }

    public function getMaxCollectionCount():Number {
        return this.getProductionPerHour() * Global.serverSettings.occupation.maximumCollectionPeriod;
    }

    public function getProductionPerHour():Number {
        var _loc1_:OccupiedUserNote = OccupationManager.getOccupiedUserNote(this.userId);
        if (!_loc1_) {
            return 0;
        }
        return Math.floor(OccupationManager.getCollectingResourcesPerHour(_loc1_.level, this.collectionCoeff));
    }

    public function equalsTo(param1:UserOccupationInfo):Boolean {
        return this.userId == param1.userId && this.occupationStartTime == param1.occupationStartTime && this.collectionCoeff == param1.collectionCoeff && this.lastCollectionTime == param1.lastCollectionTime && this.resourceTypeId == param1.resourceTypeId && this.state == param1.state;
    }

    public function update(param1:UserOccupationInfo):void {
        this.userId = param1.userId;
        this.occupationStartTime = param1.occupationStartTime;
        this.collectionCoeff = param1.collectionCoeff;
        this.lastCollectionTime = param1.lastCollectionTime;
        this.resourceTypeId = param1.resourceTypeId;
        this.state = param1.state;
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.userId,
            "o": (this.occupationStartTime == null ? null : this.occupationStartTime.time),
            "f": this.collectionCoeff,
            "c": (this.lastCollectionTime == null ? null : this.lastCollectionTime.time),
            "r": this.resourceTypeId,
            "s": this.state
        };
        return _loc1_;
    }

    public function refreshCollectionState():void {
        var _loc3_:Date = null;
        var _loc4_:Date = null;
        var _loc5_:Number = NaN;
        var _loc6_:OccupiedUserNote = null;
        var _loc7_:Number = NaN;
        var _loc8_:Resources = null;
        var _loc1_:Boolean = this.canBeCollected;
        var _loc2_:Number = this.resourcesCollected.capacity();
        if (this.state != OccupationState.COLLECTING) {
            this.canBeCollected = false;
            if (this.resourcesCollected.capacity() > 0) {
                this.resourcesCollected = new Resources();
            }
        }
        else {
            _loc3_ = this.lastCollectionTime != null ? this.lastCollectionTime : new Date(this.occupationStartTime.time + Global.serverSettings.occupation.collectionStartDelayHours * 60 * 60 * 1000);
            _loc4_ = ServerTimeManager.serverTimeNow;
            _loc5_ = (_loc4_.time - _loc3_.time) / (1000 * 60 * 60);
            this.canBeCollected = _loc5_ >= Global.serverSettings.occupation.minimumCollectionPeriod;
            _loc6_ = OccupationManager.getOccupiedUserNote(this.userId);
            if (_loc6_ != null) {
                _loc7_ = OccupationManager.getCollectingResourcesPerHour(_loc6_.level, this.collectionCoeff);
                _loc8_ = Resources.fromType(this.resourceTypeId, _loc7_ * Math.min(Global.serverSettings.occupation.maximumCollectionPeriod, _loc5_));
                if (_loc8_.capacity() != this.resourcesCollected.capacity()) {
                    this.resourcesCollected = _loc8_;
                }
            }
        }
        if (_loc1_ != this.canBeCollected || this.resourcesCollected.capacity() != _loc2_) {
            this.dirtyNormalized = true;
        }
    }
}
}
