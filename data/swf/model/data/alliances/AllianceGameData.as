package model.data.alliances {
import common.ArrayCustom;

import configs.Global;

import gameObjects.observableObject.ObservableObject;

import model.data.alliances.activityData.AllianceActivityData;
import model.data.alliances.chat.AllianceChatData;
import model.data.alliances.city.AllianceCityData;
import model.data.alliances.clanPurchases.AlliancePurchaseData;
import model.data.alliances.diplomacy.AllianceDiplomacyData;
import model.data.alliances.membership.AllianceInvitation;
import model.data.alliances.membership.AllianceMember;
import model.data.alliances.membership.AllianceMembershipData;
import model.data.alliances.membership.AllianceRequest;
import model.data.alliances.permissionType.AlliancePermissionData;
import model.data.locations.allianceCity.flags.AllianceTacticsData;
import model.data.users.messages.Message;
import model.logic.UserManager;
import model.modules.allianceHelp.data.alliance.AllianceHelpData;
import model.modules.allianceHelp.normalization.AllianceHelpNormalizable;

public class AllianceGameData extends ObservableObject {

    public static const CLASS_NAME:String = "AllianceData";

    public static const DELETION_STATUS_CHANGED:String = CLASS_NAME + "DeletionStatusChanged";

    public static const CITY_DATA_CHANGED:String = CLASS_NAME + "CityDatChanged";

    public static const ACHIEVEMENT_DATA_CHANGED:String = CLASS_NAME + "AchievementDataChanged";

    public static const HELP_DATA_CHANGED:String = CLASS_NAME + "HelpDataChanged";

    public static const TACTICS_DATA_CHANGED:String = CLASS_NAME + "TacticsDataChanged";


    public var revision:Number;

    public var knownAllianceData:KnownAllianceData;

    public var appearanceData:AllianceAppearanceData;

    public var membershipData:AllianceMembershipData;

    public var diplomacyData:AllianceDiplomacyData;

    public var towersData:AllianceTowerData;

    public var achievementData:AllianceAchievementData;

    public var messageData:AllianceMessageData;

    public var academyData:AllianceAcademyData;

    public var deletionInProgres:Boolean;

    public var deletionTime:Date;

    public var creationTime:Date;

    public var lastTimeRenamed:Date;

    public var eventData:AlliancesEventData;

    public var missionData:AllianceMissionData;

    public var permissionData:AlliancePermissionData;

    public var chatData:AllianceChatData;

    public var cityData:AllianceCityData;

    public var helpData:AllianceHelpData;

    public var tacticsData:AllianceTacticsData;

    public var activityData:AllianceActivityData;

    public var purchaseData:AlliancePurchaseData;

    public var dirty:Boolean = false;

    public var clanDataDirty:Boolean = false;

    public var achievementDataDirty:Boolean = false;

    public var tacticsDataDirty:Boolean = false;

    public var normalizationTime:Date;

    public function AllianceGameData() {
        super();
    }

    public static function fromDto(param1:*):AllianceGameData {
        var _loc2_:AllianceGameData = new AllianceGameData();
        _loc2_.revision = param1.r;
        _loc2_.appearanceData = AllianceAppearanceData.fromDto(param1.a);
        _loc2_.membershipData = AllianceMembershipData.fromDto(param1.m);
        _loc2_.knownAllianceData = param1.w == null ? new KnownAllianceData() : KnownAllianceData.fromDto(param1.w);
        _loc2_.diplomacyData = param1.x == null ? new AllianceDiplomacyData() : AllianceDiplomacyData.fromDto(param1.x);
        _loc2_.towersData = param1.t == null ? new AllianceTowerData() : AllianceTowerData.fromDto(param1.t);
        _loc2_.achievementData = param1.h == null ? new AllianceAchievementData() : AllianceAchievementData.fromDto(param1.h);
        _loc2_.messageData = param1.y == null ? new AllianceMessageData() : AllianceMessageData.fromDto(param1.y);
        _loc2_.academyData = param1.n == null ? new AllianceAcademyData() : AllianceAcademyData.fromDto(param1.n);
        _loc2_.deletionInProgres = param1.d;
        _loc2_.deletionTime = param1.e != null ? new Date(param1.e) : null;
        _loc2_.creationTime = param1.b != null ? new Date(param1.b) : null;
        _loc2_.lastTimeRenamed = param1.l != null ? new Date(param1.l) : null;
        _loc2_.eventData = param1.s == null ? new AlliancesEventData() : AlliancesEventData.fromDto(param1.s);
        _loc2_.missionData = param1.k == null ? new AllianceMissionData() : AllianceMissionData.fromDto(param1.k);
        _loc2_.permissionData = param1.p == null ? new AlliancePermissionData() : AlliancePermissionData.fromDto(param1.p);
        _loc2_.chatData = param1.q == null ? new AllianceChatData() : AllianceChatData.fromDto(param1.q);
        _loc2_.cityData = param1.i == null ? null : AllianceCityData.fromDro(param1.i);
        _loc2_.helpData = param1.f == null ? null : AllianceHelpData.fromDto(param1.f);
        _loc2_.tacticsData = param1.td == null ? null : AllianceTacticsData.fromDto(param1.td);
        _loc2_.activityData = param1.aa == null ? null : AllianceActivityData.fromDto(param1.aa);
        _loc2_.purchaseData = param1.gc == null ? null : AlliancePurchaseData.fromDto(param1.gc);
        return _loc2_;
    }

    public static function fromVisitAllianceDto(param1:*):AllianceGameData {
        var _loc2_:AllianceGameData = new AllianceGameData();
        _loc2_.revision = param1.r;
        _loc2_.appearanceData = AllianceAppearanceData.fromDto(param1.a);
        _loc2_.membershipData = AllianceMembershipData.fromDto(param1.m);
        _loc2_.towersData = param1.t == null ? new AllianceTowerData() : AllianceTowerData.fromDto(param1.t);
        _loc2_.achievementData = param1.h == null ? new AllianceAchievementData() : AllianceAchievementData.fromDto(param1.h);
        _loc2_.knownAllianceData = new KnownAllianceData();
        _loc2_.academyData = param1.n == null ? new AllianceAcademyData() : AllianceAcademyData.fromDto(param1.n);
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

    public function getNormalizableList():Array {
        return [AllianceHelpNormalizable.instance];
    }

    public function dispatchEvents():void {
        this.appearanceData.dispatchEvents();
        this.membershipData.dispatchEvents();
        this.diplomacyData.dispatchEvents();
        this.towersData.dispatchEvents();
        this.messageData.dispatchEvents();
        if (this.academyData != null) {
            this.academyData.dispatchEvents();
        }
        if (this.missionData != null) {
            this.missionData.dispatchEvents();
        }
        if (this.permissionData != null) {
            this.permissionData.dispatchEvents();
        }
        if (this.chatData != null) {
            this.chatData.dispatchEvents();
        }
        if (this.activityData != null) {
            this.activityData.dispatchEvents();
        }
        if (this.purchaseData != null) {
            this.purchaseData.dispatchEvents();
        }
        this.knownAllianceData.dispatchEvents();
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(DELETION_STATUS_CHANGED);
        }
        if (this.cityData) {
            this.cityData.dispatchEvents();
        }
        if (this.clanDataDirty) {
            this.clanDataDirty = false;
            dispatchEvent(CITY_DATA_CHANGED);
        }
        if (this.achievementDataDirty) {
            this.achievementDataDirty = false;
            dispatchEvent(ACHIEVEMENT_DATA_CHANGED);
        }
        if (this.helpData && this.helpData.dirty) {
            this.helpData.dirty = false;
            dispatchEvent(HELP_DATA_CHANGED);
        }
        if (this.tacticsDataDirty) {
            this.tacticsDataDirty = false;
            dispatchEvent(TACTICS_DATA_CHANGED);
        }
    }

    public function getKnownAllianceIds():Array {
        var _loc2_:KnownAlliance = null;
        var _loc3_:KnownAllianceRequest = null;
        var _loc4_:Message = null;
        var _loc1_:Array = [];
        if (!this.knownAllianceData) {
            return _loc1_;
        }
        for each(_loc2_ in this.knownAllianceData.knownAlliances) {
            _loc1_.push(_loc2_.allianceId);
        }
        for each(_loc3_ in this.knownAllianceData.knownAlliancesRequests) {
            _loc1_.push(_loc3_.allianceId);
        }
        if (!Global.EXTERNAL_MASSAGES_ENABLED) {
            for each(_loc4_ in UserManager.user.gameData.messageData.messages) {
                if (_loc4_.ownAllianceId != 0 && _loc1_.indexOf(_loc4_.ownAllianceId) < 0) {
                    _loc1_.push(_loc4_.ownAllianceId);
                }
            }
        }
        return _loc1_;
    }

    public function getKnownTowersIds():Array {
        var _loc2_:Number = NaN;
        var _loc1_:Array = [];
        if (!this.towersData) {
            return _loc1_;
        }
        for each(_loc2_ in this.towersData.occupiedTowerIds) {
            _loc1_.push(_loc2_);
        }
        return _loc1_;
    }

    public function getKnownUserIds():Array {
        var _loc2_:Number = NaN;
        var _loc3_:AllianceMember = null;
        var _loc4_:AllianceInvitation = null;
        var _loc5_:AllianceRequest = null;
        var _loc6_:Array = null;
        var _loc7_:Boolean = false;
        var _loc8_:Number = NaN;
        var _loc1_:Array = new Array();
        for each(_loc3_ in this.membershipData.members) {
            _loc1_.push(_loc3_.userId);
        }
        for each(_loc4_ in this.membershipData.invitationsSent) {
            _loc1_.push(_loc4_.userId);
        }
        for each(_loc5_ in this.membershipData.requestsReceived) {
            _loc1_.push(_loc5_.userId);
        }
        _loc6_ = new Array();
        for each(_loc2_ in _loc1_) {
            _loc7_ = false;
            for each(_loc8_ in _loc6_) {
                if (_loc8_ == _loc2_) {
                    _loc7_ = true;
                    break;
                }
            }
            if (!_loc7_) {
                _loc6_.push(_loc2_);
            }
        }
        _loc1_ = _loc6_;
        return _loc1_;
    }

    public function update(param1:AllianceGameData):void {
        if (param1 == null) {
            return;
        }
        this.revision = param1.revision;
        this.updateKnownAllianceData(param1);
        this.updateAppearanceData(param1);
        this.updateMembershipData(param1);
        this.updateDiplomacyData(param1);
        this.updateTowersData(param1);
        this.updateAchievementData(param1.achievementData);
        this.updateMessageData(param1);
        this.updateAcademyData(param1);
        this.updateEventData(param1);
        this.updateMissionData(param1);
        this.updatePermissionData(param1);
        this.updateChatData(param1);
        this.updateCityData(param1);
        this.updateHelpData(param1);
        this.updateTacticsData(param1);
        this.updateActivityData(param1);
        this.updatePurchaseData(param1);
    }

    public function updateAchievementData(param1:AllianceAchievementData):void {
        if (param1 == null) {
            return;
        }
        this.achievementData = param1;
        this.achievementDataDirty = true;
    }

    public function updateTacticsData(param1:AllianceGameData):void {
        if (param1.tacticsData == null) {
            return;
        }
        if (this.tacticsData == null) {
            this.tacticsData = new AllianceTacticsData();
        }
        this.tacticsData.activeEffects = param1.tacticsData.activeEffects;
        this.tacticsData.effectsBonuses = param1.tacticsData.effectsBonuses;
        this.tacticsData.prototypeIds = param1.tacticsData.prototypeIds;
        this.tacticsDataDirty = true;
    }

    public function updateKnownAllianceData(param1:AllianceGameData):void {
        if (param1.knownAllianceData == null) {
            return;
        }
        this.knownAllianceData.knownAlliances = param1.knownAllianceData.knownAlliances;
        this.knownAllianceData.knownAlliancesRequests = param1.knownAllianceData.knownAlliancesRequests;
        this.knownAllianceData.proposal = param1.knownAllianceData.proposal;
        this.knownAllianceData.dirty = true;
    }

    public function updateAppearanceData(param1:AllianceGameData):void {
        if (param1.appearanceData == null) {
            return;
        }
        this.appearanceData.description = param1.appearanceData.description;
        this.appearanceData.flag = param1.appearanceData.flag;
        this.appearanceData.extendedDescription = param1.appearanceData.extendedDescription;
        this.appearanceData.dirty = true;
    }

    public function updateMembershipData(param1:AllianceGameData):void {
        if (param1.membershipData == null) {
            return;
        }
        this.membershipData.invitationsSent = param1.membershipData.invitationsSent;
        this.membershipData.members = param1.membershipData.members;
        this.membershipData.membersAddedByMobilizersCnt = param1.membershipData.membersAddedByMobilizersCnt;
        this.membershipData.membersLimit = param1.membershipData.membersLimit;
        this.membershipData.requiredMemberLevel = param1.membershipData.requiredMemberLevel;
        this.membershipData.newMembersEnabled = param1.membershipData.newMembersEnabled;
        this.membershipData.requestsReceived = param1.membershipData.requestsReceived;
        this.membershipData.mobilizersCount = param1.membershipData.mobilizersCount;
        this.membershipData.mobilizersHistory = param1.membershipData.mobilizersHistory;
        this.membershipData.language = param1.membershipData.language;
        this.membershipData.dirty = true;
    }

    public function updateDiplomacyData(param1:AllianceGameData):void {
        if (param1.diplomacyData == null) {
            return;
        }
        this.diplomacyData.diplomaticStatuses = param1.diplomacyData.diplomaticStatuses;
        this.diplomacyData.dirty = true;
    }

    public function updateTowersData(param1:AllianceGameData):void {
        if (param1.towersData == null) {
            return;
        }
        if (!this.areEqual(this.towersData.membersPermittedToReturnTowerTroops, param1.towersData.membersPermittedToReturnTowerTroops) || !this.areEqual(this.towersData.membersPermittedToReturnTroopsFromSlots, param1.towersData.membersPermittedToReturnTroopsFromSlots)) {
            this.towersData.membersPermittedToReturnTowerTroops = param1.towersData.membersPermittedToReturnTowerTroops;
            this.towersData.membersPermittedToReturnTroopsFromSlots = param1.towersData.membersPermittedToReturnTroopsFromSlots;
            this.towersData.dirtyPermitted = true;
        }
        this.towersData.occupiedTowerIds = param1.towersData.occupiedTowerIds;
        this.towersData.dirty = true;
    }

    public function updateActivityData(param1:AllianceGameData):void {
        if (this.activityData != null) {
            this.activityData.update(param1.activityData);
        }
    }

    public function updatePurchaseData(param1:AllianceGameData):void {
        if (this.purchaseData != null) {
            this.purchaseData.update(param1.purchaseData);
        }
    }

    private function areEqual(param1:Array, param2:Array):Boolean {
        if (param1.length != param2.length) {
            return false;
        }
        var _loc3_:int = param1.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            if (param1[_loc4_] != param2[_loc4_]) {
                return false;
            }
            _loc4_++;
        }
        return true;
    }

    public function updateMessageData(param1:AllianceGameData):void {
        this.messageData.MessageSentDate = param1.messageData.MessageSentDate;
        this.messageData.LeaderDailyMessagesSent = param1.messageData.LeaderDailyMessagesSent;
        this.messageData.DeputiesDailyMessagesSent = param1.messageData.DeputiesDailyMessagesSent;
        this.messageData.dirty = true;
    }

    public function updateAcademyData(param1:AllianceGameData):void {
        if (!this.academyData) {
            return;
        }
        this.academyData.enabled = param1.academyData.enabled;
        this.academyData.minUserLevel = param1.academyData.minUserLevel;
        this.academyData.capacity = param1.academyData.capacity;
        this.academyData.dirty = true;
    }

    public function updateEventData(param1:AllianceGameData):void {
        if (param1.eventData) {
            if (param1.eventData.activeEvents) {
                this.eventData.activeEvents = param1.eventData.activeEvents;
            }
            if (param1.eventData.finishedEvents) {
                this.eventData.finishedEvents = param1.eventData.finishedEvents;
            }
        }
    }

    public function updateMissionData(param1:AllianceGameData):void {
        if (param1.missionData) {
            if (param1.missionData.missions) {
                this.missionData.missions = param1.missionData.missions;
            }
            this.missionData.dirty = true;
        }
    }

    public function updatePermissionData(param1:AllianceGameData):void {
        if (param1.permissionData) {
            if (param1.permissionData.permissionByRank) {
                this.permissionData.permissionByRank = param1.permissionData.permissionByRank;
            }
            this.permissionData.permissionByUserId = param1.permissionData.permissionByUserId;
            this.permissionData.dirty = true;
        }
    }

    public function updateChatData(param1:AllianceGameData):void {
        if (param1.chatData) {
            if (param1.chatData) {
                this.chatData = param1.chatData;
            }
            this.chatData.dirty = true;
        }
    }

    public function updateCityData(param1:AllianceGameData):void {
        if (param1.cityData) {
            if (!this.cityData) {
                this.clanDataDirty = true;
                this.cityData = new AllianceCityData();
            }
            this.cityData.updateDate(param1.cityData);
            this.cityData.dirty = true;
        }
    }

    public function updateHelpData(param1:AllianceGameData):void {
        if (param1.helpData) {
            if (param1.helpData) {
                this.helpData = param1.helpData;
            }
            this.helpData.dirty = true;
        }
    }
}
}
