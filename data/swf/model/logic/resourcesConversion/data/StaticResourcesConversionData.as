package model.logic.resourcesConversion.data {
import common.ArrayCustom;

public class StaticResourcesConversionData {

    public static const GOLD_MONEY_JOB_TYPE_ID:int = 100;


    public var conversionJobTypes:ArrayCustom;

    public function StaticResourcesConversionData() {
        super();
    }

    public static function fromDto(param1:*):StaticResourcesConversionData {
        var _loc2_:StaticResourcesConversionData = new StaticResourcesConversionData();
        _loc2_.conversionJobTypes = param1.t == null ? new ArrayCustom() : ResourcesConversionJobType.fromDtos(param1.t);
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

    public function getJobsWithTime():ArrayCustom {
        var _loc2_:ResourcesConversionJobType = null;
        var _loc1_:ArrayCustom = new ArrayCustom();
        for each(_loc2_ in this.conversionJobTypes) {
            if (_loc2_.durationHours > 0) {
                _loc1_.addItem(_loc2_);
            }
        }
        return _loc1_;
    }

    public function getJobsById(param1:int):Array {
        var _loc3_:ResourcesConversionJobType = null;
        var _loc2_:Array = [];
        for each(_loc3_ in this.conversionJobTypes) {
            if (_loc3_.outResourceTypeId == param1 && _loc3_.durationHours >= 0) {
                _loc2_.push(_loc3_);
            }
        }
        return _loc2_;
    }

    public function getJobTypeById(param1:int):ResourcesConversionJobType {
        var _loc2_:ResourcesConversionJobType = null;
        for each(_loc2_ in this.conversionJobTypes) {
            if (_loc2_.id == param1) {
                return _loc2_;
            }
        }
        return null;
    }
}
}
