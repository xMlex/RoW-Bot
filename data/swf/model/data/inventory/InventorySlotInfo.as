package model.data.inventory {
import model.data.Resources;

public class InventorySlotInfo {


    public var id:int;

    public var inventorySlotKind:int;

    public var price:Resources;

    public var inventoryItemGroups:Vector.<int>;

    public function InventorySlotInfo(param1:int, param2:int, param3:Resources, param4:Vector.<int>) {
        super();
        this.id = param1;
        this.inventorySlotKind = param2;
        this.price = param3;
        this.inventoryItemGroups = param4;
    }

    public static function fromDto(param1:*):InventorySlotInfo {
        var _loc4_:* = undefined;
        var _loc2_:Resources = Resources.fromDto(param1.p);
        var _loc3_:Vector.<int> = new Vector.<int>(0);
        for each(_loc4_ in param1.g) {
            _loc3_.push(_loc4_);
        }
        return new InventorySlotInfo(param1.i, param1.k, _loc2_, _loc3_);
    }
}
}
