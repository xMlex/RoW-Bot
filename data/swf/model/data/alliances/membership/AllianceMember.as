package model.data.alliances.membership {
import common.ArrayCustom;
import common.DateUtil;

import configs.Global;

import model.data.alliances.AllianceMemberRankId;
import model.data.alliances.AllianceMemberStateId;
import model.data.alliances.AllianceUserTroopsStats;
import model.data.map.MapPos;
import model.data.users.troops.Troops;
import model.logic.ServerTimeManager;

public class AllianceMember {


    public var userId:Number;

    public var rankId:int;

    public var state:AllianceMemberState;

    public var canUseAntigen:Boolean;

    public var canMakeDiplomaticDecidions:Boolean;

    public var lastVisitDate:Date;

    public var statsDate:Date;

    public var mobilizersCount:int;

    public var userTroops:Troops;

    public var userTroopsLastWeek:Troops;

    public var userTroopsStats:AllianceUserTroopsStats;

    public var userTroopsStatsLastWeek:AllianceUserTroopsStats;

    public var joinDate:Date;

    public var mapPos:MapPos;

    public var receiveNewMembers:Boolean;

    public var receiveDeleteMembers:Boolean;

    public var lastActivityDate:Date;

    public function AllianceMember() {
        super();
    }

    public static function fromDto(param1:*):AllianceMember {
        var _loc2_:AllianceMember = new AllianceMember();
        _loc2_.userId = param1.u;
        _loc2_.rankId = param1.r;
        _loc2_.state = param1.s == null ? null : AllianceMemberState.fromDto(param1.s);
        _loc2_.mobilizersCount = param1.mc == null ? 0 : int(param1.mc);
        _loc2_.canUseAntigen = param1.c == null ? false : Boolean(param1.c);
        _loc2_.canMakeDiplomaticDecidions = param1.d == null ? false : Boolean(param1.d);
        _loc2_.lastVisitDate = param1.l == null ? null : new Date(param1.l);
        _loc2_.statsDate = param1.w == null ? null : new Date(param1.w);
        _loc2_.joinDate = param1.j == null ? null : new Date(param1.j);
        _loc2_.lastActivityDate = param1.v == null ? new Date(0) : new Date(param1.v);
        _loc2_.mapPos = MapPos.fromDto(param1.m);
        if (param1.n) {
            _loc2_.receiveNewMembers = param1.n.n == null ? false : Boolean(param1.n.n);
            _loc2_.receiveDeleteMembers = param1.n.d == null ? false : Boolean(param1.n.d);
        }
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function toDtos(param1:ArrayCustom):ArrayCustom {
        var _loc3_:AllianceMember = null;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function get isLeader():Boolean {
        return this.rankId == AllianceMemberRankId.LEADER;
    }

    public function get isDeputy():Boolean {
        return this.rankId == AllianceMemberRankId.DEPUTY;
    }

    public function get isActive():Boolean {
        var _loc1_:* = false;
        if (!Global.ALLIANCE_ACTIVITY_ENABLED || this.lastActivityDate == null) {
            return true;
        }
        var _loc2_:int = (ServerTimeManager.serverTimeNow.time - this.lastActivityDate.time) / DateUtil.MILLISECONDS_PER_DAY;
        _loc1_ = _loc2_ <= Global.INACTIVE_USER_STATUS_DELAY_DAYS;
        return _loc1_;
    }

    public function hasGlobalState():Boolean {
        return this.state.stateId == AllianceMemberStateId.GLOBAL_ATTACK || this.state.stateId == AllianceMemberStateId.GLOBAL_DEFENSE;
    }

    public function toDto():* {
        var _loc1_:* = {
            "u": this.userId,
            "r": this.rankId,
            "s": (this.state == null ? null : this.state.toDto()),
            "c": this.canUseAntigen,
            "d": this.canMakeDiplomaticDecidions
        };
        return _loc1_;
    }
}
}
