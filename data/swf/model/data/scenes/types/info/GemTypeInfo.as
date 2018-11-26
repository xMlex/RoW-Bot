package model.data.scenes.types.info {
import common.ArrayCustom;

public class GemTypeInfo {


    public var affectedTypes:ArrayCustom;

    public var levelInfos:ArrayCustom;

    public function GemTypeInfo() {
        super();
    }

    public static function fromDto(param1:*):GemTypeInfo {
        if (param1 == null) {
            return null;
        }
        var _loc2_:GemTypeInfo = new GemTypeInfo();
        _loc2_.affectedTypes = param1.a == null ? new ArrayCustom() : new ArrayCustom(param1.a);
        _loc2_.levelInfos = param1.li == null ? new ArrayCustom() : GemLevelInfo.fromDtos(param1.li);
        return _loc2_;
    }
}
}
