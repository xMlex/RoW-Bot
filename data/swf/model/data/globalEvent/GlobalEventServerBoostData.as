package model.data.globalEvent {
public class GlobalEventServerBoostData {


    public var typeId:int;

    public var boostValue:Number;

    public var iconUrl:String;

    public var activeEventText:String;

    public var activeEventPictureUrl:String;

    public function GlobalEventServerBoostData() {
        super();
    }

    public static function fromDto(param1:*):GlobalEventServerBoostData {
        if (param1 == null) {
            return null;
        }
        var _loc2_:GlobalEventServerBoostData = new GlobalEventServerBoostData();
        _loc2_.typeId = param1.i;
        _loc2_.boostValue = param1.v;
        _loc2_.iconUrl = param1.ic;
        _loc2_.activeEventText = param1.an == null ? null : param1.an.c;
        _loc2_.activeEventPictureUrl = param1.ap == null ? null : param1.ap;
        return _loc2_;
    }
}
}
