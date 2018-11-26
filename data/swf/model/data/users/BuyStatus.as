package model.data.users {
public class BuyStatus {

    public static const OBJECT_CAN_BE_BOUGHT:int = 0;

    public static const OBJECT_CANNOT_BE_BOUGHT:int = 1;

    public static const NOT_ENOUGH_RESOURCES:int = 2;

    public static const REQUIRED_OBJECT_MISSING:int = 3;

    public static const OBJECT_OF_SAME_GROUP_IN_PROGRESS:int = 4;

    public static const OBJECT_LIMIT_REACHED:int = 5;

    public static const MAXIMUM_LEVEL_REACHED:int = 6;

    public static const EXISTING_OBJECTS_OF_SAME_TYPE_SHOULD_HAVE_MAX_LEVEL:int = 7;

    public static const LOW_USER_LEVEL:int = 8;

    public static const NOT_ENOUGHT_BLACK_MARKET_ITEMS:int = 9;


    public function BuyStatus() {
        super();
    }
}
}
