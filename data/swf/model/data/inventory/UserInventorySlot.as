package model.data.inventory {
import model.data.scenes.objects.GeoSceneObject;
import model.logic.UserManager;

public class UserInventorySlot {


    public var id:int;

    public var typeId:int;

    public var locked:Boolean;

    public function UserInventorySlot(param1:int, param2:int, param3:Boolean) {
        super();
        this.id = param1;
        this.typeId = param2;
        this.locked = param3;
    }

    public static function fromDto(param1:*):UserInventorySlot {
        var _loc2_:UserInventorySlot = new UserInventorySlot(param1.i, param1.t, param1.u);
        return _loc2_;
    }

    public function get item():GeoSceneObject {
        return UserManager.user.gameData.inventoryData.inventoryItemsBySlotId[this.id];
    }
}
}
