package model.logic.resourcesConversion.normalization {
import common.ArrayCustom;

import model.data.User;
import model.data.normalization.INEvent;
import model.data.normalization.INormalizable;
import model.logic.resourcesConversion.data.ResourcesConversionJob;

public class ResourcesConversionNormalizable implements INormalizable {

    private static var _instance:ResourcesConversionNormalizable;


    public function ResourcesConversionNormalizable() {
        super();
    }

    public static function get instance():ResourcesConversionNormalizable {
        if (_instance == null) {
            _instance = new ResourcesConversionNormalizable();
        }
        return _instance;
    }

    public function getNextEvent(param1:User, param2:Date):INEvent {
        var _loc5_:ResourcesConversionJob = null;
        if (param1.gameData.resourcesConversionData == null || param1.gameData.resourcesConversionData.currentJobs == null) {
            return null;
        }
        var _loc3_:ArrayCustom = param1.gameData.resourcesConversionData.currentJobs;
        var _loc4_:ResourcesConversionJob = null;
        for each(_loc5_ in _loc3_) {
            if (!(_loc5_.conversionFinishTime == null || _loc5_.conversionFinishTime < param2)) {
                _loc4_ = _loc5_;
                param2 = _loc5_.conversionFinishTime;
                _loc5_.dirtyNormalized = true;
                _loc5_.updatePercentage(param2);
            }
        }
        return _loc4_ == null ? null : new NEventResourcesConversionFinished(_loc4_, param2);
    }
}
}
