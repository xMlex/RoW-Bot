package model.data.alliances {
public class KnownAllianceInitiateInfo {


    public var type:int;

    public var cancelling:Boolean;

    public function KnownAllianceInitiateInfo() {
        super();
    }

    public static function fromDto(param1:*):KnownAllianceInitiateInfo {
        var _loc2_:KnownAllianceInitiateInfo = new KnownAllianceInitiateInfo();
        _loc2_.type = param1.t == null ? 0 : int(param1.t);
        _loc2_.cancelling = param1.c;
        return _loc2_;
    }
}
}
