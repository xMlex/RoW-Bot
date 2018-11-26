package model.logic.blackMarketItems {
import common.TimeSpan;

public class InventoryItemDestroyerData {


    public var duration:TimeSpan;

    public function InventoryItemDestroyerData() {
        super();
    }

    public static function fromDto(param1:*):InventoryItemDestroyerData {
        var _loc2_:InventoryItemDestroyerData = new InventoryItemDestroyerData();
        _loc2_.duration = TimeSpan.fromDto(param1.d);
        return _loc2_;
    }
}
}
