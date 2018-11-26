package model.data.scenes.types.info {
import common.ArrayCustom;

import model.data.gems.GemBonus;

public class GemLevelInfo {


    public var bonus:GemBonus;

    public function GemLevelInfo() {
        super();
    }

    public static function fromDto(param1:*):GemLevelInfo {
        var _loc2_:GemLevelInfo = new GemLevelInfo();
        _loc2_.bonus = param1.b == null ? null : GemBonus.fromDto(param1.b);
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
