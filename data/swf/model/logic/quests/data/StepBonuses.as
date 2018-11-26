package model.logic.quests.data {
import model.data.UserPrize;

public class StepBonuses {


    public var points:Number;

    public var bonuses:UserPrize;

    public function StepBonuses() {
        super();
    }

    public static function fromDto(param1:*):StepBonuses {
        var _loc2_:StepBonuses = new StepBonuses();
        _loc2_.points = param1.p == null ? Number(0) : Number(param1.p);
        _loc2_.bonuses = param1.b == null ? null : UserPrize.fromDto(param1.b);
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
