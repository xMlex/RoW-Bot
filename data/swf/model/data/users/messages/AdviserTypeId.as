package model.data.users.messages {
import common.GameType;

import model.logic.UserManager;

public class AdviserTypeId {

    public static const NONE:int = 0;

    public static const MILITARY:int = 1;

    public static const TRADE:int = 2;

    public static const DIPLOMATIC:int = 3;

    public static const SCIENTIFIC:int = 4;

    public static const PERSONAL_MESSAGE:int = 5;


    public function AdviserTypeId() {
        super();
    }

    public static function getAdviserTypeIdByMessage(param1:Message):int {
        if (param1.typeId == MessageTypeId.ResourcesArrived || param1.typeId == MessageTypeId.DynamicMineResourcesArrived) {
            if (GameType.isNords) {
                return DIPLOMATIC;
            }
            return TRADE;
        }
        if (!isNaN(param1.refUserId)) {
            return DIPLOMATIC;
        }
        if (param1.typeId == MessageTypeId.ReinforcmentArrived || param1.typeId == MessageTypeId.TroopsSentBack || param1.typeId == MessageTypeId.UserUnderNoviceProtection) {
            return MILITARY;
        }
        if (param1.typeId == MessageTypeId.DynamicMineTargetMineHasExpired) {
            return MILITARY;
        }
        if (param1.typeId == MessageTypeId.TeleportationTargetHasMoved || param1.typeId == MessageTypeId.TeleportationTargetIsInactive || param1.typeId == MessageTypeId.AllianceCityUnitsMoveBack) {
            return MILITARY;
        }
        if (param1.typeId == MessageTypeId.BattleResult) {
            if (param1.battleResult.attackerUserId == UserManager.user.id || param1.battleResult.defenderUserId == UserManager.user.id || isNaN(param1.refUserId) || param1.battleResult.allianceCityInfo) {
                return MILITARY;
            }
            if (param1.userIdFrom != UserManager.user.id && param1.userIdTo != UserManager.user.id) {
                return DIPLOMATIC;
            }
        }
        if (param1.typeId == MessageTypeId.DrawingPartArrived || param1.typeId == MessageTypeId.DrawingPartResearched || param1.typeId == MessageTypeId.TechnologyResearched || param1.typeId == MessageTypeId.NewLocationAdded) {
            return SCIENTIFIC;
        }
        if (param1.typeId == MessageTypeId.ClanInvited || param1.typeId == MessageTypeId.ClanAccepted || param1.typeId == MessageTypeId.ClanDeclined || param1.typeId == MessageTypeId.ClanCancelled || param1.typeId == MessageTypeId.AllianceInvited || param1.typeId == MessageTypeId.AllianceRequestAccepted || param1.typeId == MessageTypeId.AllianceRequestDeclined || param1.typeId == MessageTypeId.AllianceRemoved || param1.typeId == MessageTypeId.AllianceRankChanged || param1.typeId == MessageTypeId.AllianceMemberAdded || param1.typeId == MessageTypeId.AllianceMemberDeleted || param1.typeId == MessageTypeId.AllianceMemberRankChanged || param1.typeId == MessageTypeId.AllianceDiplomaticStateOffered || param1.typeId == MessageTypeId.AllianceDiplomaticStateChanged || param1.typeId == MessageTypeId.AllianceDiplomaticStateCancelled || param1.typeId == MessageTypeId.AllianceDiplomaticStateTermination || param1.typeId == MessageTypeId.AllianceDiplomaticStateTerminationCancelled || param1.typeId == MessageTypeId.AllianceDiplomaticStateTerminationConfirmed || param1.typeId == MessageTypeId.AllianceDiplomaticStateTerminated) {
            return DIPLOMATIC;
        }
        return NONE;
    }
}
}
