package model.logic.quests.data {
import flash.utils.Dictionary;

import model.data.UserPrize;

public class TournamentMessageInfo {

    public static const MESSAGE_SUBTYPE_DEFAULT:int = -1;

    public static const MESSAGE_SUBTYPE_MAX_AWARD:int = 1;

    public static const MESSAGE_SUBTYPE_NOT_MAX_AWARD:int = 2;

    public static const MESSAGE_SUBTYPE_WITHOUT_AWARD:int = 3;

    public static const MESSAGE_SUBTYPE_CONSOLATION_AWARD:int = 4;


    public var tournamentTitleInfo:TournamentTitleInfo;

    public var userMessageSubType:int;

    public var allianceMessageSubType:int;

    public var userLeague:int;

    public var userGroup:int;

    public var allianceLeague:int;

    public var userRatingPosition:int;

    public var superLeagueRatingPosition:int;

    public var allianceRatingPosition:int;

    public var userPointsGathered:Dictionary;

    public var alliancePointsGathered:Number;

    public var allianceUserPointsGathered:Number;

    public var globalMultiplier:Number;

    public var allianceMultiplier:Number;

    public var isMultiplierTournament:Boolean;

    public var userPointsBonus:UserPrize;

    public var userRatingBonus:UserPrize;

    public var alliancePointsBonus:UserPrize;

    public var allianceRatingBonus:UserPrize;

    public var superLeagueRatingBonus:UserPrize;

    public var hasUserBonus:Boolean;

    public var hasAllianceBonus:Boolean;

    public var hasUserPointsBonus:Boolean;

    public var hasUserRatingBonus:Boolean;

    public var hasAlliancePointsBonus:Boolean;

    public var hasAllianceRatingBonus:Boolean;

    public var hasSuperLeagueRatingBonus:Boolean;

    public var hasGroupLeagueRatingBonus:Boolean;

    public var trialFinishExpectedDate:Date;

    public var isAllianceTournament:Boolean;

    public var allianceMemberRank:int;

    public var alliancesPerLeague:Array;

    public var userLeagueAwardedMembers:Number;

    public var userRequiredPoints:int;

    public var tournamentStartDate:Date;

    public var tournamentEndDate:Date;

    public var allianceId:int;

    public function TournamentMessageInfo() {
        super();
    }

    public static function fromDto(param1:*):TournamentMessageInfo {
        var _loc3_:* = undefined;
        if (param1 == null) {
            return null;
        }
        var _loc2_:TournamentMessageInfo = new TournamentMessageInfo();
        _loc2_.tournamentTitleInfo = TournamentTitleInfo.fromDto(param1.n);
        _loc2_.userMessageSubType = param1.t;
        _loc2_.allianceMessageSubType = param1.at;
        _loc2_.userLeague = param1.ul;
        _loc2_.userGroup = param1.ug == null ? -1 : int(param1.ug);
        _loc2_.allianceLeague = param1.al;
        _loc2_.userRatingPosition = param1.up + 1;
        _loc2_.superLeagueRatingPosition = param1.sp + 1;
        _loc2_.allianceRatingPosition = param1.ap + 1;
        _loc2_.userPointsGathered = new Dictionary();
        if (param1.pg != null) {
            for each(_loc3_ in param1.pg) {
                _loc2_.userPointsGathered[_loc3_.s] = _loc3_.p;
            }
        }
        _loc2_.alliancePointsGathered = param1.apg;
        _loc2_.allianceUserPointsGathered = param1.aup;
        _loc2_.globalMultiplier = param1.gm;
        _loc2_.allianceMultiplier = param1.am;
        _loc2_.isMultiplierTournament = param1.mt;
        _loc2_.userPointsBonus = param1.ubp == null ? null : UserPrize.fromDto(param1.ubp);
        _loc2_.userRatingBonus = param1.ubr == null ? null : UserPrize.fromDto(param1.ubr);
        _loc2_.alliancePointsBonus = param1.abp == null ? null : UserPrize.fromDto(param1.abp);
        _loc2_.allianceRatingBonus = param1.abr == null ? null : UserPrize.fromDto(param1.abr);
        _loc2_.superLeagueRatingBonus = param1.sbr == null ? null : UserPrize.fromDto(param1.sbr);
        _loc2_.hasUserBonus = param1.hub;
        _loc2_.hasAllianceBonus = param1.hab;
        _loc2_.hasUserPointsBonus = param1.hub;
        _loc2_.hasUserRatingBonus = param1.hur;
        _loc2_.hasAlliancePointsBonus = param1.hab;
        _loc2_.hasAllianceRatingBonus = param1.har;
        _loc2_.hasSuperLeagueRatingBonus = param1.hsb;
        _loc2_.hasGroupLeagueRatingBonus = param1.hgb;
        _loc2_.userRequiredPoints = param1.rp == null ? 0 : int(param1.rp);
        _loc2_.trialFinishExpectedDate = param1.tf == null ? null : new Date(param1.tf);
        _loc2_.isAllianceTournament = param1.it;
        _loc2_.allianceMemberRank = param1.ar;
        _loc2_.userLeagueAwardedMembers = param1.ulm;
        _loc2_.alliancesPerLeague = param1.apl == null ? new Array() : param1.apl;
        _loc2_.tournamentStartDate = new Date(param1.ts);
        _loc2_.tournamentEndDate = new Date(param1.te);
        _loc2_.allianceId = param1.ai == null ? 0 : int(param1.ai);
        return _loc2_;
    }

    public function getAllianceLeagueSize(param1:int):int {
        var _loc2_:int = 0;
        if (param1 > this.alliancesPerLeague.length) {
            _loc2_ = this.alliancesPerLeague[this.alliancesPerLeague.length - 1];
        }
        else {
            _loc2_ = this.alliancesPerLeague[param1 - 1];
        }
        return _loc2_;
    }
}
}
