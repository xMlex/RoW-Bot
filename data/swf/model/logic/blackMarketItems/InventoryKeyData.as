package model.logic.blackMarketItems {
public class InventoryKeyData {


    public var requiredTechnologyId:Number;

    public var rareness:int;

    public var count:int;

    public function InventoryKeyData() {
        super();
    }

    public static function fromDto(param1:*):InventoryKeyData {
        var _loc2_:InventoryKeyData = new InventoryKeyData();
        _loc2_.requiredTechnologyId = param1.t;
        _loc2_.rareness = param1.r;
        _loc2_.count = param1.c;
        return _loc2_;
    }
}
}
