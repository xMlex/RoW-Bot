package model.logic.blackMarketItems {
public class InventoryItemData {


    public var tier:int;

    public var rareness:int;

    public var count:int;

    public function InventoryItemData() {
        super();
    }

    public static function fromDto(param1:*):InventoryItemData {
        var _loc2_:InventoryItemData = new InventoryItemData();
        _loc2_.tier = param1.t == null ? -1 : int(param1.t);
        _loc2_.rareness = param1.r == null ? -1 : int(param1.r);
        _loc2_.count = param1.c == null ? -1 : int(param1.c);
        return _loc2_;
    }
}
}
