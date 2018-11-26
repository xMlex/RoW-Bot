package model.logic.journal {
public class JournalEventIds {

    public static const SetRevision:int = -1;

    public static const UserChanges:int = 1;

    public static const AllianceHelpAddUserRequest:int = 2;

    public static const AllianceHelpApproveUserRequest:int = 3;

    public static const AllianceHelpRejectUserRequest:int = 4;

    public static const AllianceHelpRemoveUserRequest:int = 5;

    public static const AllianceHelpRespondAttackTarget:int = 6;

    public static const AllianceHelpRespondBuildingTarget:int = 7;

    public static const AllianceHelpRespondOrigin:int = 8;

    public static const AllianceHelpConfirmResources:int = 9;

    public static const AllianceHelpUpdateResponsesGiven:int = 10;

    public static const AllianceHelpAddAllianceRequest:int = 1001;

    public static const AllianceHelpRemoveAllianceRequest:int = 1002;

    public static const AllianceHelpRespondAlliance:int = 1003;


    public function JournalEventIds() {
        super();
    }
}
}
