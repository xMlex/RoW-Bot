package model.data {
import common.ArrayCustom;

public class SpecialOffer {


    public var typeId:int;

    public var number:Number;

    public var price:Resources;

    public var buyDate:Date;

    public function SpecialOffer() {
        super();
    }

    public static function fromDto(param1:*):SpecialOffer {
        var _loc2_:SpecialOffer = new SpecialOffer();
        _loc2_.typeId = param1.i;
        _loc2_.number = param1.n == null ? Number(Number.NaN) : Number(param1.n);
        _loc2_.price = Resources.fromDto(param1.p);
        _loc2_.buyDate = param1.d == null ? null : new Date(param1.d);
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function toDtos(param1:ArrayCustom):Array {
        var _loc3_:SpecialOffer = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function copy():SpecialOffer {
        var _loc1_:SpecialOffer = new SpecialOffer();
        _loc1_.typeId = this.typeId;
        _loc1_.number = this.number;
        _loc1_.price = this.price;
        _loc1_.buyDate = this.buyDate;
        return _loc1_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.typeId,
            "n": (!!isNaN(this.number) ? null : this.number),
            "p": (this.price == null ? null : this.price.toDto()),
            "d": (this.buyDate == null ? null : this.buyDate.time)
        };
        return _loc1_;
    }
}
}
