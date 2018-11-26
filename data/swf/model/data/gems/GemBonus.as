package model.data.gems {
public class GemBonus {


    public var attackBonus:Number;

    public var defenceInfantryBonus:Number;

    public var defenceArmouredBonus:Number;

    public var defenceArtilleryBonus:Number;

    public var defenceAerospaceBonus:Number;

    public var defenceAvpBonus:Number;

    public function GemBonus() {
        super();
    }

    public static function fromDto(param1:*):GemBonus {
        var _loc2_:GemBonus = new GemBonus();
        _loc2_.attackBonus = param1.a == null ? Number(0) : Number(param1.a);
        _loc2_.defenceInfantryBonus = param1.i == null ? Number(0) : Number(param1.i);
        _loc2_.defenceArmouredBonus = param1.r == null ? Number(0) : Number(param1.r);
        _loc2_.defenceArtilleryBonus = param1.t == null ? Number(0) : Number(param1.t);
        _loc2_.defenceAerospaceBonus = param1.s == null ? Number(0) : Number(param1.s);
        _loc2_.defenceAvpBonus = 0;
        return _loc2_;
    }
}
}
