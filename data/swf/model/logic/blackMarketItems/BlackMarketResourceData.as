package model.logic.blackMarketItems {
import model.data.Resources;

public class BlackMarketResourceData {


    public var resources:Resources;

    public function BlackMarketResourceData() {
        super();
    }

    public static function fromDto(param1:*):BlackMarketResourceData {
        var _loc2_:BlackMarketResourceData = new BlackMarketResourceData();
        _loc2_.resources = param1.r == null ? null : Resources.fromDto(param1.r);
        return _loc2_;
    }
}
}
