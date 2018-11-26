package model.logic.inventory {
public class SealedInventoryType {


    public var inventoryItemRareness:int = 0;

    public var affectedGroupIds:Vector.<int>;

    public function SealedInventoryType() {
        super();
    }

    public static function fromDto(param1:*):SealedInventoryType {
        var _loc3_:* = undefined;
        if (!param1) {
            return null;
        }
        var _loc2_:SealedInventoryType = new SealedInventoryType();
        _loc2_.affectedGroupIds = new Vector.<int>();
        _loc2_.inventoryItemRareness = param1.r == null ? -1 : int(param1.r);
        for each(_loc3_ in param1.g) {
            _loc2_.affectedGroupIds.push(_loc3_);
        }
        return _loc2_;
    }
}
}
