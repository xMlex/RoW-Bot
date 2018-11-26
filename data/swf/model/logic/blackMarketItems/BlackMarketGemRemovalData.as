package model.logic.blackMarketItems {
public class BlackMarketGemRemovalData {


    public var gemLevelFrom:int;

    public var gemLevelTo:int;

    public function BlackMarketGemRemovalData() {
        super();
    }

    public static function fromDto(param1:*):BlackMarketGemRemovalData {
        var _loc2_:BlackMarketGemRemovalData = new BlackMarketGemRemovalData();
        _loc2_.gemLevelFrom = param1.f;
        _loc2_.gemLevelTo = param1.t;
        return _loc2_;
    }
}
}
