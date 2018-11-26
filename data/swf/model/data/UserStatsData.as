package model.data {
import common.ArrayCustom;
import common.DateUtil;

import flash.utils.Dictionary;

import gameObjects.observableObject.ObservableObject;

import model.data.alliances.AllianceAchievementUserData;
import model.data.alliances.TerminalDepositData;
import model.data.deposit.DepositInfo;
import model.data.freeGifts.FreeGiftsInfo;
import model.data.giftData.PostGiftInfo;
import model.data.stats.GoldMoneyJournal;
import model.data.users.achievements.Achievement;
import model.data.users.bonuses.Bonus;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;

public class UserStatsData extends ObservableObject {

    public static const CLASS_NAME:String = "UserStatsData";

    public static const STATS_CHANGED:String = CLASS_NAME + "StatsChanged";

    public static const ACHIEVEMENTS_CHANGED:String = CLASS_NAME + "AchievementsChanged";

    public static const DEPOSITS_CHANGED:String = CLASS_NAME + "DepositsChanged";

    public static const FREE_GIFTS_CHANGED:String = CLASS_NAME + "FreeGiftsChanged";

    public static const GoldMoneyJournal_CHANGED:String = CLASS_NAME + "Journal";


    public var achievements:ArrayCustom;

    public var allianceAchievements:ArrayCustom;

    public var bonuses:ArrayCustom;

    public var specialOffersBought:ArrayCustom;

    public var minedResources:Resources;

    public var treasuresCollected:Resources;

    public var reachedTop10:int;

    public var wonRating:int;

    public var liberatedOtherSectors:int;

    public var reinforcementTroopsSent:Number;

    public var functionalBuildingsFinished:int;

    public var functionalBuildingsUpgraded:int;

    public var decorBuildingsFinished:int;

    public var defensiveBuildingsFinished:int;

    public var technologiesLearned:int;

    public var technologiesUpgraded:int;

    public var infantryTroopsBuilt:Number;

    public var armouredTroopsBuilt:Number;

    public var artilleryTroopsBuilt:Number;

    public var aerospaceTroopsBuilt:Number;

    public var attackingTroopsBuilt:Number;

    public var defensiveTroopsBuilt:Number;

    public var successfulIntelligenceCount:Number;

    public var reconTroopsBuilt:Number;

    public var friendsInvitedCount:Number;

    public var ownOffersAccepted:Number;

    public var cyborgsCreated:Number;

    public var clanMembers:int;

    public var invitationSent:int;

    public var registeredFriends:int;

    public var friendsReached15:int;

    public var successfulAttackCount:Number;

    public var caravansSent:Number;

    public var dailyQuestCompleted:Number;

    public var allianceDailyQuestCompleted:Number;

    public var vipDailyQuestCompleted:Number;

    public var goldMoneyJournal:GoldMoneyJournal;

    public var isDepositor:Boolean;

    public var depositsCount:int;

    public var lastDepositDate:Date;

    public var depositByDepositId:Dictionary;

    public var freeGiftsInfo:FreeGiftsInfo;

    public var statsDirty:Boolean = false;

    public var achievementsDirty:Boolean = false;

    public var depositsDirty:Boolean = false;

    public var giftsDirty:Boolean = false;

    public var journalDirty:Boolean = false;

    public var terminalDepositData:TerminalDepositData;

    public var postGiftInfo:PostGiftInfo;

    public function UserStatsData() {
        super();
    }

    public static function fromDto(param1:*):UserStatsData {
        var _loc4_:* = undefined;
        var _loc5_:DepositInfo = null;
        var _loc2_:UserStatsData = new UserStatsData();
        _loc2_.achievements = Achievement.fromDtos(param1.a);
        _loc2_.allianceAchievements = param1.ex == null ? null : AllianceAchievementUserData.fromDtos(param1.ex);
        _loc2_.bonuses = param1.b == null ? new ArrayCustom() : Bonus.fromDtos(param1.b);
        _loc2_.specialOffersBought = param1.h == null ? new ArrayCustom() : SpecialOffer.fromDtos(param1.h);
        _loc2_.minedResources = Resources.fromDto(param1.r);
        _loc2_.treasuresCollected = Resources.fromDto(param1.t);
        _loc2_.reachedTop10 = param1.rt;
        _loc2_.wonRating = param1.wr;
        _loc2_.liberatedOtherSectors = param1.l;
        _loc2_.reinforcementTroopsSent = param1.rs;
        _loc2_.functionalBuildingsFinished = param1.f;
        _loc2_.functionalBuildingsUpgraded = param1.fu;
        _loc2_.decorBuildingsFinished = param1.d;
        _loc2_.defensiveBuildingsFinished = param1.db;
        _loc2_.technologiesLearned = param1.tl;
        _loc2_.technologiesUpgraded = param1.tu;
        _loc2_.infantryTroopsBuilt = param1.ti;
        _loc2_.armouredTroopsBuilt = param1.ta;
        _loc2_.artilleryTroopsBuilt = param1.tr;
        _loc2_.aerospaceTroopsBuilt = param1.tv;
        _loc2_.attackingTroopsBuilt = param1.at;
        _loc2_.defensiveTroopsBuilt = param1.dt;
        _loc2_.reconTroopsBuilt = param1.it;
        _loc2_.successfulIntelligenceCount = param1.i;
        _loc2_.friendsInvitedCount = param1.fi;
        _loc2_.ownOffersAccepted = param1.c;
        _loc2_.cyborgsCreated = param1.cc;
        _loc2_.clanMembers = param1.cm == 0 ? 0 : int(param1.cm);
        _loc2_.goldMoneyJournal = param1.gj == null ? null : GoldMoneyJournal.fromDto(param1.gj);
        _loc2_.depositsCount = param1.p == null ? 0 : int(param1.p.length);
        var _loc3_:* = _loc2_.depositsCount == 0 ? null : param1.p[param1.p.length - 1];
        _loc2_.lastDepositDate = _loc3_ && _loc3_.hasOwnProperty("d") ? new Date(_loc3_.d) : null;
        _loc2_.isDepositor = _loc2_.depositsCount > 0;
        _loc2_.depositByDepositId = new Dictionary();
        if (param1.p) {
            for (_loc4_ in param1.p) {
                _loc5_ = DepositInfo.fromDto(param1.p[_loc4_]);
                _loc2_.depositByDepositId[_loc5_.depositId] = _loc5_;
            }
        }
        _loc2_.freeGiftsInfo = param1.fg == null ? null : FreeGiftsInfo.fromDto(param1.fg);
        _loc2_.invitationSent = param1.si;
        _loc2_.registeredFriends = param1.rf;
        _loc2_.friendsReached15 = param1.fr;
        _loc2_.successfulAttackCount = param1.j;
        _loc2_.caravansSent = param1.cs;
        _loc2_.dailyQuestCompleted = param1.dc;
        _loc2_.allianceDailyQuestCompleted = param1.ac;
        _loc2_.vipDailyQuestCompleted = param1.ec;
        if (param1.tp) {
            _loc2_.terminalDepositData = TerminalDepositData.fromDto(param1.tp) != null ? TerminalDepositData.fromDto(param1.tp) : null;
        }
        if (param1.pg) {
            _loc2_.postGiftInfo = PostGiftInfo.fromDto(param1.pg) != null ? PostGiftInfo.fromDto(param1.pg) : null;
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
        var _loc3_:UserStatsData = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function getAllianceAchievementByType(param1:int):AllianceAchievementUserData {
        var _loc2_:AllianceAchievementUserData = null;
        for each(_loc2_ in this.allianceAchievements) {
            if (_loc2_.typeId == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public function getBoughtOffersCount():int {
        return this.getBoughtOffersCount2(ServerTimeManager.serverTimeNow);
    }

    public function getBoughtOffersCount2(param1:Date):int {
        var _loc3_:SpecialOffer = null;
        var _loc4_:Number = NaN;
        var _loc5_:Number = NaN;
        var _loc2_:int = 0;
        for each(_loc3_ in this.specialOffersBought) {
            if (_loc3_.buyDate != null) {
                _loc4_ = DateUtil.getDatePart(_loc3_.buyDate).time;
                _loc5_ = DateUtil.getDatePart(param1).time;
                if (_loc5_ - _loc4_ <= (StaticDataManager.specialOfferData.specialOfferBuyPeriodDays - 1) * 1000 * 60 * 60 * 24) {
                    _loc2_++;
                }
            }
        }
        return _loc2_;
    }

    public function getNextAvailableTroopsKitDate():Date {
        var _loc1_:Date = ServerTimeManager.serverTimeNow;
        while (this.getBoughtOffersCount2(_loc1_) >= StaticDataManager.specialOfferData.maxBoughtOffersPerDay) {
            _loc1_ = new Date(_loc1_.time + 1000 * 60 * 60 * 24);
        }
        return DateUtil.getDatePart(_loc1_);
    }

    public function dispatchEvents():void {
        if (this.statsDirty == true) {
            this.statsDirty = false;
            dispatchEvent(STATS_CHANGED);
        }
        if (this.achievementsDirty == true) {
            this.achievementsDirty = false;
            dispatchEvent(ACHIEVEMENTS_CHANGED);
        }
        if (this.depositsDirty == true) {
            this.depositsDirty = false;
            dispatchEvent(DEPOSITS_CHANGED);
        }
        if (this.giftsDirty == true) {
            this.giftsDirty = false;
            dispatchEvent(FREE_GIFTS_CHANGED);
        }
        if (this.journalDirty == true) {
            this.journalDirty = false;
            dispatchEvent(GoldMoneyJournal_CHANGED);
        }
    }

    public function getNewAchievement():Achievement {
        var _loc1_:Achievement = null;
        for each(_loc1_ in this.achievements) {
            if (!_loc1_.isRead) {
                return _loc1_;
            }
        }
        return null;
    }

    public function getAnyAchievement():Achievement {
        var _loc1_:Achievement = null;
        for each(_loc1_ in this.achievements) {
            return _loc1_;
        }
        return null;
    }

    public function getFirstAchievement():Achievement {
        if (this.achievements.length > 0) {
            return this.achievements[0];
        }
        return null;
    }

    public function toDto():* {
        var _loc1_:* = {
            "h": SpecialOffer.toDtos(this.specialOffersBought),
            "r": (this.minedResources == null ? null : this.minedResources.toDto()),
            "t": (this.treasuresCollected == null ? null : this.treasuresCollected.toDto()),
            "rt": this.reachedTop10,
            "wr": this.wonRating,
            "l": this.liberatedOtherSectors,
            "rs": this.reinforcementTroopsSent,
            "f": this.functionalBuildingsFinished,
            "fu": this.functionalBuildingsUpgraded,
            "d": this.decorBuildingsFinished,
            "db": this.defensiveBuildingsFinished,
            "tl": this.technologiesLearned,
            "tu": this.technologiesUpgraded,
            "ti": this.infantryTroopsBuilt,
            "ta": this.armouredTroopsBuilt,
            "tr": this.artilleryTroopsBuilt,
            "tv": this.aerospaceTroopsBuilt,
            "at": this.attackingTroopsBuilt,
            "dt": this.defensiveTroopsBuilt,
            "it": this.reconTroopsBuilt,
            "i": this.successfulIntelligenceCount,
            "fi": this.friendsInvitedCount,
            "c": this.ownOffersAccepted,
            "cc": this.cyborgsCreated,
            "gj": this.goldMoneyJournal
        };
        return _loc1_;
    }
}
}
