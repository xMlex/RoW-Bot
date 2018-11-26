package model.logic.blackMarketItems {
public class DustBonusData {


    public var amount:Number;

    public function DustBonusData() {
        super();
    }

    public static function fromDto(param1:*):DustBonusData {
        var _loc2_:DustBonusData = new DustBonusData();
        _loc2_.amount = param1.d;
        return _loc2_;
    }
}
}
