package ru.xmlex.row.game.data.ratings;

import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;

import java.util.List;

/**
 * Created by xMlex on 01.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserPrize {
    public static final int MrCoinsBonusSize01 = 20;

    public static final int MrCoinsBonusSize02 = 70;

    public static final int MrCoinsBonusSize03 = 80;

    public static final int MrCoinsBonusSize05 = 50;

    @SerializedName("r")
    public Resources resources;
    //
//    public DrawingPart drawingPart;
//
//    public Troops troops;
    @SerializedName("e")
    public int experience;
    @SerializedName("s")
    public int skillPoints;

    public List<Integer> artifactTypeIds;

    //public Dictionary blackMarketItems;

    public int blackMarketItemsResourcesPackId;

    public int blackMarketItemsResourcesPackCount;

    public int mobilizers;

    //public ArrayCustom inventoryItems;

    public int bonusesId;

    //public ArrayCustom nonItemsTypeIds;

    public int constructionBlockPrize = 0;
    @SerializedName("v")
    public int vipPoints = 0;

    public int robberyCount = 0;

    public int constructionWorkers = 0;

    public int miniGameCoins = 0;

    public int minUserCollectedCount;

    public int maxUserCollectedCount;

    public int minBonusValueFloor;

    public int minBonusValue;

    public int bonusValueStep;

    //public ArrayCustom sectorSkins;

    //public AllianceResources allianceResources;
}
