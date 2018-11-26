package model.data.locations.towers {
public class TowerUnitSlot {


    public var slotId:int;

    public var bought:Boolean;

    public var userId:int = -1;

    public function TowerUnitSlot() {
        super();
    }

    public static function towerUnitSlotFill(param1:int, param2:Boolean):TowerUnitSlot {
        var _loc3_:TowerUnitSlot = new TowerUnitSlot();
        _loc3_.slotId = param1;
        _loc3_.bought = param2;
        return _loc3_;
    }

    public static function fromDto(param1:*):TowerUnitSlot {
        var _loc2_:TowerUnitSlot = new TowerUnitSlot();
        _loc2_.bought = param1.b;
        _loc2_.slotId = param1.i;
        _loc2_.userId = param1.uid != null ? int(param1.uid) : -1;
        return _loc2_;
    }

    public static function fromDtos(param1:*):Array {
        var _loc3_:* = undefined;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
