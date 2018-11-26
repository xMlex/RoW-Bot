package model.data.locations.allianceCity.flags {
import model.data.locations.allianceCity.flags.enumeration.AllianceEffectBonusType;

public class AllianceTacticsEffectType {


    public var id:Number;

    public var applyingType:int;

    public var bonusType:int;

    public var value:int;

    public function AllianceTacticsEffectType() {
        super();
    }

    public static function fromDto(param1:*):AllianceTacticsEffectType {
        var _loc2_:AllianceTacticsEffectType = new AllianceTacticsEffectType();
        _loc2_.id = param1.i;
        _loc2_.applyingType = param1.a;
        _loc2_.bonusType = param1.t;
        _loc2_.value = param1.v;
        return _loc2_;
    }

    public static function fromDtos(param1:*):Array {
        var _loc3_:* = undefined;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public function get hasPercentSign():Boolean {
        return this.bonusType != AllianceEffectBonusType.EXTRA_DAILY_ROBBERIES;
    }
}
}
