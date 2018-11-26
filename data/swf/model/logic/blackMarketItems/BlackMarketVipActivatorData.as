package model.logic.blackMarketItems {
public class BlackMarketVipActivatorData {


    public var durationSeconds:Number;

    public var maxLevel:int;

    public var minLevel:int;

    public function BlackMarketVipActivatorData() {
        super();
    }

    public static function fromDto(param1:*):BlackMarketVipActivatorData {
        var _loc2_:BlackMarketVipActivatorData = new BlackMarketVipActivatorData();
        _loc2_.durationSeconds = param1.d;
        _loc2_.maxLevel = param1.h;
        _loc2_.minLevel = param1.l;
        return _loc2_;
    }
}
}
