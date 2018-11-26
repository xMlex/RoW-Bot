package model.data.alliances.membership {
import common.ArrayCustom;
import common.GameType;
import common.UTCTime;

import gameObjects.observableObject.ObservableObject;

import model.data.alliances.AllianceMemberRankId;
import model.data.alliances.permissionType.AlliancePermissionManager;
import model.logic.AllianceManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;

public class AllianceMembershipData extends ObservableObject {

    public static const CLASS_NAME:String = "AllianceMembershipData";

    public static const MEMBERSHIP_CHANGED:String = CLASS_NAME + "MembershipChanged";

    public static const MAX_GLOBAL_STATES_COUNT:int = 2;


    public var members:ArrayCustom;

    public var membersLimit:int;

    public var membersAddedByMobilizersCnt:int;

    public var requiredMemberLevel:int;

    public var newMembersEnabled:Boolean;

    public var requestsReceived:ArrayCustom;

    public var invitationsSent:ArrayCustom;

    public var mobilizersCount:int;

    public var mobilizersHistory:ArrayCustom;

    public var allowedToSeeTroopsStats:ArrayCustom;

    public var language:int;

    public var timeZone:UTCTime;

    public var dirty:Boolean = false;

    public function AllianceMembershipData() {
        super();
    }

    public static function fromDto(param1:*):AllianceMembershipData {
        var _loc2_:AllianceMembershipData = new AllianceMembershipData();
        _loc2_.members = AllianceMember.fromDtos(param1.m);
        _loc2_.membersLimit = param1.l;
        _loc2_.membersAddedByMobilizersCnt = param1.mm;
        _loc2_.requiredMemberLevel = param1.r == null ? -1 : int(param1.r);
        _loc2_.newMembersEnabled = param1.n == null ? true : Boolean(param1.n);
        _loc2_.requestsReceived = AllianceRequest.fromDtos(param1.c);
        _loc2_.invitationsSent = AllianceInvitation.fromDtos(param1.i);
        _loc2_.mobilizersCount = param1.mc == null ? 0 : int(param1.mc);
        _loc2_.mobilizersHistory = MobilizerHistory.fromDtos(param1.mh);
        _loc2_.allowedToSeeTroopsStats = !!param1.s ? new ArrayCustom(param1.s) : new ArrayCustom();
        _loc2_.language = param1.a == null ? 0 : int(param1.a);
        _loc2_.timeZone = new UTCTime(param1.t);
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

    public function removeRequestsReceived(param1:AllianceRequest):void {
        var _loc3_:AllianceRequest = null;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in this.requestsReceived) {
            if (_loc3_.userId != param1.userId) {
                _loc2_.addItem(_loc3_);
            }
        }
        this.requestsReceived = _loc2_;
    }

    public function isUserEnableToSeeStats(param1:Number):Boolean {
        var _loc2_:Object = null;
        var _loc3_:AllianceMember = null;
        var _loc4_:AllianceMember = null;
        if (GameType.isNords) {
            if (AllianceManager.currentAlliance && AllianceManager.currentAlliance.gameData.permissionData.permissionByRank != null) {
                _loc2_ = AllianceManager.currentAlliance.gameData.permissionData.permissionByRank;
            }
            else {
                _loc2_ = StaticDataManager.allianceData.permissionByRank;
            }
            for each(_loc3_ in this.members) {
                if (_loc3_.userId == param1 && AlliancePermissionManager.accessToStatistics(_loc2_[_loc3_.rankId])) {
                    return true;
                }
            }
        }
        else {
            for each(_loc4_ in this.members) {
                if (_loc4_.userId == param1 && this.allowedToSeeTroopsStats.contains(_loc4_.rankId)) {
                    return true;
                }
            }
        }
        return false;
    }

    public function isUserEnableToUseAntigen(param1:Number):Boolean {
        var _loc2_:Object = null;
        var _loc3_:AllianceMember = null;
        if (GameType.isNords) {
            if (AllianceManager.currentAlliance && AllianceManager.currentAlliance.gameData.permissionData.permissionByRank != null) {
                _loc2_ = AllianceManager.currentAlliance.gameData.permissionData.permissionByRank;
            }
            else {
                _loc2_ = StaticDataManager.allianceData.permissionByRank;
            }
            for each(_loc3_ in this.members) {
                if (_loc3_.userId == param1 && AlliancePermissionManager.accessToAntigen(_loc2_[_loc3_.rankId])) {
                    return true;
                }
            }
            return false;
        }
        return UserManager.user.gameData.allianceData.canUseAntigen;
    }

    public function isUserEnableToModerateChat(param1:Number):Boolean {
        var _loc2_:Object = null;
        var _loc3_:AllianceMember = null;
        if (GameType.isNords) {
            if (AllianceManager.currentAlliance && AllianceManager.currentAlliance.gameData.permissionData.permissionByRank != null) {
                _loc2_ = AllianceManager.currentAlliance.gameData.permissionData.permissionByRank;
            }
            else {
                _loc2_ = StaticDataManager.allianceData.permissionByRank;
            }
            for each(_loc3_ in this.members) {
                if (_loc3_.userId == param1 && AlliancePermissionManager.accessToChatModerator(_loc2_[_loc3_.rankId])) {
                    return true;
                }
            }
        }
        return false;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(MEMBERSHIP_CHANGED);
        }
    }

    public function getLeaderId():int {
        var _loc1_:AllianceMember = null;
        for each(_loc1_ in this.members) {
            if (_loc1_.rankId == AllianceMemberRankId.LEADER) {
                return _loc1_.userId;
            }
        }
        return -1;
    }

    public function getMembersId():ArrayCustom {
        var _loc2_:AllianceMember = null;
        var _loc1_:ArrayCustom = new ArrayCustom();
        for each(_loc2_ in this.members) {
            _loc1_.addItem(_loc2_.userId);
        }
        return _loc1_;
    }

    public function getAllianceMatesIds():ArrayCustom {
        var _loc1_:ArrayCustom = this.getMembersId();
        if (_loc1_ != null) {
            _loc1_.removeItemAt(_loc1_.getItemIndex(UserManager.user.id));
        }
        return _loc1_;
    }

    public function getMember(param1:Number):AllianceMember {
        var _loc2_:AllianceMember = null;
        for each(_loc2_ in this.members) {
            if (_loc2_.userId == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public function isMember(param1:Number):Boolean {
        var _loc2_:AllianceMember = null;
        for each(_loc2_ in this.members) {
            if (_loc2_.userId == param1) {
                return true;
            }
        }
        return false;
    }

    public function hasInvitationForUser(param1:int):Boolean {
        var _loc2_:AllianceInvitation = null;
        for each(_loc2_ in this.invitationsSent) {
            if (_loc2_.userId == param1) {
                return true;
            }
        }
        return false;
    }

    public function getGlobalStatesCount():int {
        var _loc2_:AllianceMember = null;
        var _loc1_:int = 0;
        for each(_loc2_ in this.members) {
            if (_loc2_.state) {
                if (_loc2_.hasGlobalState()) {
                    _loc1_++;
                }
                if (_loc1_ == MAX_GLOBAL_STATES_COUNT) {
                    return _loc1_;
                }
            }
        }
        return _loc1_;
    }
}
}
