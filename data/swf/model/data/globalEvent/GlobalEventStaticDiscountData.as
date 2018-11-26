package model.data.globalEvent {
import model.logic.dtoSerializer.DtoDeserializer;

public class GlobalEventStaticDiscountData {


    public var typeIds:Array;

    public var discountValue:Number;

    public var iconUrl:String;

    public var activeEventText:String;

    public var activeEventPictureUrl:String;

    public var upcomingEventText:String;

    public var upcomingEventPictureUrl:String;

    public function GlobalEventStaticDiscountData() {
        super();
    }

    public static function fromDto(param1:*):GlobalEventStaticDiscountData {
        if (param1 == null) {
            return null;
        }
        var _loc2_:GlobalEventStaticDiscountData = new GlobalEventStaticDiscountData();
        _loc2_.typeIds = param1.t == null ? [] : DtoDeserializer.toArray(param1.t);
        _loc2_.discountValue = param1.v;
        _loc2_.iconUrl = param1.ic;
        _loc2_.activeEventText = param1.an == null ? null : param1.an.c;
        _loc2_.activeEventPictureUrl = param1.ap == null ? null : param1.ap;
        _loc2_.upcomingEventText = param1.un = !!null ? null : param1.un.c;
        _loc2_.upcomingEventPictureUrl = param1.up = !!null ? null : param1.up;
        return _loc2_;
    }
}
}
