package model.logic.blackMarketItems {
public class AbTestData {


    public var abTestGroupId:int;

    public function AbTestData() {
        super();
    }

    public static function fromDto(param1:*):AbTestData {
        var _loc2_:AbTestData = new AbTestData();
        _loc2_.abTestGroupId = param1.i == null ? -1 : int(param1.i);
        return _loc2_;
    }
}
}
