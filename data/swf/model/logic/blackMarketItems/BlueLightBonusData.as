package model.logic.blackMarketItems {
import model.data.UserPrize;

public class BlueLightBonusData {


    public var prize:UserPrize;

    public var priceCrystals:int;

    public function BlueLightBonusData() {
        super();
    }

    public static function fromDto(param1:*):BlueLightBonusData {
        var _loc2_:BlueLightBonusData = new BlueLightBonusData();
        _loc2_.prize = UserPrize.fromDto(param1.p);
        _loc2_.priceCrystals = param1.c;
        return _loc2_;
    }
}
}
