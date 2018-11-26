package model.logic.blackMarketItems {
public class StaticBonusPackData {


    public var packId:int;

    public function StaticBonusPackData() {
        super();
    }

    public static function fromDto(param1:*):StaticBonusPackData {
        var _loc2_:StaticBonusPackData = new StaticBonusPackData();
        _loc2_.packId = param1.i;
        return _loc2_;
    }
}
}
