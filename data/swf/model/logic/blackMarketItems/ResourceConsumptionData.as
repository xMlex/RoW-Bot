package model.logic.blackMarketItems {
import model.data.Resources;

public class ResourceConsumptionData {

    public static const RESOURCES_25:int = 25;

    public static const RESOURCES_50:int = 50;


    public var durationSeconds:Number;

    public var resources:Resources;

    public function ResourceConsumptionData() {
        super();
    }

    public static function fromDto(param1:*):ResourceConsumptionData {
        var _loc2_:ResourceConsumptionData = new ResourceConsumptionData();
        _loc2_.durationSeconds = param1.d;
        _loc2_.resources = param1.r == null ? null : Resources.fromDto(param1.r);
        return _loc2_;
    }
}
}
