package model.logic.blackMarketItems {
public class SectorTeleportData {


    public var random:Boolean;

    public function SectorTeleportData() {
        super();
    }

    public static function fromDto(param1:*):SectorTeleportData {
        var _loc2_:SectorTeleportData = new SectorTeleportData();
        _loc2_.random = param1.r;
        return _loc2_;
    }
}
}
