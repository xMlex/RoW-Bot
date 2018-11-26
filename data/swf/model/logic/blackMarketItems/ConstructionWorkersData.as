package model.logic.blackMarketItems {
import common.TimeSpan;

public class ConstructionWorkersData {


    public var duration:TimeSpan;

    public function ConstructionWorkersData() {
        super();
    }

    public static function fromDto(param1:*):ConstructionWorkersData {
        var _loc2_:ConstructionWorkersData = new ConstructionWorkersData();
        _loc2_.duration = TimeSpan.fromDto(param1.a);
        return _loc2_;
    }
}
}
