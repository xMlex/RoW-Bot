package model.data.scenes.types.info.troops {
import common.ArrayCustom;

public class BattleParameters {


    public var attack:Number;

    public var defense:ArrayCustom;

    public function BattleParameters() {
        super();
    }

    public static function fromDto(param1:*):BattleParameters {
        if (param1 == null) {
            return null;
        }
        var _loc2_:BattleParameters = new BattleParameters();
        _loc2_.attack = param1.a;
        _loc2_.defense = param1.d == null ? null : DefenseItem.fromDtos(param1.d);
        return _loc2_;
    }
}
}
