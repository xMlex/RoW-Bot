package model.logic.blackMarketItems {
public class BlackMarketConstructionPointsData {


    public var constructionPoints:int;

    public function BlackMarketConstructionPointsData() {
        super();
    }

    public static function fromDto(param1:*):BlackMarketConstructionPointsData {
        var _loc2_:BlackMarketConstructionPointsData = new BlackMarketConstructionPointsData();
        _loc2_.constructionPoints = param1.a;
        return _loc2_;
    }
}
}
