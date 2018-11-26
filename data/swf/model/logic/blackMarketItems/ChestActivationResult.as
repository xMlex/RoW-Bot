package model.logic.blackMarketItems {
import common.ArrayCustom;

import model.data.scenes.objects.GeoSceneObject;

public class ChestActivationResult {


    public var gems:ArrayCustom;

    public function ChestActivationResult() {
        super();
    }

    public static function fromDto(param1:*):ChestActivationResult {
        var _loc2_:ChestActivationResult = new ChestActivationResult();
        _loc2_.gems = param1.g == null ? new ArrayCustom() : GeoSceneObject.fromDtos2(param1.g);
        return _loc2_;
    }
}
}
