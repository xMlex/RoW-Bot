package model.data.scenes.types.info {
import common.ArrayCustom;

import model.data.Resources;

public class DrawingTypeInfo {


    public var partsCount:int;

    public var miningPerHourSellKoeff:Number;

    protected var _pricePerPart:Resources;

    public var isBlockedForeTrade:Boolean;

    public function DrawingTypeInfo() {
        super();
    }

    public static function fromDto(param1:*):DrawingTypeInfo {
        if (param1 == null) {
            return null;
        }
        var _loc2_:DrawingTypeInfo = new DrawingTypeInfo();
        _loc2_.partsCount = param1.p;
        _loc2_.miningPerHourSellKoeff = param1.s;
        _loc2_._pricePerPart = Resources.fromDto(param1.c);
        _loc2_.isBlockedForeTrade = param1.b;
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
        var _loc3_:DrawingTypeInfo = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function get pricePerPart():Resources {
        return this._pricePerPart;
    }

    public function toDto():* {
        var _loc1_:* = {
            "p": this.partsCount,
            "s": this.miningPerHourSellKoeff
        };
        return _loc1_;
    }
}
}
