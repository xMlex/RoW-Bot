package model.logic.blackMarketItems {
public class UpdateSectorData {


    public var updateSectorType:int;

    public function UpdateSectorData() {
        super();
    }

    public static function fromDto(param1:*):UpdateSectorData {
        var _loc2_:UpdateSectorData = new UpdateSectorData();
        _loc2_.updateSectorType = param1.t;
        return _loc2_;
    }
}
}
