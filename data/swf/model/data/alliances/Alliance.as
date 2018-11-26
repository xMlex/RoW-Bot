package model.data.alliances {
import common.ArrayCustom;

import flash.utils.Dictionary;

import model.data.alliances.membership.AllianceMember;
import model.data.users.troops.Troops;

public class Alliance {


    public var id:Number;

    public var name:String;

    public var gameData:AllianceGameData;

    public var segmentId:int;

    public var ratingLevelPos:int;

    public var ratingValue:Number;

    public var pureTerritory:Number;

    public function Alliance() {
        super();
    }

    public static function fromDto(param1:*):Alliance {
        var _loc2_:Alliance = new Alliance();
        _loc2_.id = param1.i;
        _loc2_.name = param1.n;
        _loc2_.gameData = AllianceGameData.fromDto(param1.d);
        _loc2_.segmentId = param1.s;
        _loc2_.ratingLevelPos = param1.p;
        _loc2_.ratingValue = param1.v;
        _loc2_.pureTerritory = param1.t;
        _loc2_.gameData.knownAllianceData = param1.w == null ? new KnownAllianceData() : KnownAllianceData.fromDto(param1.w);
        updateAllianceTroopsStats(param1, _loc2_.gameData);
        return _loc2_;
    }

    public static function updateAllianceTroopsStats(param1:*, param2:AllianceGameData, param3:Boolean = false):void {
        var _loc4_:* = undefined;
        var _loc7_:* = undefined;
        var _loc10_:AllianceMember = null;
        var _loc11_:Dictionary = null;
        var _loc12_:Object = null;
        var _loc13_:* = undefined;
        var _loc14_:AllianceUserTroopsStats = null;
        var _loc5_:Dictionary = new Dictionary();
        var _loc6_:Dictionary = new Dictionary();
        if (param1.g != null) {
            for (_loc7_ in param1.g) {
                _loc5_[_loc7_] = Troops.fromDto(param1.g[_loc7_]);
            }
        }
        if (param1.x != null) {
            for (_loc7_ in param1.x) {
                _loc6_[_loc7_] = Troops.fromDto(param1.x[_loc7_]);
            }
        }
        var _loc8_:Dictionary = new Dictionary();
        var _loc9_:Dictionary = new Dictionary();
        if (param1.m != null) {
            for (_loc7_ in param1.m) {
                _loc8_[_loc7_] = AllianceUserTroopsStats.fromDto(param1.m[_loc7_]);
            }
        }
        if (param1.b != null) {
            for (_loc7_ in param1.b) {
                _loc9_[_loc7_] = AllianceUserTroopsStats.fromDto(param1.b[_loc7_]);
            }
        }
        if (param1.z != null) {
            _loc11_ = new Dictionary();
            for (_loc4_ in param1.z) {
                _loc11_[_loc4_] = new Dictionary();
                _loc12_ = param1.z[_loc4_];
                for (_loc13_ in _loc12_) {
                    _loc14_ = _loc12_[_loc13_] != null ? AllianceUserTroopsStats.fromDto(_loc12_[_loc13_]) : new AllianceUserTroopsStats();
                    _loc11_[_loc4_][_loc13_] = _loc14_;
                }
            }
            param2.towersData.towerUnitTroopsStats = _loc11_;
        }
        for each(_loc10_ in param2.membershipData.members) {
            _loc10_.userTroops = _loc5_[_loc10_.userId];
            _loc10_.userTroopsLastWeek = _loc6_[_loc10_.userId];
            if (_loc10_.userTroopsStats == null || _loc10_.userTroopsStats.isEmpty() || param3) {
                _loc10_.userTroopsStats = _loc8_[_loc10_.userId] == null ? new AllianceUserTroopsStats() : _loc8_[_loc10_.userId];
            }
            _loc10_.userTroopsStatsLastWeek = _loc9_[_loc10_.userId] == null ? new AllianceUserTroopsStats() : _loc9_[_loc10_.userId];
        }
    }

    public static function fromVisitAllianceDto(param1:*):Alliance {
        var dto:* = param1;
        var entity:Alliance = new Alliance();
        try {
            entity.id = dto.i;
            entity.name = dto.n;
            entity.gameData = AllianceGameData.fromVisitAllianceDto(dto.d);
            entity.segmentId = dto.s;
            entity.ratingLevelPos = dto.p;
            entity.ratingValue = dto.v;
            entity.gameData.knownAllianceData.knownAlliances = dto.w == null ? new ArrayCustom() : KnownAlliance.fromDtos(dto.w);
        }
        catch (err:Error) {
        }
        return entity;
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
