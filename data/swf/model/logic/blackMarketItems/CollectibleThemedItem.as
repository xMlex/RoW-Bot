package model.logic.blackMarketItems {
public class CollectibleThemedItem {


    private var _itemWeight:int;

    private var _count:int;

    public function CollectibleThemedItem() {
        super();
    }

    public static function fromDto(param1:*):CollectibleThemedItem {
        var _loc2_:CollectibleThemedItem = new CollectibleThemedItem();
        _loc2_._itemWeight = param1.s;
        _loc2_._count = param1.p;
        return _loc2_;
    }

    public function get itemWeight():int {
        return this._itemWeight;
    }

    public function get count():int {
        return this._count;
    }
}
}
