package model.data.inventory {
public class InventoryItemObjInfo {


    public var issueTime:Date;

    public var slotId:int;

    public var sealed:Boolean;

    public var minUserLevel:int;

    public var baseAttackBonus:Number;

    public var baseDefenseBonus:Number;

    public var objectHasBeenMoved:Boolean;

    public function InventoryItemObjInfo(param1:Date, param2:int, param3:Boolean, param4:int, param5:Number, param6:Number) {
        super();
        this.issueTime = param1;
        this.slotId = param2;
        this.sealed = param3;
        this.minUserLevel = param4;
        this.baseAttackBonus = param5;
        this.baseDefenseBonus = param6;
    }

    public static function fromDto(param1:*):InventoryItemObjInfo {
        if (!param1) {
            return null;
        }
        var _loc2_:Date = new Date(param1.i);
        return new InventoryItemObjInfo(_loc2_, param1.s == null ? -1 : int(param1.s), param1.e, param1.m, param1.a, param1.d);
    }
}
}
