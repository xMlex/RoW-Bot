package model.logic.quests.data {
import common.ArrayCustom;
import common.GameType;
import common.LocalesEnum;
import common.localization.LocaleUtil;

import integration.SocialNetworkIdentifier;

import model.data.UserPrize;
import model.data.quests.QuestPrototypeId;
import model.data.quests.Scale;
import model.data.scenes.types.info.TroopsTypeId;
import model.data.tournaments.TournamentStatistics;
import model.data.tournaments.TournamentStatisticsItem;
import model.data.users.troops.Troops;
import model.logic.UserManager;
import model.logic.ratings.TournamentRatingTypeId;
import model.logic.tournament.GlobalTournamentManager;

public class Quest {


    public var id:int;

    public var prototypeId:int;

    public var categoryId:int;

    public var locationLevel:int;

    public var iconUrl:String;

    public var pictureUrl:String;

    public var boxesBonusPicture:String;

    public var progressBarPictureUrl:String;

    public var eventIconUrl:String;

    public var eventPictureUrl:String;

    public var colorIndex:uint;

    public var name:String;

    public var text:String;

    public var textSteps:Array;

    public var introText:String;

    public var introVoiceUrl:String;

    public var outroText:String;

    public var outroVoiceUrl:String;

    public var outroText2:String;

    public var outroVoiceUrl2:String;

    public var pointsToBonusCoeff:Scale;

    public var alliancePointsToBonusCoeff:Scale;

    public var alliancePointsToBonusCoeffArray:Array;

    public var userPointsBonuses:Array;

    public var alliancePointsBonuses:Array;

    public var userRatingToBonuses:Array;

    public var allianceRatingToBonuses:Array;

    public var tournamentStatisticsWeights:Array;

    public var isAllianceTournament:Boolean;

    public var tournamentAlliancesPerLeague:Array;

    public var userRequiredPoints:int;

    public var tournamentComplexity:int;

    public var tournamentGroupRatingBonuses:Array;

    public var tournamentSuperLeagueBonuses:Scale;

    public var tournamentModules:int;

    public var dailyQuestKind:int;

    public var dailyQuestRareness:int;

    public var dailyQuestTypeId:int;

    public var collectibleThemedItemsEvent:CollectibleThemedItemsEvent;

    public var weight:int;

    public var bonusPercents:Number;

    public var hideOnClient:int;

    public var openWindowUrl:String;

    public var titanitePicture:QuestGiftBoxPictureData;

    public var uraniumPicture:QuestGiftBoxPictureData;

    public var moneyPicture:QuestGiftBoxPictureData;

    private var _bonuses:UserPrize;

    public var _selectableBonuses:Array;

    private var _depositDiscounts:ArrayCustom;

    public function Quest() {
        super();
    }

    public static function fromDto(param1:*):Quest {
        var _loc3_:* = undefined;
        var _loc2_:Quest = new Quest();
        _loc2_.id = param1.l;
        _loc2_.prototypeId = param1.i;
        _loc2_.categoryId = param1.c;
        _loc2_.locationLevel = 10;
        _loc2_.iconUrl = param1.u;
        _loc2_.pictureUrl = param1.p;
        _loc2_.boxesBonusPicture = param1.pb;
        _loc2_.progressBarPictureUrl = param1.pp;
        _loc2_.openWindowUrl = param1.h == null ? "" : param1.h;
        _loc2_.eventIconUrl = param1.ew;
        _loc2_.eventPictureUrl = param1.ou;
        _loc2_.name = param1.n == null ? null : param1.n.c;
        _loc2_.text = param1.t == null ? null : param1.t.c;
        if (param1.s) {
            _loc2_.textSteps = new Array();
            for each(_loc3_ in param1.s) {
                _loc2_.textSteps.push(_loc3_.c);
            }
        }
        _loc2_.introText = param1.r == null ? null : param1.r.c;
        _loc2_.introVoiceUrl = param1.v == null ? null : param1.v.c;
        _loc2_.outroText = param1.o == null ? null : param1.o.c;
        _loc2_.outroVoiceUrl = param1.w == null ? null : param1.w.c;
        _loc2_.outroText2 = param1.g == null ? null : param1.g.c;
        _loc2_.outroVoiceUrl2 = param1.e == null ? null : param1.e.c;
        _loc2_._bonuses = param1.b == null ? null : UserPrize.fromDto(param1.b);
        _loc2_._selectableBonuses = param1.sb == null ? null : SelectableBonusSlot.fromDtos(param1.sb);
        _loc2_.pointsToBonusCoeff = param1.bcp == null ? null : Scale.fromDto(param1.bcp);
        _loc2_.alliancePointsToBonusCoeff = param1.acp == null ? null : Scale.fromDto(param1.acp);
        _loc2_.alliancePointsToBonusCoeffArray = param1.apc == null ? null : Scale.fromDtos(param1.apc);
        _loc2_.userPointsBonuses = param1.ubs == null ? null : Scale.fromDtos(param1.ubs);
        _loc2_.alliancePointsBonuses = param1.abs == null ? null : Scale.fromDtos(param1.abs);
        _loc2_.userRatingToBonuses = param1.lrb == null ? null : Scale.fromDtos(param1.lrb);
        _loc2_.allianceRatingToBonuses = param1.arb == null ? null : Scale.fromDtos(param1.arb);
        _loc2_.tournamentStatisticsWeights = param1.sw == null ? null : TournamentStatisticsItem.fromDtos(param1.sw);
        _loc2_.isAllianceTournament = param1.at;
        _loc2_.userRequiredPoints = param1.up == null ? 0 : int(param1.up);
        _loc2_.tournamentAlliancesPerLeague = param1.al == null ? null : param1.al;
        _loc2_.tournamentGroupRatingBonuses = param1.grb == null ? null : TournamentUserGroup.fromDtos(param1.grb);
        _loc2_.tournamentSuperLeagueBonuses = param1.slb == null ? null : Scale.fromDto(param1.slb);
        _loc2_.tournamentModules = GlobalTournamentManager.getTournamentModulesType(_loc2_);
        _loc2_._depositDiscounts = param1.d == null ? null : QuestDepositDiscount.fromDtos(param1.d);
        _loc2_.titanitePicture = param1.pt == null ? null : QuestGiftBoxPictureData.fromDto(param1.pt);
        _loc2_.uraniumPicture = param1.pu == null ? null : QuestGiftBoxPictureData.fromDto(param1.pu);
        _loc2_.moneyPicture = param1.pm == null ? null : QuestGiftBoxPictureData.fromDto(param1.pm);
        if (_loc2_.prototypeId == QuestPrototypeId.Day1Dragons) {
            return createFakeDay1DragonQuest(_loc2_);
        }
        if (_loc2_.prototypeId == QuestPrototypeId.ComebackPlayer) {
            return createFakeComebackPlayer(_loc2_);
        }
        _loc2_.dailyQuestKind = param1.dk == null ? 0 : int(param1.dk);
        _loc2_.dailyQuestTypeId = param1.dt == null ? 0 : int(param1.dt);
        _loc2_.dailyQuestRareness = param1.dr == null ? 0 : int(param1.dr);
        _loc2_.weight = param1.a == null ? 0 : int(param1.a);
        _loc2_.collectibleThemedItemsEvent = CollectibleThemedItemsEvent.fromDto(param1);
        _loc2_.bonusPercents = param1.bp == null ? Number(0) : Number(param1.bp);
        _loc2_.hideOnClient = param1.hc;
        if (param1.ti) {
            _loc2_.colorIndex = param1.ti;
        }
        _loc2_.tournamentComplexity = param1.tc;
        return _loc2_;
    }

    public static function fromDtos(param1:*):Array {
        var _loc3_:* = undefined;
        var _loc2_:Array = [];
        if (param1 != null) {
            for each(_loc3_ in param1) {
                _loc2_.push(fromDto(_loc3_));
            }
        }
        return _loc2_;
    }

    public static function checkHideOnClientQuest(param1:int):Boolean {
        return (QuestPlatformEnum.Web & param1) == QuestPlatformEnum.Web;
    }

    public static function createFakeDay1DragonQuest(param1:Quest):Quest {
        var _loc2_:Troops = new Troops();
        if (GameType.isSparta) {
            _loc2_.addTroops2(TroopsTypeId.AirUnit3, 2);
        }
        else {
            _loc2_.addTroops2(TroopsTypeId.ArtilleryUnit4, 3);
        }
        param1._bonuses = new UserPrize();
        param1.bonuses.troops = _loc2_;
        return param1;
    }

    public static function createFakeComebackPlayer(param1:Quest):Quest {
        var _loc2_:Troops = new Troops();
        _loc2_.addTroops2(TroopsTypeId.ArtilleryUnit4, 3);
        param1._bonuses = new UserPrize();
        param1.bonuses.troops = _loc2_;
        return param1;
    }

    public static function isWheelOfFortuneQuest(param1:int):Boolean {
        return param1 >= QuestPrototypeId.WheelOfFortuneMin && param1 <= QuestPrototypeId.WheelOfFortuneMax;
    }

    public static function isTreasureQuest(param1:int):Boolean {
        return param1 >= QuestPrototypeId.TreasureMin && param1 <= QuestPrototypeId.TreasureMax;
    }

    public static function isFirstDepositQuest(param1:int):Boolean {
        if (GameType.isNords && (SocialNetworkIdentifier.isFB || SocialNetworkIdentifier.isPP && LocaleUtil.currentLocale != LocalesEnum.RUSSIAN)) {
            return param1 >= QuestPrototypeId.FirstDepositNewMin && param1 <= QuestPrototypeId.FirstDepositNewMax;
        }
        return param1 >= QuestPrototypeId.FirstDepositMin && param1 < QuestPrototypeId.FirstDepositMax;
    }

    public static function isHeroQuest(param1:int):Boolean {
        return param1 == QuestPrototypeId.UseInventoryItem || param1 == QuestPrototypeId.LearnToDustInventoryItem || param1 == QuestPrototypeId.LearnToUpgradeInventoryItem;
    }

    public static function isAvPpack(param1:int):Boolean {
        return param1 >= QuestPrototypeId.AVP_PackMin && param1 <= QuestPrototypeId.AVP_PackMax;
    }

    public static function isWizardQuest(param1:int):Boolean {
        return param1 < QuestPrototypeId.WizardProgress;
    }

    public static function isRaidQuest(param1:int):Boolean {
        switch (param1) {
            case QuestPrototypeId.RobSpecificLevelOfPlayer:
            case QuestPrototypeId.DoNRobberies:
            case QuestPrototypeId.RobSpecificAmountOfResources:
            case QuestPrototypeId.RobSpecificAmountOfResourcesNTimes:
            case QuestPrototypeId.OccupyAndGetResources:
            case QuestPrototypeId.RaidLocationLevel:
            case QuestPrototypeId.FreeOccupiedSector:
            case QuestPrototypeId.KillTroopsInEnemySector:
            case QuestPrototypeId.RaidLocationTimes:
                return true;
            default:
                return false;
        }
    }

    public static function getAlliancePointsToBonusCoeff(param1:Quest, param2:int):Scale {
        var _loc3_:Scale = null;
        var _loc4_:Scale = null;
        if (param2 == 0) {
            param2 = 1;
        }
        for each(_loc4_ in param1.alliancePointsToBonusCoeffArray) {
            if (param2 <= _loc4_.allianceMembersCountMax && param2 >= _loc4_.allianceMembersCountMin) {
                _loc3_ = _loc4_;
                break;
            }
        }
        return _loc3_;
    }

    public function get bonuses():UserPrize {
        var _loc1_:QuestState = null;
        var _loc2_:QuestState = null;
        if (UserManager.user && UserManager.user.gameData && UserManager.user.gameData.questData) {
            _loc1_ = null;
            for each(_loc2_ in UserManager.user.gameData.questData.openedStates) {
                if (_loc2_.questId == this.id) {
                    _loc1_ = _loc2_;
                    break;
                }
            }
            if (_loc1_ && _loc1_.bonuses) {
                return _loc1_.bonuses;
            }
        }
        return this._bonuses;
    }

    public function set bonuses(param1:UserPrize):void {
        this._bonuses = param1;
    }

    public function get selectableBonuses():Array {
        var _loc2_:QuestState = null;
        var _loc1_:QuestState = null;
        for each(_loc2_ in UserManager.user.gameData.questData.openedStates) {
            if (_loc2_.questId == this.id) {
                _loc1_ = _loc2_;
                break;
            }
        }
        if (!_loc1_) {
            return this._selectableBonuses;
        }
        if (_loc1_.selectableBonuses && _loc1_.selectableBonuses.length > 0) {
            return _loc1_.selectableBonuses;
        }
        return this._selectableBonuses;
    }

    public function get depositDiscounts():ArrayCustom {
        var _loc2_:QuestState = null;
        var _loc1_:QuestState = null;
        for each(_loc2_ in UserManager.user.gameData.questData.openedStates) {
            if (_loc2_.questId == this.id) {
                _loc1_ = _loc2_;
                break;
            }
        }
        if (!_loc1_) {
            return this._depositDiscounts;
        }
        if (_loc1_.discountItems && _loc2_.discountItems.length > 0) {
            return _loc1_.discountItems;
        }
        return this._depositDiscounts;
    }

    public function getAllianceLeagueSize(param1:int):int {
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc2_:int = 0;
        if (param1 > this.tournamentAlliancesPerLeague.length) {
            _loc3_ = this.tournamentAlliancesPerLeague[this.tournamentAlliancesPerLeague.length - 1];
            _loc2_ = _loc3_ + _loc3_ / 2;
        }
        else {
            _loc4_ = this.tournamentAlliancesPerLeague[param1 - 1];
            if (param1 < this.tournamentAlliancesPerLeague.length) {
                _loc5_ = this.tournamentAlliancesPerLeague[param1];
                _loc2_ = _loc4_ + _loc5_ / 2;
            }
            else {
                _loc2_ = _loc4_ + _loc4_ / 2;
            }
        }
        return _loc2_;
    }

    public function getTournamentRewardByLeague(param1:int, param2:int, param3:int = -1):Scale {
        var _loc4_:Scale = null;
        switch (param2) {
            case TournamentRatingTypeId.PERSONAL:
                if (param1 < 1 || this.userRatingToBonuses == null || this.userRatingToBonuses.length < param1 - 1) {
                    _loc4_ = null;
                }
                else {
                    _loc4_ = this.userRatingToBonuses[param1 - 1];
                }
                break;
            case TournamentRatingTypeId.ALLIANCE:
                if (param1 < 1 || this.allianceRatingToBonuses == null || this.allianceRatingToBonuses.length < param1 - 1) {
                    _loc4_ = null;
                }
                else {
                    _loc4_ = this.allianceRatingToBonuses[param1 - 1];
                }
                break;
            case TournamentRatingTypeId.PERSONAL_BY_GROUP:
                if (param1 < 1 || param3 == -1 || param3 == 0 || this.tournamentGroupRatingBonuses == null || this.tournamentGroupRatingBonuses.length == 0) {
                    _loc4_ = null;
                }
                else {
                    _loc4_ = this.tournamentGroupRatingBonuses[param3 - 1].bonuses;
                }
                break;
            case TournamentRatingTypeId.PREMIER:
                _loc4_ = this.tournamentSuperLeagueBonuses;
        }
        return _loc4_;
    }

    public function containsStatisticsType(param1:int):Boolean {
        var _loc2_:Boolean = false;
        if (this.tournamentStatisticsWeights != null && this.tournamentStatisticsWeights.length > 0) {
            _loc2_ = TournamentStatistics.containsStatisticsType(this.tournamentStatisticsWeights, param1);
        }
        return _loc2_;
    }
}
}
