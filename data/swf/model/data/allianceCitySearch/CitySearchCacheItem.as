package model.data.allianceCitySearch {
import common.ArrayCustom;

import flash.utils.Dictionary;

import model.data.map.MapPos;

public class CitySearchCacheItem {


    public var cityId:int;

    public var allianceId:int;

    public var cityMapPos:MapPos;

    public var level:int;

    public var influence:Number;

    public var relationByAllianceId:Dictionary;

    public function CitySearchCacheItem() {
        super();
    }

    public static function fromDto(param1:*):CitySearchCacheItem {
        var _loc2_:CitySearchCacheItem = new CitySearchCacheItem();
        _loc2_.allianceId = param1.a;
        _loc2_.cityId = param1.i;
        _loc2_.cityMapPos = MapPos.fromDto(param1.m);
        _loc2_.level = param1.l;
        _loc2_.influence = param1.x;
        _loc2_.relationByAllianceId = param1.r != null ? parseToDictionary(param1.r) : null;
        return _loc2_;
    }

    private static function parseToDictionary(param1:*):Dictionary {
        var _loc3_:* = undefined;
        var _loc2_:Dictionary = new Dictionary();
        if (param1 != null) {
            for (_loc3_ in param1) {
                _loc2_[_loc3_] = param1[_loc3_];
            }
        }
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
