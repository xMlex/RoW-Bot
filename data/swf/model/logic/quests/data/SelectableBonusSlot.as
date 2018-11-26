package model.logic.quests.data {
import model.data.UserPrize;

public class SelectableBonusSlot {


    public var isDynamic:Boolean;

    public var bonuses:Array;

    public var skipStrategyUnitsCalc:Boolean;

    public function SelectableBonusSlot() {
        super();
    }

    public static function fromDto(param1:*):SelectableBonusSlot {
        var _loc3_:* = undefined;
        var _loc2_:SelectableBonusSlot = new SelectableBonusSlot();
        _loc2_.isDynamic = param1.d == null ? false : Boolean(param1.d);
        _loc2_.bonuses = [];
        if (param1.l != null) {
            for each(_loc3_ in param1.l) {
                _loc2_.bonuses.push(UserPrize.fromDto(_loc3_));
            }
        }
        _loc2_.skipStrategyUnitsCalc = param1.s == null ? false : Boolean(param1.s);
        return _loc2_;
    }

    public static function fromDtos(param1:*):Array {
        var _loc3_:* = undefined;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public function clone():SelectableBonusSlot {
        var _loc2_:UserPrize = null;
        var _loc1_:SelectableBonusSlot = new SelectableBonusSlot();
        _loc1_.bonuses = [];
        _loc1_.isDynamic = this.isDynamic;
        for each(_loc2_ in this.bonuses) {
            _loc1_.bonuses.push(_loc2_.clone());
        }
        return _loc1_;
    }
}
}
