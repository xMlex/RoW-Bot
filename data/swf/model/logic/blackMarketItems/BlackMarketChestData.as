package model.logic.blackMarketItems {
public class BlackMarketChestData {


    public var gemLevelFrom:int;

    public var gemLevelTo:int;

    public var gemCount:int;

    public function BlackMarketChestData() {
        super();
    }

    public static function fromDto(param1:*):BlackMarketChestData {
        var _loc2_:BlackMarketChestData = new BlackMarketChestData();
        _loc2_.gemLevelFrom = param1.f;
        _loc2_.gemLevelTo = param1.t;
        _loc2_.gemCount = param1.c;
        return _loc2_;
    }
}
}
