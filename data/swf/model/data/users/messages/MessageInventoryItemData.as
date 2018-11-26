package model.data.users.messages {
import common.StringUtil;

import model.data.inventory.InventoryItemTier;

public class MessageInventoryItemData {


    public var typeId:int;

    public var rareness:int;

    public var tier:int;

    public function MessageInventoryItemData() {
        super();
    }

    public static function fromDto(param1:*):MessageInventoryItemData {
        var _loc2_:MessageInventoryItemData = new MessageInventoryItemData();
        _loc2_.typeId = param1.i;
        _loc2_.rareness = param1.r;
        _loc2_.tier = param1.t;
        return _loc2_;
    }

    public function get isSealed():Boolean {
        return this.typeId == 0;
    }

    public function get sealedUrl():String {
        var _loc1_:String = StringUtil.EMPTY;
        switch (this.tier) {
            case InventoryItemTier.TIER_1:
                _loc1_ = "ui/hero/inventory/items/sealed/chest_nords.png";
                break;
            case InventoryItemTier.TIER_2:
                _loc1_ = "ui/hero/inventory/items/sealed/chest_orcs.png";
                break;
            case InventoryItemTier.TIER_3:
                _loc1_ = "ui/hero/inventory/items/sealed/chest_elves.png";
                break;
            case InventoryItemTier.TIER_4:
                _loc1_ = "ui/hero/inventory/items/sealed/chest_dragons.png";
        }
        return _loc1_;
    }
}
}
