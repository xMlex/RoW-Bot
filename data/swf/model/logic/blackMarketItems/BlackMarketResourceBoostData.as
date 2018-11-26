package model.logic.blackMarketItems {
import model.data.Resources;

public class BlackMarketResourceBoostData {


    public var resources:Resources;

    public var durationSeconds:Number;

    public function BlackMarketResourceBoostData() {
        super();
    }

    public static function fromDto(param1:*):BlackMarketResourceBoostData {
        var _loc2_:BlackMarketResourceBoostData = new BlackMarketResourceBoostData();
        _loc2_.resources = param1.r == null ? null : Resources.fromDto(param1.r);
        _loc2_.durationSeconds = param1.d;
        return _loc2_;
    }
}
}
