package model.logic.blackMarketItems {
public class BlackMarketBoostData {


    public var timeSeconds:Number;

    public var speedUpCoefficient:Number;

    public var applicableForSupportTroops:Boolean;

    public function BlackMarketBoostData() {
        super();
    }

    public static function fromDto(param1:*):BlackMarketBoostData {
        var _loc2_:BlackMarketBoostData = new BlackMarketBoostData();
        _loc2_.timeSeconds = param1.d;
        _loc2_.speedUpCoefficient = param1.p;
        _loc2_.applicableForSupportTroops = param1.s;
        return _loc2_;
    }
}
}
