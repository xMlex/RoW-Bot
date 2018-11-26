package model.data.alliances.permissionType {
public class AlliancePermissionManager {


    public function AlliancePermissionManager() {
        super();
    }

    public static function accessToDiplomatic(param1:int):Boolean {
        return (param1 | AlliancePermissionType.Diplomatic) == param1;
    }

    public static function accessToStatistics(param1:int):Boolean {
        return (param1 | AlliancePermissionType.Statistics) == param1;
    }

    public static function accessToAntigen(param1:int):Boolean {
        return (param1 | AlliancePermissionType.Antigen) == param1;
    }

    public static function accessToAllianceBoard(param1:int):Boolean {
        return (param1 | AlliancePermissionType.AllianceBoard) == param1;
    }

    public static function accessToChatModerator(param1:int):Boolean {
        return (param1 | AlliancePermissionType.ChatModerator) == param1;
    }

    public static function accessToAttackHelpRequests(param1:int):Boolean {
        return (param1 | AlliancePermissionType.AttackHelpRequests) == param1;
    }

    public static function switchBit(param1:int, param2:int):int {
        return param1 ^ param2;
    }
}
}
