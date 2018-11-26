package model.logic.resourcesConversion.data {
import common.ArrayCustom;

import gameObjects.observableObject.ObservableObject;

import model.logic.ServerTimeManager;
import model.logic.UserManager;
import model.logic.resourcesConversion.ResourcesConversionManager;

public class UserResourcesConversionData extends ObservableObject {

    public static const CLASS_NAME:String = "UserResourcesConversionData";

    public static const DATA_CHANGED:String = CLASS_NAME + "Changed";

    public static const COMPLETED:String = CLASS_NAME + "Completed";


    public var dirty:Boolean;

    public var nextJobId:Number;

    public var currentJobs:ArrayCustom;

    public function UserResourcesConversionData() {
        super();
    }

    public static function fromDto(param1:*):UserResourcesConversionData {
        var _loc2_:UserResourcesConversionData = new UserResourcesConversionData();
        _loc2_.nextJobId = param1.i;
        _loc2_.currentJobs = param1.j == null ? null : ResourcesConversionJob.fromDtos(param1.j);
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
        var _loc3_:UserResourcesConversionData = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public static function getActiveJobByType(param1:int):ResourcesConversionJob {
        var _loc2_:Array = UserManager.user.gameData.resourcesConversionData.currentJobs as Array;
        if (!_loc2_ || _loc2_.length == 0) {
            return null;
        }
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_.length) {
            if (_loc2_[_loc3_].outResourcesTypeId == param1) {
                return _loc2_[_loc3_];
            }
            _loc3_++;
        }
        return null;
    }

    public static function removeFinishedJobs():void {
        var _loc1_:Array = UserManager.user.gameData.resourcesConversionData.currentJobs as Array;
        if (!_loc1_ || _loc1_.length == 0) {
            return;
        }
        var _loc2_:int = _loc1_.length - 1;
        while (_loc2_ >= 0) {
            if (_loc1_[_loc2_].conversionFinishTime < ServerTimeManager.serverTimeNow) {
                ResourcesConversionManager.finishJob(UserManager.user, _loc1_[_loc2_]);
            }
            _loc2_--;
        }
    }

    public function dispatchEvents():void {
        var _loc1_:ResourcesConversionJob = null;
        if (this.dirty) {
            this.dirty = false;
            removeFinishedJobs();
            dispatchEvent(DATA_CHANGED);
        }
        if (this.currentJobs != null) {
            for each(_loc1_ in this.currentJobs) {
                _loc1_.dispatchEvents();
            }
        }
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.nextJobId,
            "j": (this.currentJobs == null ? null : ResourcesConversionJob.toDtos(this.currentJobs))
        };
        return _loc1_;
    }
}
}
