package model.data.users.alliances {
import common.ArrayCustom;

import flash.utils.Dictionary;

import gameObjects.observableObject.ObservableObject;

import model.data.alliances.AllianceMemberRankId;
import model.data.alliances.chat.AllianceChatRoomData;
import model.modules.allianceHelp.data.user.UserAllianceHelpData;

public class UserAllianceData extends ObservableObject {

    public static const CLASS_NAME:String = "UserAllianceData";

    public static const ALLIANCE_DATA_CHANGED:String = CLASS_NAME + "AllianceDataChanged";


    public var allianceId:Number;

    public var rankId:int;

    public var requests:ArrayCustom;

    public var invitations:ArrayCustom;

    public var mobilizersCount:int;

    public var canUseAntigen:Boolean;

    public var joinDate:Date;

    public var trialFinishExpectedDate:Date;

    public var isTrial:Boolean;

    public var allianceMissions:Dictionary;

    public var rooms:Array;

    public var troopsTrainedPowerPoints:Number;

    public var raidLocationsCompleted:int;

    public var resourcesRobbed:Number;

    public var dailyQuestsCompleted:int;

    public var opponentLossesPowerPoints:Number;

    public var lastHistoryProcessedDate:Date;

    public var allianceHelpData:UserAllianceHelpData;

    public var activityData:UserAllianceActivityData;

    public var dirty:Boolean;

    public function UserAllianceData() {
        this.rooms = new Array();
        super();
    }

    public static function fromDto(param1:*):UserAllianceData {
        var _loc3_:* = undefined;
        var _loc2_:UserAllianceData = new UserAllianceData();
        _loc2_.allianceId = param1.i == null ? Number(Number.NaN) : Number(param1.i);
        _loc2_.rankId = param1.r == null ? -1 : int(param1.r);
        _loc2_.requests = param1.a == null ? new ArrayCustom() : UserAllianceRequest.fromDtos(param1.a);
        _loc2_.invitations = param1.n == null ? new ArrayCustom() : UserAllianceInvitation.fromDtos(param1.n);
        _loc2_.mobilizersCount = param1.mc == null ? 0 : int(param1.mc);
        _loc2_.canUseAntigen = param1.c == null ? false : Boolean(param1.c);
        _loc2_.joinDate = param1.j == null ? null : new Date(param1.j);
        _loc2_.isTrial = param1.t;
        _loc2_.trialFinishExpectedDate = param1.tf == null ? null : new Date(param1.tf);
        _loc2_.allianceMissions = param1.ms == null ? new Dictionary() : parseAllianceMissions(param1.ms);
        _loc2_.troopsTrainedPowerPoints = param1.at;
        _loc2_.raidLocationsCompleted = param1.al;
        _loc2_.resourcesRobbed = param1.ar;
        _loc2_.dailyQuestsCompleted = param1.ad;
        _loc2_.opponentLossesPowerPoints = param1.ak;
        _loc2_.lastHistoryProcessedDate = !!param1.ce ? new Date(param1.ce) : null;
        _loc2_.allianceHelpData = param1.ah == null ? null : UserAllianceHelpData.fromDto(param1.ah);
        _loc2_.activityData = param1.aa == null ? new UserAllianceActivityData() : UserAllianceActivityData.fromDto(param1.aa);
        if (param1.cs) {
            _loc2_.rooms = new Array();
            for (_loc3_ in param1.cs) {
                _loc2_.rooms[_loc3_] = param1.cs[_loc3_] == null ? new AllianceChatRoomData() : AllianceChatRoomData.fromDto(param1.cs[_loc3_]);
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

    public static function toDtos(param1:ArrayCustom):Array {
        var _loc3_:UserAllianceData = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    private static function parseAllianceMissions(param1:*):Dictionary {
        var _loc3_:* = undefined;
        var _loc2_:Dictionary = new Dictionary();
        for each(_loc3_ in param1) {
            if (_loc2_[_loc3_.a] == undefined) {
                _loc2_[_loc3_.a] = new Dictionary();
            }
            _loc2_[_loc3_.a][_loc3_.m] = _loc3_.s;
        }
        return _loc2_;
    }

    public function removeInvitation(param1:UserAllianceInvitation):void {
        var _loc3_:UserAllianceInvitation = null;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in this.invitations) {
            if (!(_loc3_.inviterUserId == param1.inviterUserId && _loc3_.allianceId == param1.allianceId)) {
                _loc2_.addItem(_loc3_);
            }
        }
        this.invitations = _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(ALLIANCE_DATA_CHANGED);
        }
    }

    public function get isInAlliance():Boolean {
        return !isNaN(this.allianceId) && this.rankId < AllianceMemberRankId.INVITED;
    }

    public function sentRequestToClan(param1:int):Boolean {
        var _loc2_:UserAllianceRequest = null;
        for each(_loc2_ in this.requests) {
            if (_loc2_.allianceId == param1) {
                return true;
            }
        }
        return false;
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": (!!isNaN(this.allianceId) ? null : this.allianceId),
            "r": (this.rankId == -1 ? null : this.rankId),
            "a": UserAllianceRequest.toDtos(this.requests),
            "n": UserAllianceInvitation.toDtos(this.invitations),
            "mc": this.mobilizersCount,
            "c": this.canUseAntigen
        };
        return _loc1_;
    }
}
}
