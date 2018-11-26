package model.logic.commands.triggers {
import model.data.specialOfferTriggers.TriggerEventTypeEnum;

public class TriggerClientEventDto {


    private var _e:int;

    private var _w:int;

    private var _g:Number = 0;

    public function TriggerClientEventDto(param1:int) {
        super();
        this._e = param1;
    }

    public function get e():int {
        return this._e;
    }

    public function set w(param1:int):void {
        this._w = param1;
    }

    public function get w():int {
        return this._w;
    }

    public function set g(param1:Number):void {
        this._g = param1;
    }

    public function get g():Number {
        return this._g;
    }

    public function toString():String {
        var _loc1_:* = "Event Type: " + this._e + " [" + TriggerEventTypeEnum.getNameByType(this._e) + "]";
        if (this._w > 0) {
            _loc1_ = _loc1_ + ("; WorkersCount: " + this._w);
        }
        if (!isNaN(this._g) && this._g != 0) {
            _loc1_ = _loc1_ + ("; GoldMoney: " + this._g);
        }
        return _loc1_;
    }
}
}
