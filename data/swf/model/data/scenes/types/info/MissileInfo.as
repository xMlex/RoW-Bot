package model.data.scenes.types.info {
public class MissileInfo {


    public var allowedTargetTypes:int;

    public function MissileInfo() {
        super();
    }

    public static function fromDto(param1:*):MissileInfo {
        var _loc2_:MissileInfo = new MissileInfo();
        _loc2_.allowedTargetTypes = param1.t;
        return _loc2_;
    }
}
}
