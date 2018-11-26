package model.data.users.messages {
public class MessageTypeId {

    public static const UserMessage:int = 10;

    public static const BattleResult:int = 20;

    public static const ReinforcmentArrived:int = 21;

    public static const TroopsSentBack:int = 22;

    public static const ResourcesArrived:int = 30;

    public static const TechnologyResearched:int = 40;

    public static const DrawingPartResearched:int = 41;

    public static const DrawingPartArrived:int = 42;

    public static const ClanInvited:int = 50;

    public static const ClanAccepted:int = 51;

    public static const ClanDeclined:int = 52;

    public static const ClanCancelled:int = 53;

    public static const AllianceInvited:int = 60;

    public static const AllianceRequestAccepted:int = 61;

    public static const AllianceRequestDeclined:int = 62;

    public static const AllianceRemoved:int = 63;

    public static const AllianceRankChanged:int = 64;

    public static const AllianceAchievementCompleted:int = 65;

    public static const AllianceGlobalMessage:int = 66;

    public static const AllianceMemberAdded:int = 67;

    public static const AllianceMemberRankChanged:int = 68;

    public static const AllianceMemberDeleted:int = 69;

    public static const AllianceDiplomaticStateOffered:int = 90;

    public static const AllianceDiplomaticStateChanged:int = 91;

    public static const AllianceDiplomaticStateCancelled:int = 92;

    public static const AllianceDiplomaticStateTermination:int = 93;

    public static const AllianceDiplomaticStateTerminationCancelled:int = 94;

    public static const AllianceDiplomaticStateTerminationConfirmed:int = 95;

    public static const AllianceDiplomaticStateTerminated:int = 96;

    public static const AllianceDiplomaticEventStateTerminated:int = 97;

    public static const GlobalMissionRating:int = 110;

    public static const PvPQuestRating:int = 120;

    public static const ElderPlayerReturned:int = 121;

    public static const LapidusWithMailToClanLead:int = 130;

    public static const NewLocationAdded:int = 70;

    public static const WeeklyRatingWinners:int = 80;

    public static const WeeklyLoyaltyWinners:int = 81;

    public static const VipStatusSet:int = 100;

    public static const VipContinuationSucceded:int = 131;

    public static const VipContinuationFailed:int = 132;

    public static const RemovedRoadOverlap:int = 134;

    public static const TeleportationSucceeded:int = 140;

    public static const TeleportationFailed:int = 141;

    public static const TeleportationTargetHasMoved:int = 142;

    public static const TeleportationTargetIsInactive:int = 143;

    public static const TournamentFinish:int = 150;

    public static const ThemedEventFinish:int = 151;

    public static const DynamicMineResourcesArrived:int = 160;

    public static const DynamicMineTargetMineHasExpired:int = 161;

    public static const AllianceCityCreationResult:int = 170;

    public static const AllianceCityUpgradeStart:int = 171;

    public static const AllianceCityTechnologyUpgradeStart:int = 172;

    public static const AllianceCityTeleportationResult:int = 180;

    public static const AllianceCityBuyResourcesResult:int = 190;

    public static const AllianceCityUnitsMoveBack:int = 195;

    public static const AggressiveDepositRefund:int = 200;

    public static const AllianceCitiesEnabled:int = 210;

    public static const UserUnderNoviceProtection:int = 220;

    public static const InactiveAllianceDeleted:int = 250;

    public static const DemotionInactiveLeader:int = 251;

    public static const SubstituteDemotionInactiveLeader:int = 252;


    public function MessageTypeId() {
        super();
    }
}
}
