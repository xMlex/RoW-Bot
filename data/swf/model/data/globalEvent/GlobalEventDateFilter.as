package model.data.globalEvent {
public class GlobalEventDateFilter {


    public var dateFrom:Date;

    public var dateTo:Date;

    public var dateShowFrom:Date;

    public function GlobalEventDateFilter() {
        super();
    }

    public static function fromDto(param1:*):GlobalEventDateFilter {
        var _loc2_:GlobalEventDateFilter = new GlobalEventDateFilter();
        _loc2_.dateFrom = param1.s == null ? null : new Date(param1.s);
        _loc2_.dateTo = param1.f == null ? null : new Date(param1.f);
        _loc2_.dateShowFrom = param1.t == null ? null : new Date(param1.t);
        return _loc2_;
    }
}
}
