package model.data.alliances {
public class KnownAllianceActiveInfo {


    public var type:int;

    public var startDate:Date;

    public function KnownAllianceActiveInfo() {
        super();
    }

    public static function fromDto(param1:*):KnownAllianceActiveInfo {
        var _loc2_:KnownAllianceActiveInfo = new KnownAllianceActiveInfo();
        _loc2_.type = param1.t == null ? 0 : int(param1.t);
        _loc2_.startDate = param1.d == null ? null : new Date(param1.d);
        return _loc2_;
    }
}
}
