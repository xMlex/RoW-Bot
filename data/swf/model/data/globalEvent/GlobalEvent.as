package model.data.globalEvent {
public class GlobalEvent {

    public static const CATEGORY_ID_QUEST:int = 0;

    public static const CATEGORY_ID_STATIC_DISCOUNT:int = 1;

    public static const CATEGORY_ID_BLUE_LIGHT:int = 2;

    public static const CATEGORY_ID_SERVER_BOOST:int = 3;


    public var id:Number;

    public var globalEventCategoryId:int;

    public var userFilter:GlobalEventUserFilter;

    public var dateFilter:GlobalEventDateFilter;

    public var globalEventQuestData:GlobalEventQuestData;

    public var globalEventStaticDiscountData:GlobalEventStaticDiscountData;

    public var globalEventServerBoostData:GlobalEventServerBoostData;

    public function GlobalEvent() {
        super();
    }

    public static function fromDto(param1:*):GlobalEvent {
        var _loc2_:GlobalEvent = new GlobalEvent();
        _loc2_.id = param1.i;
        _loc2_.globalEventCategoryId = param1.c;
        _loc2_.userFilter = GlobalEventUserFilter.fromDto(param1.u);
        _loc2_.dateFilter = GlobalEventDateFilter.fromDto(param1.d);
        _loc2_.globalEventQuestData = !!param1.q ? GlobalEventQuestData.fromDto(param1.q) : null;
        _loc2_.globalEventStaticDiscountData = GlobalEventStaticDiscountData.fromDto(param1.n);
        _loc2_.globalEventServerBoostData = GlobalEventServerBoostData.fromDto(param1.g);
        return _loc2_;
    }

    public static function fromDtos(param1:*):Array {
        var _loc3_:* = undefined;
        if (param1 == null) {
            return [];
        }
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
