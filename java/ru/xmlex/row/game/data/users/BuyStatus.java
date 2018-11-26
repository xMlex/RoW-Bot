package ru.xmlex.row.game.data.users;

/**
 * Created by xMlex on 07.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class BuyStatus {
    public static final int OBJECT_CAN_BE_BOUGHT = 0;

    public static final int OBJECT_CANNOT_BE_BOUGHT = 1;

    public static final int NOT_ENOUGH_RESOURCES = 2;

    public static final int REQUIRED_OBJECT_MISSING = 3;

    public static final int OBJECT_OF_SAME_GROUP_IN_PROGRESS = 4;

    public static final int OBJECT_LIMIT_REACHED = 5;

    public static final int MAXIMUM_LEVEL_REACHED = 6;

    public static final int EXISTING_OBJECTS_OF_SAME_TYPE_SHOULD_HAVE_MAX_LEVEL = 7;

    public static final int LOW_USER_LEVEL = 8;

    public static final int NOT_ENOUGHT_BLACK_MARKET_ITEMS = 9;

    public static String getNameById(int id) {
        switch (id) {
            case 0:
                return "OBJECT_CAN_BE_BOUGHT";
            case 1:
                return "OBJECT_CANNOT_BE_BOUGHT";
            case 2:
                return "NOT_ENOUGH_RESOURCES";
            case 3:
                return "REQUIRED_OBJECT_MISSING";
            case 4:
                return "OBJECT_OF_SAME_GROUP_IN_PROGRESS";
            case 5:
                return "OBJECT_LIMIT_REACHED";
            case 6:
                return "MAXIMUM_LEVEL_REACHED";
            case 7:
                return "EXISTING_OBJECTS_OF_SAME_TYPE_SHOULD_HAVE_MAX_LEVEL";
            case 8:
                return "LOW_USER_LEVEL";
            case 9:
                return "NOT_ENOUGHT_BLACK_MARKET_ITEMS";
            default:
                return "Undefined BuyStatus: " + id;
        }
    }
}
