package model.data.scenes.types.info {
import common.ArrayCustom;

import model.data.Resources;

public class SaleableLevelInfo {


    public var price:Resources;

    public var goldPrice:Resources;

    public var dustPrice:Number;

    public var constructionSeconds:int;

    public var destructionSeconds:int;

    public var requiredUserLevel:int;

    public var constructionBlockPrize:int;

    public var requiredObjects:ArrayCustom;

    public var isAdditionalLevel:Boolean;

    public function SaleableLevelInfo() {
        super();
    }

    public static function fromDto(param1:*):SaleableLevelInfo {
        var _loc2_:SaleableLevelInfo = new SaleableLevelInfo();
        _loc2_.price = Resources.fromDto(param1.p);
        _loc2_.goldPrice = param1.g == null ? null : Resources.fromDto(param1.g);
        _loc2_.dustPrice = !!param1.u ? Number(param1.u) : Number(null);
        _loc2_.constructionSeconds = param1.c;
        _loc2_.destructionSeconds = param1.d;
        _loc2_.requiredUserLevel = param1.l == null ? 0 : int(param1.l);
        _loc2_.constructionBlockPrize = param1.b;
        _loc2_.requiredObjects = param1.ro == null ? null : RequiredObject.fromDtos(param1.ro);
        _loc2_.isAdditionalLevel = param1.a == null ? false : Boolean(param1.a);
        return _loc2_;
    }

    public static function fromDtos(param1:*):Vector.<SaleableLevelInfo> {
        var _loc3_:* = undefined;
        var _loc2_:Vector.<SaleableLevelInfo> = new Vector.<SaleableLevelInfo>();
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
