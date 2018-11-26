package model.logic.resourcesConversion.data {
import common.ArrayCustom;
import common.NumberUtil;

import gameObjects.observableObject.ObservableObject;

import model.data.Resources;
import model.logic.ServerTimeManager;

public class ResourcesConversionJob extends ObservableObject {

    public static const CLASS_NAME:String = "ResourcesConversionJob";

    public static const STATUS_UPDATED:String = CLASS_NAME + "StatusUpdated";


    public var dirtyNormalized:Boolean;

    public var id:Number;

    public var typeId:int;

    public var conversionStartTime:Date;

    public var conversionFinishTime:Date;

    public var progressPercentage:Number;

    public var inResources:Resources;

    public var outResources:Resources;

    public var outResourcesTypeId:int;

    public function ResourcesConversionJob() {
        super();
    }

    public static function fromDto(param1:*):ResourcesConversionJob {
        var _loc2_:ResourcesConversionJob = new ResourcesConversionJob();
        _loc2_.id = param1.i;
        _loc2_.typeId = param1.t;
        _loc2_.conversionStartTime = param1.s == null ? null : new Date(param1.s);
        _loc2_.conversionFinishTime = param1.f == null ? null : new Date(param1.f);
        _loc2_.progressPercentage = 0;
        _loc2_.inResources = Resources.fromDto(param1.c);
        _loc2_.outResources = Resources.fromDto(param1.o);
        _loc2_.outResourcesTypeId = param1.r;
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
        var _loc3_:ResourcesConversionJob = null;
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

    public function toDto():* {
        var _loc1_:* = {
            "i": this.id,
            "t": this.typeId,
            "s": (this.conversionStartTime == null ? null : this.conversionStartTime.time),
            "f": (this.conversionFinishTime == null ? null : this.conversionFinishTime.time),
            "c": (this.inResources == null ? null : this.inResources.toDto()),
            "o": (this.outResources == null ? null : this.outResources.toDto()),
            "r": this.outResourcesTypeId
        };
        return _loc1_;
    }

    public function updatePercentage(param1:Date):void {
        var _loc2_:uint = 0;
        var _loc3_:uint = 0;
        if (this.conversionFinishTime == null) {
            this.progressPercentage = 0;
        }
        else {
            _loc2_ = this.conversionFinishTime.time - this.conversionStartTime.time;
            _loc3_ = ServerTimeManager.serverTimeNow.time - this.conversionStartTime.time;
            this.progressPercentage = int(NumberUtil.percentsOf(_loc3_, _loc2_));
        }
        dispatchEvent(STATUS_UPDATED);
    }
}
}
