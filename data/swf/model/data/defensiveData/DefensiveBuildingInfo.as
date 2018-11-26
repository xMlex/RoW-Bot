package model.data.defensiveData {
public class DefensiveBuildingInfo {


    public var type:int;

    public var level:int;

    public function DefensiveBuildingInfo() {
        super();
    }

    public static function fromDto(param1:*):DefensiveBuildingInfo {
        if (param1 == null) {
            return null;
        }
        var _loc2_:DefensiveBuildingInfo = new DefensiveBuildingInfo();
        _loc2_.type = param1.t;
        _loc2_.level = param1.l;
        return _loc2_;
    }
}
}
