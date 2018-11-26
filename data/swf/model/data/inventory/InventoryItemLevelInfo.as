package model.data.inventory {
public class InventoryItemLevelInfo {


    public var attackBonus:Number;

    public var defenseBonus:Number;

    public var powderDustAmount:Number;

    public function InventoryItemLevelInfo(param1:Number, param2:Number, param3:Number) {
        super();
        this.attackBonus = param1;
        this.defenseBonus = param2;
        this.powderDustAmount = param3;
    }

    public static function fromDto(param1:*):InventoryItemLevelInfo {
        return new InventoryItemLevelInfo(param1.a, param1.d, param1.sb);
    }
}
}
