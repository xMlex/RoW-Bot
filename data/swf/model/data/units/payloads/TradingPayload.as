package model.data.units.payloads {
import model.data.Resources;
import model.data.users.drawings.DrawingPart;

public class TradingPayload {


    public var numberOfCaravans:int;

    public var caravanSpeed:Number = 0;

    public var resources:Resources;

    public var drawingPart:DrawingPart;

    public function TradingPayload() {
        super();
    }

    public static function fromDto(param1:*):TradingPayload {
        var _loc2_:TradingPayload = new TradingPayload();
        _loc2_.numberOfCaravans = param1.c;
        _loc2_.caravanSpeed = param1.s;
        _loc2_.resources = param1.r == null ? null : Resources.fromDto(param1.r);
        _loc2_.drawingPart = param1.d == null ? null : DrawingPart.fromDto(param1.d);
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "c": this.numberOfCaravans,
            "s": this.caravanSpeed,
            "r": (this.resources == null ? null : this.resources.toDto()),
            "d": (this.drawingPart == null ? null : this.drawingPart.toDto())
        };
        return _loc1_;
    }
}
}
