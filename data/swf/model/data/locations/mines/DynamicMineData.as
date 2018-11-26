package model.data.locations.mines {
import flash.utils.Dictionary;

public class DynamicMineData {


    public var typeId:int;

    public var freeFrom:Date;

    public var resources:Number;

    public var speed:Number;

    public var capacityBonusByTroopsTypeId:Dictionary;

    public function DynamicMineData() {
        super();
    }

    public static function fromDto(param1:*):DynamicMineData {
        var _loc3_:* = undefined;
        var _loc4_:int = 0;
        var _loc2_:DynamicMineData = new DynamicMineData();
        _loc2_.typeId = param1.t;
        _loc2_.freeFrom = param1.f == null ? new Date() : new Date(param1.f);
        _loc2_.resources = param1.r;
        _loc2_.speed = param1.s == null ? Number(Number.NaN) : Number(param1.s);
        _loc2_.capacityBonusByTroopsTypeId = new Dictionary();
        for (_loc3_ in param1.c) {
            _loc4_ = param1.c[_loc3_];
            if (_loc4_ != 0) {
                _loc2_.capacityBonusByTroopsTypeId[_loc3_] = _loc4_;
            }
        }
        return _loc2_;
    }
}
}
