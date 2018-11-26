package model.logic.chats.notification.types {
public class AllianceCityNotificationType {

    public static const CITY_REFRESH_EFFECTIVE_LEVELS:int = 1;

    public static const CITY_TECHNOLOGY_UPGRADE_STARTED:int = 2;

    public static const CITY_TECHNOLOGY_UPGRADE_FINISHED:int = 3;

    public static const CITY_UPGRADE_STARTED:int = 4;

    public static const CITY_UPGRADE_FINISHED:int = 5;

    public static const CITY_UNITS_CHANGED:int = 6;

    public static const CITY_CREATED:int = 7;

    public static const CITY_TELEPORTED:int = 8;

    public static const CITY_DOWNGRADE:int = 9;

    public static const CITY_UPGRADE_INTERRUPTED:int = 10;

    public static const ALLIANCE_RESOURCES_CHANGED:int = 100;

    public static const ALLIANCE_ENEMY_CITY_DOWNGRADED:int = 101;

    public static const ALLIANCE_CITY_FLAGS_UPDATED:int = 200;


    public function AllianceCityNotificationType() {
        super();
    }
}
}
