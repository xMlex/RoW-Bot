package ru.xmlex.row.game.data.scenes.types.info;

/**
 * Created by xMlex on 28.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class BuildingGroupId {
    public static final int NONE = -1;

    public static final int ADMINISTRATIVE = 0;

    public static final int MILITARY = 1;

    public static final int DEFENSIVE = 2;

    public static final int RESOURCE = 3;

    public static final int DECOR_FOR_SECTOR = 4;

    public static final int DECOR_FOR_WALLS = 5;

    public static final int DECOR_FOR_SECTOR_AND_WALLS = 6;

    public static final int DECOR_FOR_LAND = 7;

    public static final int Extension = 10;

    public static final int SERVER_BLACK_MARKET = 8;

    public static final int ORE = 9;

    public static final int ROBOTS = 11;

    public static final int HIDDEN = 100;

    public static boolean IsFunctional(int groupId) {
        return groupId == ADMINISTRATIVE || groupId == RESOURCE || groupId == MILITARY || groupId == ORE || groupId == SERVER_BLACK_MARKET;
    }

    public static boolean IsDecor(int groupId) {
        return groupId == DECOR_FOR_LAND || groupId == DECOR_FOR_SECTOR || groupId == DECOR_FOR_SECTOR_AND_WALLS || groupId == HIDDEN;
    }

    public static boolean CheckCanBeOnWalls(int groupId) {
        return groupId == DECOR_FOR_WALLS || groupId == DECOR_FOR_SECTOR_AND_WALLS;
    }
}
