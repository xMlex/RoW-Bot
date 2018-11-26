package model.logic.commands.alliances {
import common.ArrayCustom;

import flash.utils.Dictionary;

import model.data.alliances.Alliance;
import model.data.alliances.AllianceGameData;
import model.data.alliances.AllianceUserTroopsStats;
import model.data.alliances.KnownAlliance;
import model.data.alliances.KnownAllianceData;
import model.data.alliances.membership.AllianceMember;
import model.logic.AllianceManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.user.UserGetNotesCmd;

public class BaseAllianceCmd extends BaseCmd {


    public function BaseAllianceCmd() {
        super();
    }

    protected static function makeRequestDto(param1:* = null):* {
        if (AllianceManager.currentAlliance == null) {
            return null;
        }
        var _loc2_:AllianceGameData = AllianceManager.currentAlliance.gameData;
        var _loc3_:* = {
            "i": AllianceManager.currentAlliance.id,
            "r": _loc2_.revision
        };
        if (param1 != null) {
            _loc3_.o = param1;
        }
        return _loc3_;
    }

    protected static function updateAllianceByResultDto(param1:*, param2:Boolean = true, param3:Boolean = false):Boolean {
        var _loc4_:Dictionary = null;
        var _loc9_:Number = NaN;
        var _loc10_:AllianceMember = null;
        var _loc11_:AllianceMember = null;
        var _loc12_:AllianceUserTroopsStats = null;
        var _loc13_:Boolean = false;
        var _loc14_:Number = NaN;
        var _loc15_:KnownAllianceData = null;
        var _loc16_:Boolean = false;
        var _loc17_:ArrayCustom = null;
        var _loc18_:KnownAlliance = null;
        if (!AllianceManager.currentAlliance) {
            return true;
        }
        if (param1.d == null) {
            if (param2) {
                AllianceManager.currentAlliance.gameData.revision++;
            }
            return false;
        }
        var _loc5_:Dictionary = new Dictionary();
        if (AllianceManager.currentAlliance.gameData.towersData != null) {
            if (AllianceManager.currentAlliance.gameData.towersData.towerUnitTroops != null) {
                _loc4_ = AllianceManager.currentAlliance.gameData.towersData.towerUnitTroops;
            }
            for each(_loc10_ in AllianceManager.currentAlliance.gameData.membershipData.members) {
                if (_loc10_.userTroopsStats != null) {
                    _loc5_[_loc10_.userId] = _loc10_.userTroopsStats;
                }
            }
        }
        var _loc6_:Array = AllianceManager.currentAlliance.gameData.getKnownUserIds();
        if (param1.n) {
            AllianceManager.updateAlliance(AllianceGameData.fromDto(param1.d), param1.n);
        }
        else {
            AllianceManager.updateAlliance2(AllianceGameData.fromDto(param1.d));
        }
        if (AllianceManager.currentAlliance.gameData.towersData != null) {
            if (AllianceManager.currentAlliance.gameData.towersData.towerUnitTroops == null && _loc4_ != null) {
                AllianceManager.currentAlliance.gameData.towersData.towerUnitTroops = _loc4_;
            }
            for each(_loc11_ in AllianceManager.currentAlliance.gameData.membershipData.members) {
                if (_loc11_.userTroopsStats == null) {
                    _loc12_ = _loc5_[_loc11_.userId];
                    if (_loc12_ != null) {
                        _loc11_.userTroopsStats = _loc12_;
                    }
                }
            }
        }
        var _loc7_:Array = AllianceManager.currentAlliance.gameData.getKnownUserIds();
        var _loc8_:ArrayCustom = new ArrayCustom();
        for each(_loc9_ in _loc7_) {
            _loc13_ = false;
            for each(_loc14_ in _loc6_) {
                if (_loc9_ == _loc14_) {
                    _loc13_ = true;
                    break;
                }
            }
            if (!_loc13_) {
                _loc8_.addItem(_loc9_);
            }
        }
        if (_loc8_.length > 0) {
            new UserGetNotesCmd(_loc8_).execute();
        }
        if (param1.w) {
            _loc15_ = KnownAllianceData.fromDto(param1.w);
            _loc16_ = AllianceManager.currentMember && AllianceManager.currentMember.canMakeDiplomaticDecidions;
            AllianceManager.currentAlliance.gameData.knownAllianceData.knownAlliancesRequests = !!_loc16_ ? _loc15_.knownAlliancesRequests : new ArrayCustom();
            AllianceManager.currentAlliance.gameData.knownAllianceData.proposal = _loc15_.proposal;
            if (_loc16_) {
                AllianceManager.currentAlliance.gameData.knownAllianceData.knownAlliances = _loc15_.knownAlliances;
            }
            else {
                _loc17_ = new ArrayCustom();
                for each(_loc18_ in _loc15_.knownAlliances) {
                    if (_loc18_.knownAllianceActiveInfo) {
                        _loc18_.knownAllianceInitiateInfo = null;
                        _loc18_.knownAllianceTerminateInfo = null;
                        _loc17_.addItem(_loc18_);
                    }
                }
                AllianceManager.currentAlliance.gameData.knownAllianceData.knownAlliances = _loc17_;
            }
            AllianceManager.currentAlliance.gameData.knownAllianceData.dirty = true;
        }
        Alliance.updateAllianceTroopsStats(param1, AllianceManager.currentAlliance.gameData, param3);
        return true;
    }
}
}
