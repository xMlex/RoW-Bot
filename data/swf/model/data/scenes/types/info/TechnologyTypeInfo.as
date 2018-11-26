package model.data.scenes.types.info {
import common.ArrayCustom;

public class TechnologyTypeInfo {


    public var bonusDescription:String = "";

    public var upgradeDescription:String = "";

    public var levelInfos:ArrayCustom;

    public var isBlockedForeTrade:Boolean;

    public function TechnologyTypeInfo() {
        super();
    }

    public static function fromDto(param1:*):TechnologyTypeInfo {
        if (param1 == null) {
            return null;
        }
        var _loc2_:TechnologyTypeInfo = new TechnologyTypeInfo();
        if (param1.de != null) {
            _loc2_.bonusDescription = param1.de.c;
        }
        if (param1.ud != null) {
            _loc2_.upgradeDescription = param1.ud.c;
        }
        _loc2_.levelInfos = TechnologyLevelInfo.fromDtos(param1.lc);
        _loc2_.isBlockedForeTrade = param1.b;
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

    public function get maxLevel():int {
        return this.levelInfos.length;
    }

    public function getLevelInfo(param1:int):TechnologyLevelInfo {
        return this.levelInfos[param1 - 1];
    }
}
}
