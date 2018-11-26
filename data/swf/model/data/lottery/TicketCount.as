package model.data.lottery {
public class TicketCount {


    public var ticketTypeId:int;

    public var paidCount:int;

    public var freeCount:int;

    public function TicketCount() {
        super();
    }

    public static function fromDto(param1:*):TicketCount {
        var _loc2_:TicketCount = new TicketCount();
        _loc2_.ticketTypeId = param1.t;
        _loc2_.freeCount = param1.f;
        _loc2_.paidCount = param1.b;
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
