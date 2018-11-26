package model.data.alliances {
public class KnownAllianceTerminateInfo {


    public var terminatorAllianceId:Number;

    public var terminationDate:Date;

    public var confirmed:Boolean;

    public var cancelling:Boolean;

    public function KnownAllianceTerminateInfo() {
        super();
    }

    public static function fromDto(param1:*):KnownAllianceTerminateInfo {
        var _loc2_:KnownAllianceTerminateInfo = new KnownAllianceTerminateInfo();
        _loc2_.terminatorAllianceId = param1.t == null ? Number(NaN) : Number(param1.t);
        _loc2_.terminationDate = param1.d == null ? null : new Date(param1.d);
        _loc2_.confirmed = param1.c;
        _loc2_.cancelling = param1.b;
        return _loc2_;
    }
}
}
