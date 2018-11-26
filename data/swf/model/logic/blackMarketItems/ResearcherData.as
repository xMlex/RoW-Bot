package model.logic.blackMarketItems {
import common.TimeSpan;

public class ResearcherData {


    public var duration:TimeSpan;

    public function ResearcherData() {
        super();
    }

    public static function fromDto(param1:*):ResearcherData {
        var _loc2_:ResearcherData = new ResearcherData();
        _loc2_.duration = TimeSpan.fromDto(param1.d);
        return _loc2_;
    }
}
}
