package model.logic.chats {
import common.ArrayCustom;
import common.DateUtil;
import common.StringUtil;
import common.localization.LocaleUtil;

import model.data.alliances.AllianceAchievementType;
import model.data.alliances.AllianceEventsStatistics;
import model.data.alliances.AllianceNote;
import model.data.map.MapPos;
import model.logic.AllianceManager;
import model.logic.AllianceNoteManager;
import model.logic.StaticDataManager;

public class AdministrativeChatMessage {


    private const LABEL_ENEMY_REQUEST_ACCEPTED:String = "controls-friends-chat-chatControl-enemyRequestAccepted";

    private const LABEL_WAR_REQUEST_ACCEPT:String = "controls-friends-chat-chatControl-warRequestAccept";

    private const LABEL_WAR_REQUEST_DECLINED:String = "controls-friends-chat-chatControl-warRequestDeclined";

    private const LABEL_WAR_CANCELED:String = "controls-friends-chat-chatControl-warCanceled";

    private const LABEL_CHALLENGE_REQUEST_ACCEPT:String = "controls-friends-chat-chatControl-challengeRequestAccept";

    private const LABEL_CHALLENGE_REQUEST_DECLINED:String = "controls-friends-chat-chatControl-challengeRequestDeclined";

    private const LABEL_CHALLENGE_FINISHED:String = "controls-friends-chat-chatControl-challengeFinished";

    private const LABEL_WINNER_PVP_QUEST:String = "controls-friends-chat-chatControl-winnerPvpQuest";

    private const LABEL_TOWER_OCCUPIED:String = "controls-friends-chat-chatControl-towerOccupied";

    private const LABEL_TOWER_OCCUPIED2:String = "controls-friends-chat-chatControl-towerOccupied2";

    private const LABEL_TOWER_OCCUPIED3:String = "controls-friends-chat-chatControl-towerOccupied3";

    private const LABEL_TOWER_UPGRADED:String = "controls-friends-chat-chatControl-towerUpgraded";

    private const LABEL_WEEKLY_RATING_UPDATED:String = LocaleUtil.getText("controls-friends-chat-chatControl-weeklyRatingUpdated");

    private const LABEL_RESOURCE_MINE_ADDED:String = LocaleUtil.getText("controls-friends-chat-chatControl-resourceMinesAdded");

    private const LABEL_ARTIFACT_MINES_ADDED:String = LocaleUtil.getText("controls-friends-chat-chatControl-artifactMinesAdded");

    private const LABEL_TOWERS_ADDED:String = LocaleUtil.getText("controls-friends-chat-chatControl-towersAdded");

    private const LABEL_USER_BANNED_UNTIL:String = "controls-friends-chat-chatControl-userBanned_until";

    private const LABEL_USER_BANNED_FOREVER:String = "controls-friends-chat-chatControl-userBanned_forever";

    private const LABEL_TOWER_SLOTS_AVAILABLE:String = LocaleUtil.getText("controls-friends-chat-chatControl-towerSlotsAvailable");

    private const LABEL_LOYALTY_RATING_WINNER_60:String = "controls-friends-chat-chatControl-loyaltyRatingWinner60";

    private const LABEL_LOYALTY_RATING_WINNER_90:String = "controls-friends-chat-chatControl-loyaltyRatingWinner90";

    private const LABEL_ALLIANCE_TOURNAMENT_FLAG_RETURNED:String = "controls-friends-chat-chatControl-allianceTournamentFlagReturned";

    private const LABEL_ALLIANCE_TOURNAMENT_EFFECT_APPLIED:String = "controls-friends-chat-chatControl-allianceTournamentEffectApplied";

    private const LABEL_ALLIANCE_TOURNAMENT_EFFECT_SENT:String = "controls-friends-chat-chatControl-allianceTournamentEffectSent";

    private const LABEL_ALLIANCE_TOURNAMENT_FLAG_STOLEN:String = "controls-friends-chat-chatControl-allianceTournamentFlagStolen";

    private const LABEL_ALLIANCE_TOURNAMENT_FLAG_STOLEN_BACK:String = "controls-friends-chat-chatControl-allianceTournamentFlagStolenBack";

    public var messageType:int;

    public var userId:int;

    public var userPos:MapPos;

    public var userFullName:String;

    public var allianceA:int;

    public var allianceB:int;

    public var allianceNameA:String;

    public var allianceNameB:String;

    public var towerId:int;

    public var towerNumber:int;

    public var towerLevel:int;

    public var towerPos:MapPos;

    public var achievementTypeId:int;

    public var achievementLevel:int;

    public var allianceStatistics:AllianceEventsStatistics;

    public var points:int;

    public var bannedUntil:Date;

    public var banReason:String;

    public function AdministrativeChatMessage() {
        super();
    }

    public static function fromDto(param1:*):AdministrativeChatMessage {
        if (param1 == null) {
            return null;
        }
        var _loc2_:AdministrativeChatMessage = new AdministrativeChatMessage();
        _loc2_.messageType = param1.t;
        _loc2_.userId = param1.u;
        _loc2_.userPos = param1.g == null ? new MapPos(0, 0) : MapPos.fromDto(param1.g);
        _loc2_.userFullName = param1.f == null ? "" : param1.f;
        _loc2_.allianceA = param1.a;
        _loc2_.allianceB = param1.b;
        _loc2_.allianceNameA = param1.z == null ? "" : param1.z;
        _loc2_.allianceNameB = param1.x == null ? "" : param1.x;
        _loc2_.towerId = param1.i;
        _loc2_.towerNumber = param1.n;
        _loc2_.towerLevel = param1.l;
        _loc2_.towerPos = param1.p == null ? new MapPos(0, 0) : MapPos.fromDto(param1.p);
        _loc2_.achievementTypeId = param1.c;
        _loc2_.achievementLevel = param1.h;
        _loc2_.allianceStatistics = param1.e == null ? null : AllianceEventsStatistics.fromDto(param1.e);
        _loc2_.points = param1.s;
        _loc2_.bannedUntil = param1.m == null ? null : new Date(param1.m);
        _loc2_.banReason = param1.j;
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

    public function get name():String {
        return LocaleUtil.getText("controls-friends-chat-chatControl-admin");
    }

    public function get text():String {
        var _loc1_:String = null;
        switch (this.messageType) {
            case ChatMessageType.LOYALTY_SPECIAL_DAY_ACHIEVED:
                _loc1_ = this.loyaltyBuildText();
                break;
            case ChatMessageType.ENEMY_REQUEST_ACCEPTED:
                _loc1_ = this.diplomaticRelationBuildText(this.LABEL_ENEMY_REQUEST_ACCEPTED);
                break;
            case ChatMessageType.WAR_REQUEST_ACCEPT:
                _loc1_ = this.diplomaticRelationBuildText(this.LABEL_WAR_REQUEST_ACCEPT);
                break;
            case ChatMessageType.WAR_REQUEST_DECLINED:
                _loc1_ = this.diplomaticRelationBuildText(this.LABEL_WAR_REQUEST_DECLINED);
                break;
            case ChatMessageType.WAR_CANCELED:
                _loc1_ = this.diplomaticRelationBuildText(this.LABEL_WAR_CANCELED);
                break;
            case ChatMessageType.CHALLENGE_REQUEST_ACCEPT:
                _loc1_ = this.diplomaticRelationBuildText(this.LABEL_CHALLENGE_REQUEST_ACCEPT);
                break;
            case ChatMessageType.CHALLENGE_REQUEST_DECLINED:
                _loc1_ = this.diplomaticRelationBuildText(this.LABEL_CHALLENGE_REQUEST_DECLINED);
                break;
            case ChatMessageType.CHALLENGE_FINISHED:
                _loc1_ = this.diplomaticRelationBuildText(this.LABEL_CHALLENGE_FINISHED);
                break;
            case ChatMessageType.TOWER_OCCUPIED:
                if (this.allianceA && this.allianceB) {
                    _loc1_ = LocaleUtil.buildString(this.LABEL_TOWER_OCCUPIED, this.allianceNameA, this.towerNumber, this.towerLevel, this.towerPos.x, this.towerPos.y, this.allianceNameB);
                }
                else if (this.allianceA) {
                    _loc1_ = LocaleUtil.buildString(this.LABEL_TOWER_OCCUPIED2, this.allianceNameA, this.towerNumber, this.towerLevel, this.towerPos.x, this.towerPos.y);
                }
                else {
                    _loc1_ = LocaleUtil.buildString(this.LABEL_TOWER_OCCUPIED3, this.towerNumber, this.towerLevel, this.towerPos.x, this.towerPos.y, this.allianceNameB);
                }
                break;
            case ChatMessageType.TOWER_UPGRADED:
                _loc1_ = LocaleUtil.buildString(this.LABEL_TOWER_UPGRADED, this.allianceNameA, this.towerNumber, this.towerPos.x, this.towerPos.y, this.towerLevel);
                break;
            case ChatMessageType.ALLIANCE_ACHIEVEMENT_RECEIVED:
                _loc1_ = this.allianceAchievementReceived;
                break;
            case ChatMessageType.WEEKLY_RATING_UPDATED:
                _loc1_ = this.LABEL_WEEKLY_RATING_UPDATED;
                break;
            case ChatMessageType.RESOURCE_MINES_ADDED:
                _loc1_ = this.LABEL_RESOURCE_MINE_ADDED;
                break;
            case ChatMessageType.ARTIFACT_MINES_ADDED:
                _loc1_ = this.LABEL_ARTIFACT_MINES_ADDED;
                break;
            case ChatMessageType.TOWERS_ADDED:
                _loc1_ = this.LABEL_TOWERS_ADDED;
                break;
            case ChatMessageType.PVP_RATING_WINNER:
                _loc1_ = LocaleUtil.buildString(this.LABEL_WINNER_PVP_QUEST, this.userFullName, this.points);
                break;
            case ChatMessageType.ALLIANCE_TOURNAMENT_EFFECT_APPLIED:
                _loc1_ = this.allianceEffectAppliedMessage;
                break;
            case ChatMessageType.ALLIANCE_TOURNAMENT_EFFECT_SENT:
                _loc1_ = LocaleUtil.buildString(this.LABEL_ALLIANCE_TOURNAMENT_EFFECT_SENT, this.allianceNameA);
                break;
            case ChatMessageType.ALLIANCE_TOURNAMENT_FLAG_RETURNED:
                _loc1_ = LocaleUtil.buildString(this.LABEL_ALLIANCE_TOURNAMENT_FLAG_RETURNED, this.allianceNameA);
                break;
            case ChatMessageType.ALLIANCE_TOURNAMENT_FLAG_STOLEN:
                _loc1_ = this.flagOwnerChangedMessage;
                break;
            case ChatMessageType.CHAT_BAN:
                if (this.bannedUntil != null) {
                    _loc1_ = LocaleUtil.buildString(this.LABEL_USER_BANNED_UNTIL, this.userFullName, DateUtil.formatSimpleDateYYMMDDHHMMSS(this.bannedUntil), this.banReason == null ? "" : this.banReason);
                }
                else {
                    _loc1_ = LocaleUtil.buildString(this.LABEL_USER_BANNED_FOREVER, this.userFullName, this.banReason == null ? "" : this.banReason);
                }
                break;
            case ChatMessageType.USER_MESSAGE:
                _loc1_ = null;
            case ChatMessageType.TOWER_SLOTS_AVAILABLE:
                _loc1_ = this.LABEL_TOWER_SLOTS_AVAILABLE;
        }
        return _loc1_;
    }

    private function loyaltyBuildText():String {
        var _loc1_:String = null;
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc2_:String = "";
        if (this.userPos.x != 0 && this.userPos.y != 0) {
            _loc3_ = this.userPos.x;
            _loc4_ = this.userPos.y;
            _loc2_ = _loc3_.toString() + "; " + _loc4_.toString();
        }
        else {
            _loc2_ = "?; ?";
        }
        switch (this.points) {
            case 60:
                _loc1_ = LocaleUtil.buildString(this.LABEL_LOYALTY_RATING_WINNER_60, this.userFullName, _loc2_);
                break;
            case 90:
                _loc1_ = LocaleUtil.buildString(this.LABEL_LOYALTY_RATING_WINNER_90, this.userFullName, _loc2_);
        }
        return _loc1_;
    }

    private function diplomaticRelationBuildText(param1:String):String {
        var _loc2_:String = null;
        var _loc3_:String = null;
        var _loc4_:AllianceNote = null;
        var _loc5_:AllianceNote = null;
        if (this.allianceNameA) {
            _loc2_ = this.allianceNameA;
        }
        else {
            _loc4_ = AllianceNoteManager.getById(this.allianceA);
            _loc2_ = _loc4_.name;
        }
        if (this.allianceNameB) {
            _loc3_ = this.allianceNameB;
        }
        else {
            _loc5_ = AllianceNoteManager.getById(this.allianceB);
            _loc3_ = _loc5_.name;
        }
        return LocaleUtil.buildString(param1, _loc2_, _loc3_);
    }

    private function get allianceEffectAppliedMessage():String {
        if (this.allianceA != 0) {
            return LocaleUtil.buildString(this.LABEL_ALLIANCE_TOURNAMENT_EFFECT_APPLIED, this.allianceNameA);
        }
        return LocaleUtil.buildString(this.LABEL_ALLIANCE_TOURNAMENT_EFFECT_APPLIED, this.allianceNameB);
    }

    private function get flagOwnerChangedMessage():String {
        if (AllianceManager.currentAlliance) {
            if (AllianceManager.currentAlliance.id == this.allianceA) {
                return LocaleUtil.buildString(this.LABEL_ALLIANCE_TOURNAMENT_FLAG_STOLEN_BACK, this.allianceNameB);
            }
            return LocaleUtil.buildString(this.LABEL_ALLIANCE_TOURNAMENT_FLAG_STOLEN, this.allianceNameA);
        }
        return StringUtil.EMPTY;
    }

    private function get allianceAchievementReceived():String {
        var _loc1_:AllianceAchievementType = StaticDataManager.allianceData.getAchievementType(this.achievementTypeId);
        return LocaleUtil.buildString("controls-friends-chat-chatControl-allianceAchievementReceived", this.allianceNameA, _loc1_.textName, this.achievementLevel);
    }
}
}
