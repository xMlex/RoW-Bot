package model.logic.blackMarketItems {
public class GachaChestData {


    public var gachaChestTypeId:int;

    public function GachaChestData() {
        super();
    }

    public static function fromDto(param1:*):GachaChestData {
        var _loc2_:GachaChestData = new GachaChestData();
        _loc2_.gachaChestTypeId = param1.i;
        return _loc2_;
    }
}
}
