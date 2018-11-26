package model.data.raids {
public class GlobalMissionUIData {


    public var objectName:String;

    public var objectDescription:String;

    public var objectPictureUrl:String;

    public function GlobalMissionUIData() {
        super();
    }

    public static function fromDto(param1:*):GlobalMissionUIData {
        var _loc2_:GlobalMissionUIData = new GlobalMissionUIData();
        _loc2_.objectName = param1.n == null ? "" : param1.n;
        _loc2_.objectDescription = param1.d == null ? "" : param1.d;
        _loc2_.objectPictureUrl = param1.u == null ? "" : param1.u;
        return _loc2_;
    }
}
}
