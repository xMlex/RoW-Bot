package model.data.lottery {
import model.data.Resources;

public class TicketTypeInfo {


    public var id:int;

    public var price:Resources;

    public var typeId:int;

    public function TicketTypeInfo() {
        super();
    }

    public static function fromDto(param1:*):TicketTypeInfo {
        var _loc2_:TicketTypeInfo = new TicketTypeInfo();
        _loc2_.id = param1.i;
        _loc2_.price = Resources.fromDto(param1.p);
        _loc2_.typeId = param1.d;
        return _loc2_;
    }

    public static function fromDtos(param1:*):Array {
        var _loc3_:* = undefined;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
