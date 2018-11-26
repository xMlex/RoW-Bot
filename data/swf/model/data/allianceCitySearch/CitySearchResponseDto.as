package model.data.allianceCitySearch {
import common.ArrayCustom;

import flash.utils.Dictionary;

import model.data.alliances.AllianceNote;
import model.data.locations.LocationNote;
import model.logic.AllianceNoteManager;

public class CitySearchResponseDto {


    public var citySearchCacheItems:Array;

    public var allianceNotes:Dictionary;

    public var locationNotes:Dictionary;

    public var lastIndex:int;

    public function CitySearchResponseDto() {
        super();
    }

    public static function fromDto(param1:*):CitySearchResponseDto {
        var _loc2_:CitySearchResponseDto = new CitySearchResponseDto();
        var _loc3_:ArrayCustom = AllianceNote.fromDtos(param1.a);
        AllianceNoteManager.update(_loc3_);
        _loc2_.allianceNotes = convertAlliancesToDictionary(_loc3_);
        _loc2_.locationNotes = convertLocationToDictionary(LocationNote.fromDtos(param1.l));
        _loc2_.citySearchCacheItems = CitySearchCacheItem.fromDtos(param1.c);
        _loc2_.lastIndex = param1.m;
        return _loc2_;
    }

    private static function convertAlliancesToDictionary(param1:ArrayCustom):Dictionary {
        var _loc3_:AllianceNote = null;
        var _loc2_:Dictionary = new Dictionary();
        for each(_loc3_ in param1) {
            _loc2_[_loc3_.id] = _loc3_;
        }
        return _loc2_;
    }

    private static function convertLocationToDictionary(param1:ArrayCustom):Dictionary {
        var _loc3_:LocationNote = null;
        var _loc2_:Dictionary = new Dictionary();
        for each(_loc3_ in param1) {
            _loc2_[_loc3_.id] = _loc3_;
        }
        return _loc2_;
    }
}
}
