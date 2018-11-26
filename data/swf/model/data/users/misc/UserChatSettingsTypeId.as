package model.data.users.misc {
public class UserChatSettingsTypeId {

    public static const RADIO_DIPLOMATIC_RELATION:int = 0;

    public static const RADIO_TOWER_ACTION:int = 1;

    public static const RADIO_ACHIEVEMENTS:int = 2;

    public static const RADIO_MINES_ADDED:int = 3;

    public static const RADIO_TOWER_ADDED:int = 4;

    public static const RADIO_WEEKLY_RATING:int = 5;

    public static const ALLIANCE_DIPLOMATIC_RELATION:int = 10;

    public static const ALLIANCE_TOWER_ACTION:int = 11;

    public static const ALLIANCE_ACHIEVEMENTS:int = 12;

    public static const ALLIANCE_MINES_ADDED:int = 13;

    public static const ALLIANCE_TOWER_ADDED:int = 14;

    public static const ALLIANCE_WEEKLY_RATING:int = 15;


    public function UserChatSettingsTypeId() {
        super();
    }

    public static function isRadio(param1:int):Boolean {
        return param1 == RADIO_DIPLOMATIC_RELATION || param1 == RADIO_TOWER_ACTION || param1 == RADIO_ACHIEVEMENTS || param1 == RADIO_MINES_ADDED || param1 == RADIO_TOWER_ADDED || param1 == RADIO_WEEKLY_RATING;
    }

    public static function isAlliance(param1:int):Boolean {
        return param1 == ALLIANCE_DIPLOMATIC_RELATION || param1 == ALLIANCE_TOWER_ACTION || param1 == ALLIANCE_ACHIEVEMENTS || param1 == ALLIANCE_MINES_ADDED || param1 == ALLIANCE_TOWER_ADDED || param1 == ALLIANCE_WEEKLY_RATING;
    }

    public static function allianceToRadio(param1:int):int {
        return param1 - 10;
    }

    public static function radioToAlliance(param1:int):int {
        return param1 + 10;
    }
}
}
