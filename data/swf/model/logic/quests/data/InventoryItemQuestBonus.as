package model.logic.quests.data {
import common.ArrayCustom;

public class InventoryItemQuestBonus {


    public var tier:int;

    public var rareness:int;

    public var group:int;

    public var isSealed:Boolean;

    public function InventoryItemQuestBonus() {
        super();
    }

    public static function fromDto(param1:*):InventoryItemQuestBonus {
        var _loc2_:InventoryItemQuestBonus = new InventoryItemQuestBonus();
        _loc2_.tier = param1.t;
        _loc2_.rareness = param1.r;
        _loc2_.group = param1.g;
        _loc2_.isSealed = param1.s;
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        if (param1 == null) {
            return new ArrayCustom();
        }
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
