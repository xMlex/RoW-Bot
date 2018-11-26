package model.logic.blackMarketItems {
public class BlackMarketResetDailyData {


    public var dailyQuestKind:int;

    public function BlackMarketResetDailyData() {
        super();
    }

    public static function fromDto(param1:*):BlackMarketResetDailyData {
        var _loc2_:BlackMarketResetDailyData = new BlackMarketResetDailyData();
        _loc2_.dailyQuestKind = param1.k;
        return _loc2_;
    }
}
}
