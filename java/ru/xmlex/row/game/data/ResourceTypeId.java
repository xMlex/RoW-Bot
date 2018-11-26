package ru.xmlex.row.game.data;

/**
 * Created by xMlex on 4/2/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class ResourceTypeId {
    public static final int MONEY = 0;

    public static final int URANIUM = 1;

    public static final int TITANITE = 2;

    public static final int GOLD_MONEY = 3;

    public static final int BIOCHIPS = 4;

    public static final int BLACK_CRYSTALS = 6;

    public static final int BUILDING_UPGRADE = 7;

    public static final int TECHNOLOGY_UPGRADE = 8;

    public static final int TECHNOLOGY_UPGRADE_2 = 9;

    public static final int AVP_MONEY = 10;

    public static final int CONSTRUCTION_ITEMS = 11;

    public static final int RESOURCE_TYPE_BIOPLAZMA = 5;

    public static int[] showDefaultResources = new int[]{
            ResourceTypeId.MONEY, ResourceTypeId.URANIUM, ResourceTypeId.TITANITE, ResourceTypeId.BIOCHIPS, ResourceTypeId.GOLD_MONEY, ResourceTypeId.BLACK_CRYSTALS, ResourceTypeId.AVP_MONEY, ResourceTypeId.CONSTRUCTION_ITEMS
    };

}
