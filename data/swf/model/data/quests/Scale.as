package model.data.quests {
import flash.utils.Dictionary;

import model.logic.dtoSerializer.DtoDeserializer;

public class Scale {


    public var items:Dictionary;

    public var arrayItems:Array;

    public var isEmpty:Boolean;

    public var allianceMembersCountMin:int;

    public var allianceMembersCountMax:int;

    public var minPoints:int;

    public var maxPoints:int;

    public function Scale() {
        super();
    }

    public static function fromDto(param1:*, param2:Function = null):Scale {
        var _loc5_:* = undefined;
        var _loc3_:Scale = new Scale();
        _loc3_.items = new Dictionary();
        var _loc4_:Boolean = true;
        if (param1.s != null) {
            _loc3_.items = DtoDeserializer.toDictionary(param1.s, null, param2);
        }
        _loc3_.arrayItems = new Array();
        for (_loc5_ in _loc3_.items) {
            _loc3_.arrayItems.push({
                "points": _loc5_,
                "value": _loc3_.items[_loc5_]
            });
            _loc4_ = false;
            if (_loc3_.minPoints > _loc5_) {
                _loc3_.minPoints = _loc5_;
            }
            if (_loc3_.maxPoints < _loc5_) {
                _loc3_.maxPoints = _loc5_;
            }
        }
        _loc3_.isEmpty = _loc4_;
        _loc3_.allianceMembersCountMin = param1.x;
        _loc3_.allianceMembersCountMax = param1.y;
        return _loc3_;
    }

    public static function fromDtos(param1:*):Array {
        var _loc3_:* = undefined;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
