package model.logic.inventory.listener {
import model.logic.inventory.InventoryManager;

public class InventoryItemActionTypeConverter {


    public function InventoryItemActionTypeConverter() {
        super();
    }

    public function convert(param1:Object):int {
        var _loc2_:int = 0;
        switch (param1) {
            case InventoryManager.START_UPGRADING:
            case InventoryManager.ITEM_IS_UPGRADED:
                _loc2_ = InventoryItemActionType.UPGRADING;
                break;
            case InventoryManager.START_POWDERING:
            case InventoryManager.ITEM_IS_POWDERED:
                _loc2_ = InventoryItemActionType.POWDERING;
                break;
            default:
                _loc2_ = InventoryItemActionType.NONE;
        }
        return _loc2_;
    }
}
}
