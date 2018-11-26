package model.data.scenes.types.info {
public class BuildingGroupId {

    public static const NONE:int = -1;

    public static const ADMINISTRATIVE:int = 0;

    public static const MILITARY:int = 1;

    public static const DEFENSIVE:int = 2;

    public static const RESOURCE:int = 3;

    public static const DECOR_FOR_SECTOR:int = 4;

    public static const DECOR_FOR_WALLS:int = 5;

    public static const DECOR_FOR_SECTOR_AND_WALLS:int = 6;

    public static const DECOR_FOR_LAND:int = 7;

    public static const Extension:int = 10;

    public static const SERVER_BLACK_MARKET:int = 8;

    public static const ORE:int = 9;

    public static const ROBOTS:int = 11;

    public static const HIDDEN:int = 100;


    public function BuildingGroupId() {
        super();
    }

    public static function isFunctional(param1:int):Boolean {
        return param1 == ADMINISTRATIVE || param1 == RESOURCE || param1 == MILITARY || param1 == ORE || param1 == SERVER_BLACK_MARKET;
    }

    public static function isDecor(param1:int):Boolean {
        return param1 == DECOR_FOR_LAND || param1 == DECOR_FOR_SECTOR || param1 == DECOR_FOR_SECTOR_AND_WALLS || param1 == HIDDEN;
    }

    public static function checkCanBeOnWalls(param1:int):Boolean {
        return param1 == DECOR_FOR_WALLS || param1 == DECOR_FOR_SECTOR_AND_WALLS;
    }
}
}
