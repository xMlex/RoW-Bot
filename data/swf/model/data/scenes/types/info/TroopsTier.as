package model.data.scenes.types.info {
public class TroopsTier {


    public var id:int;

    public var kind:int;

    public var groupId:int;

    public var affectedTroopsTypeIds:Array;

    public var defaultTroopsTypeId:int;

    public var levelInfos:Array;

    public function TroopsTier() {
        super();
    }

    public static function fromDto(param1:*):TroopsTier {
        var _loc4_:* = undefined;
        var _loc2_:TroopsTier = new TroopsTier();
        _loc2_.id = param1.i;
        _loc2_.kind = param1.k;
        _loc2_.groupId = param1.g;
        _loc2_.levelInfos = param1.l != null ? TroopsTierTypeLevelInfo.fromDtos(param1.l) : null;
        var _loc3_:int = int.MAX_VALUE;
        if (param1.t != null) {
            _loc2_.affectedTroopsTypeIds = [];
            for each(_loc4_ in param1.t) {
                _loc2_.affectedTroopsTypeIds.push(_loc4_);
                if (_loc3_ > _loc4_) {
                    _loc3_ = _loc4_;
                }
            }
        }
        _loc2_.defaultTroopsTypeId = _loc3_;
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

    public function getLevelInfo(param1:int):TroopsTierTypeLevelInfo {
        if (param1 < 0) {
            return this.levelInfos[0];
        }
        if (param1 < this.levelInfos.length) {
            return this.levelInfos[param1];
        }
        return null;
    }

    public function getMaxLevel():int {
        return this.levelInfos == null ? 0 : int(this.levelInfos.length);
    }
}
}
