package model.data.users.messages {
import common.ArrayCustom;
import common.GameType;
import common.NumberUtil;
import common.queries.util.query;

import configs.Global;

import flash.utils.Dictionary;

import gameObjects.sceneObject.SceneObject;

import model.data.Resources;
import model.data.UserGameData;
import model.data.alliances.AllianceEventsStatistics;
import model.data.map.MapPos;
import model.data.ratings.RatingWinners;
import model.data.scenes.objects.GeoSceneObject;
import model.data.tournaments.TournamentStatistics;
import model.data.units.MapObjectTypeId;
import model.data.units.TroopsTierBattleInfo;
import model.data.users.alliances.UserAllianceData;
import model.data.users.alliances.UserAllianceInvitation;
import model.data.users.alliances.UserAllianceRequest;
import model.data.users.drawings.DrawingPart;
import model.data.users.troops.BattleResult;
import model.data.users.troops.BattleSupporter;
import model.data.users.troops.Troops;
import model.logic.UserManager;
import model.logic.quests.data.QuestState;
import model.logic.quests.data.TournamentMessageInfo;
import model.logic.quests.data.themedEvent.CollectibleThemedItemsEventMessageInfo;

public class Message {


    public var id:Number;

    public var revision:Number;

    public var refUserId:Number;

    public var isRead:Boolean;

    public var addedByClient:Boolean = false;

    public var typeId:int;

    public var time:Date;

    public var userIdFrom:Number;

    public var userIdTo:Number;

    public var text:String;

    public var battleResult:BattleResult;

    public var troops:Troops;

    public var resources:Resources;

    public var statisticsByTournament:Array;

    public var technologyId:int;

    public var technologyLevel:int;

    public var drawingPart:DrawingPart;

    public var drawingPartForFriends:Boolean;

    public var artifactTypeId:int = -1;

    public var messageInventoryItemDataVector:Vector.<MessageInventoryItemData>;

    public var allianceId:Number = 0;

    public var ownAllianceId:Number = 0;

    public var allianceRankId:int;

    public var allianceAchievementTypeId:int;

    public var allianceAchievementLevel:int;

    public var changedUserId:Number;

    public var knownAllianceType:int;

    public var raidLocationId:int;

    public var vipPoints:int;

    public var ratingWinners:RatingWinners;

    public var globalMissionPrototypeId:int;

    public var allianceEventStatistics:AllianceEventsStatistics;

    public var blackMarketItems:Dictionary;

    public var fromMapPos:MapPos;

    public var toMapPos:MapPos;

    public var tournamentInfo:TournamentMessageInfo;

    public var themedEventMessageInfo:CollectibleThemedItemsEventMessageInfo;

    public var unitId:int;

    public var allianceCityMessageInfo:AllianceCityMessageInfo;

    public var depositId:int;

    public var removedSceneObjects:Vector.<SceneObject>;

    public var reinforcementTroopsTiersInfosByUser:Object;

    public function Message() {
        super();
        this.time = new Date();
    }

    public static function fromDto(param1:*):Message {
        var _loc3_:* = undefined;
        var _loc4_:* = undefined;
        var _loc5_:* = undefined;
        var _loc2_:Message = new Message();
        _loc2_.id = param1.h.i;
        _loc2_.revision = param1.h.v;
        _loc2_.refUserId = param1.h.u;
        _loc2_.isRead = param1.h.r;
        _loc2_.typeId = param1.b.t;
        _loc2_.time = new Date(param1.b.a);
        _loc2_.userIdFrom = param1.b.f;
        _loc2_.userIdTo = param1.b.u;
        _loc2_.text = param1.b.x == null ? "" : param1.b.x;
        _loc2_.battleResult = param1.b.b == null ? null : BattleResult.fromDto(param1.b.b);
        _loc2_.troops = param1.b.o == null ? null : Troops.fromDto(param1.b.o);
        _loc2_.resources = param1.b.s == null ? null : Resources.fromDto(param1.b.s);
        _loc2_.statisticsByTournament = param1.b.ts == null ? null : TournamentStatistics.fromDtos(param1.b.ts);
        _loc2_.technologyId = param1.b.h;
        _loc2_.technologyLevel = param1.b.l;
        _loc2_.drawingPart = param1.b.d == null ? null : DrawingPart.fromDto(param1.b.d);
        _loc2_.drawingPartForFriends = param1.b.aa == null ? false : Boolean(param1.b.aa);
        _loc2_.artifactTypeId = param1.b.i == null ? -1 : int(param1.b.i);
        for each(_loc3_ in param1.b.ii) {
            if (!_loc2_.messageInventoryItemDataVector) {
                _loc2_.messageInventoryItemDataVector = new Vector.<MessageInventoryItemData>();
            }
            _loc2_.messageInventoryItemDataVector.push(MessageInventoryItemData.fromDto(_loc3_));
        }
        _loc2_.allianceId = param1.b.c == null ? Number(0) : Number(param1.b.c);
        _loc2_.ownAllianceId = param1.b.p == null ? Number(0) : Number(param1.b.p);
        _loc2_.allianceRankId = param1.b.r == null ? -1 : int(param1.b.r);
        _loc2_.knownAllianceType = param1.b.k == null ? -1 : int(param1.b.k);
        _loc2_.allianceAchievementTypeId = param1.b.y == null ? -1 : int(param1.b.y);
        _loc2_.allianceAchievementLevel = param1.b.v == null ? 1 : int(param1.b.v);
        _loc2_.changedUserId = param1.b.m == null ? Number(-1) : Number(param1.b.m);
        _loc2_.raidLocationId = param1.b.n == null ? -1 : int(param1.b.n);
        _loc2_.ratingWinners = param1.b.z == null ? null : RatingWinners.fromDto(param1.b.z);
        _loc2_.globalMissionPrototypeId = param1.b.g == null ? int(null) : int(param1.b.g);
        _loc2_.allianceEventStatistics = param1.b == null || param1.b.j == null ? null : AllianceEventsStatistics.fromDto(param1.b.j);
        _loc2_.blackMarketItems = new Dictionary();
        if (param1.b != null && param1.b.e != null) {
            for (_loc4_ in param1.b.e) {
                _loc2_.blackMarketItems[_loc4_] = param1.b.e[_loc4_];
            }
        }
        _loc2_.vipPoints = param1.b.w == null ? -1 : int(param1.b.w);
        _loc2_.fromMapPos = param1.b.sp == null ? null : MapPos.fromDto(param1.b.sp);
        _loc2_.toMapPos = param1.b.dp == null ? null : MapPos.fromDto(param1.b.dp);
        _loc2_.tournamentInfo = TournamentMessageInfo.fromDto(param1.b.ti);
        _loc2_.themedEventMessageInfo = CollectibleThemedItemsEventMessageInfo.fromDto(param1.b.cti);
        _loc2_.unitId = param1.b.ui == null ? 0 : int(param1.b.ui);
        _loc2_.allianceCityMessageInfo = param1.b.aci == null ? null : AllianceCityMessageInfo.fromDto(param1.b.aci);
        _loc2_.depositId = param1.b.da == null ? -1 : int(param1.b.da);
        if (param1.b.so) {
            _loc2_.removedSceneObjects = GeoSceneObject.fromDtos(param1.b.so);
        }
        if (param1.b.rt) {
            _loc2_.reinforcementTroopsTiersInfosByUser = {};
            for (_loc5_ in param1.b.rt) {
                _loc2_.reinforcementTroopsTiersInfosByUser[_loc5_] = TroopsTierBattleInfo.fromDtos(param1.b.rt[_loc5_]);
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
        var _loc3_:Message = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function get hasArtifact():Boolean {
        return this.artifactTypeId != -1;
    }

    public function getAdviserTypeId():int {
        return AdviserTypeId.getAdviserTypeIdByMessage(this);
    }

    public function get hasAnyTrophy():Boolean {
        return this.hasBlackMarketItems || this.hasExperience || this.hasWisdomPoints || this.hasResourcesTrophy || this.hasResourcesRobbery || this.hasQuestBonus || this.hasNanopods || this.hasPvpResult || this.hasIncreaseRating || this.hasTroopsTrophy || this.hasVipPoints || this.hasTournamentStatisticTrophy || this.hasInventoryItem || this.hasFlagResult || this.hasCollectibleItems || this.getBattleExperience() > 0;
    }

    public function get hasTournamentStatisticTrophy():Boolean {
        var _loc1_:TournamentStatistics = null;
        if (this.battleResult.statisticsByTournament && this.battleResult.statisticsByTournament.length > 0) {
            for each(_loc1_ in this.battleResult.statisticsByTournament) {
                if (_loc1_.hasAny) {
                    return true;
                }
            }
        }
        return false;
    }

    public function hasTournamentStatisticsType(param1:int):Boolean {
        var statisticsType:int = param1;
        return this.battleResult && this.battleResult.isTowerBattle && this.statisticsByTournament && query(this.statisticsByTournament).any(function (param1:TournamentStatistics):Boolean {
            return param1.containsStatisticsType(statisticsType);
        });
    }

    public function get hasBlackMarketItems():Boolean {
        return this.blackMarketItems && this.moreThanOne(this.blackMarketItems);
    }

    public function get hasExperience():Boolean {
        return this.battleResult != null && this.battleResult.totalExperience > 0;
    }

    public function get hasWisdomPoints():Boolean {
        return Global.WISDOM_SKILLS_ENABLED && this.battleResult != null && this.battleResult.wisdomPoints > 0;
    }

    public function get hasCollectibleItems():Boolean {
        var _loc1_:QuestState = UserManager.user.gameData.questData.activeThemedEvent;
        return _loc1_ != null && this.battleResult.collectibleThemedItemsBonus != null && this.battleResult.collectibleThemedItemsBonus.length > 0 && _loc1_.isActiveOnDate(this.time);
    }

    public function get hasResourcesTrophy():Boolean {
        return this.battleResult && this.battleResult.raidResult && this.battleResult.raidResult.resourcesFound && this.battleResult.raidResult.resourcesFound.getAny() > 0 && this.battleResult.raidResult.resourcesTaken && this.battleResult.raidResult.resourcesTaken.getAny() > 0;
    }

    public function get hasResourcesRobbery():Boolean {
        return this.battleResult && this.battleResult.robberyResult && this.battleResult.robberyResult.totalResources && !this.battleResult.robberyResult.totalResources.isEmpty;
    }

    public function get hasQuestBonus():Boolean {
        return this.battleResult && this.battleResult.raidResult && this.battleResult.raidResult.questBonus > 0;
    }

    public function get hasNanopods():Boolean {
        return this.battleResult && this.battleResult.raidResult && this.battleResult.raidResult.skillPoints > 0;
    }

    public function get hasInventoryItem():Boolean {
        return (GameType.isNords || GameType.isElves || GameType.isSparta || GameType.isTotalDomination) && this.messageInventoryItemDataVector && this.messageInventoryItemDataVector.length > 0;
    }

    public function get hasPvpResult():Boolean {
        return this.battleResult && this.battleResult.pvpPoints > 0 && this.battleResult.raidResult == null;
    }

    public function get hasIncreaseRating():Boolean {
        return this.battleResult && this.battleResult.ratingResult.isIncreaseRating();
    }

    public function get hasTroopsTrophy():Boolean {
        return this.battleResult && this.battleResult.raidResult && this.battleResult.raidResult.troops;
    }

    public function get hasVipPoints():Boolean {
        return this.vipPoints > 0;
    }

    public function get hasFlagResult():Boolean {
        return this.battleResult && this.battleResult.allianceCityFlagResult && this.battleResult.allianceCityFlagResult.flagsSnatched && this.battleResult.allianceCityFlagResult.flagsSnatched.length > 0;
    }

    public function getBattleExperience():Number {
        if (this.battleResult == null) {
            return 0;
        }
        var userTierInfo:Array = this.battleResult.getTierInfoByUser(this.battleResult.refUserId);
        if (userTierInfo == null) {
            return 0;
        }
        var totalBattleExperience:Number = query(userTierInfo).sum(function (param1:TroopsTierBattleInfo):Number {
            var _loc2_:* = param1.experience;
            if (_loc2_ < 1) {
                _loc2_ = NumberUtil.roundDownDecimalToPlace(_loc2_, 1);
            }
            else {
                _loc2_ = _loc2_ >> 0;
            }
            return _loc2_;
        });
        return totalBattleExperience;
    }

    public function getKnownUserIds():Array {
        var _loc2_:BattleSupporter = null;
        var _loc3_:* = undefined;
        var _loc4_:Array = null;
        var _loc5_:* = undefined;
        var _loc1_:Array = [];
        if (!isNaN(this.userIdFrom)) {
            _loc1_.push(this.userIdFrom);
        }
        if (!isNaN(this.userIdTo)) {
            _loc1_.push(this.userIdTo);
        }
        if (this.battleResult != null && this.battleResult.sectorTypeId != MapObjectTypeId.RAID_LOCATION) {
            if (this.battleResult.attackerUserId > 0) {
                _loc1_.push(this.battleResult.attackerUserId);
            }
            if (this.battleResult.defenderUserId > 0) {
                _loc1_.push(this.battleResult.defenderUserId);
            }
            if (this.battleResult.sectorUserId > 0) {
                _loc1_.push(this.battleResult.sectorUserId);
            }
        }
        if (this.battleResult != null && this.battleResult.supporters != null) {
            for each(_loc2_ in this.battleResult.supporters) {
                _loc1_.push(_loc2_.userId);
            }
        }
        if (this.ratingWinners != null) {
            for (_loc3_ in this.ratingWinners.tops) {
                _loc4_ = this.ratingWinners.tops[_loc3_];
                for each(_loc5_ in _loc4_) {
                    _loc1_.push(_loc5_.u);
                }
            }
        }
        if (this.changedUserId > -1) {
            _loc1_.push(this.changedUserId);
        }
        return _loc1_;
    }

    public function getKnownAllianceIds():Array {
        var _loc3_:UserAllianceInvitation = null;
        var _loc4_:UserAllianceRequest = null;
        var _loc6_:Number = NaN;
        var _loc7_:Boolean = false;
        var _loc8_:Number = NaN;
        var _loc1_:Array = new Array();
        var _loc2_:UserAllianceData = UserManager.user.gameData.allianceData;
        if (_loc2_ == null) {
            return _loc1_;
        }
        if (!isNaN(_loc2_.allianceId)) {
            _loc1_.push(_loc2_.allianceId);
        }
        for each(_loc3_ in _loc2_.invitations) {
            _loc1_.push(_loc3_.allianceId);
        }
        for each(_loc4_ in _loc2_.requests) {
            _loc1_.push(_loc4_.allianceId);
        }
        if (!isNaN(this.allianceId) && this.allianceId != 0) {
            _loc1_.push(this.allianceId);
        }
        if (this.battleResult) {
            if (!isNaN(this.battleResult.attackerAllianceId)) {
                _loc1_.push(this.battleResult.attackerAllianceId);
            }
            if (!isNaN(this.battleResult.defenderAllianceId)) {
                _loc1_.push(this.battleResult.defenderAllianceId);
            }
        }
        var _loc5_:Array = new Array();
        for each(_loc6_ in _loc1_) {
            _loc7_ = false;
            for each(_loc8_ in _loc5_) {
                if (_loc8_ == _loc6_) {
                    _loc7_ = true;
                    break;
                }
            }
            if (!_loc7_) {
                _loc5_.push(_loc6_);
            }
        }
        _loc1_ = _loc5_;
        return _loc1_;
    }

    public function getKnownLocationIds():Array {
        var _loc1_:Array = new Array();
        if (!isNaN(this.refUserId)) {
            UserGameData.addLocationId(_loc1_, this.refUserId);
        }
        if (!isNaN(this.userIdFrom)) {
            UserGameData.addLocationId(_loc1_, this.userIdFrom);
        }
        if (!isNaN(this.userIdTo)) {
            UserGameData.addLocationId(_loc1_, this.userIdTo);
        }
        if (this.battleResult != null) {
            UserGameData.addLocationId(_loc1_, this.battleResult.sectorUserId);
            UserGameData.addLocationId(_loc1_, this.battleResult.attackerUserId);
            UserGameData.addLocationId(_loc1_, this.battleResult.defenderUserId);
        }
        return _loc1_;
    }

    private function moreThanOne(param1:Dictionary):Boolean {
        var _loc2_:* = undefined;
        for each(_loc2_ in param1) {
            return true;
        }
        return false;
    }

    public function toDto():* {
        var _loc1_:* = {
            "b": {
                "t": this.typeId,
                "a": this.time.time,
                "f": this.userIdFrom,
                "u": this.userIdTo,
                "x": this.text,
                "b": (this.battleResult == null ? null : this.battleResult.toDto()),
                "o": (this.troops == null ? null : this.troops.toDto()),
                "s": (this.resources == null ? null : this.resources.toDto()),
                "h": this.technologyId,
                "l": this.technologyLevel,
                "d": (this.drawingPart == null ? null : this.drawingPart.toDto()),
                "i": this.artifactTypeId,
                "c": this.allianceId,
                "p": this.ownAllianceId,
                "r": this.allianceRankId,
                "k": this.knownAllianceType,
                "n": this.raidLocationId
            }
        };
        return _loc1_;
    }
}
}
