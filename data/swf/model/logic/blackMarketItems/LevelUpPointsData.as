package model.logic.blackMarketItems {
public class LevelUpPointsData {


    public var levelUpPoints:int;

    public function LevelUpPointsData() {
        super();
    }

    public static function fromDto(param1:*):LevelUpPointsData {
        var _loc2_:LevelUpPointsData = new LevelUpPointsData();
        _loc2_.levelUpPoints = param1.p == null ? 0 : int(param1.p);
        return _loc2_;
    }
}
}
