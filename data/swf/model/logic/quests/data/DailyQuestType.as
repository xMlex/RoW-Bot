package model.logic.quests.data {
import common.ArrayCustom;

public class DailyQuestType {


    public var id:int;

    public var nameLocalized:String;

    public var iconUrl:String;

    public function DailyQuestType() {
        super();
    }

    public static function fromDto(param1:*):DailyQuestType {
        var _loc2_:DailyQuestType = new DailyQuestType();
        _loc2_.id = param1.i;
        _loc2_.nameLocalized = param1.l == null ? null : param1.l.c;
        _loc2_.iconUrl = param1.u;
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
