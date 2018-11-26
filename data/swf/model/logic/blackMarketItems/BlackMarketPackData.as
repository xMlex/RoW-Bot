package model.logic.blackMarketItems {
public class BlackMarketPackData {


    public var packType:int;

    public var itemCount:int;

    public function BlackMarketPackData() {
        super();
    }

    public static function fromDto(param1:*):BlackMarketPackData {
        var _loc2_:BlackMarketPackData = new BlackMarketPackData();
        _loc2_.packType = param1.t;
        _loc2_.itemCount = param1.c;
        return _loc2_;
    }
}
}
