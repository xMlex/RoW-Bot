package model.logic.blackMarketItems {
public class BlackMarketVipPointsData {


    public var points:int;

    public function BlackMarketVipPointsData() {
        super();
    }

    public static function fromDto(param1:*):BlackMarketVipPointsData {
        var _loc2_:BlackMarketVipPointsData = new BlackMarketVipPointsData();
        _loc2_.points = param1.p;
        return _loc2_;
    }
}
}
