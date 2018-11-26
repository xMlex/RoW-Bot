package model.logic.blackMarketItems {
public class MininBoostActivationResult {


    public var until:Number;

    public function MininBoostActivationResult() {
        super();
    }

    public static function fromDto(param1:*):MininBoostActivationResult {
        var _loc2_:MininBoostActivationResult = new MininBoostActivationResult();
        _loc2_.until = param1.u == null ? Number(0) : Number(param1.u);
        return _loc2_;
    }
}
}
