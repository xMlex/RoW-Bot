package ru.xmlex.row.game.data.scenes.types.info;

import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xMlex on 4/2/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class SaleableTypeInfo {
    public static final List<SaleableLevelInfo> EMPTY_SELABLE_LEVEL_LIST = new ArrayList<>(0);
    @SerializedName("lc")
    public SaleableLevelInfo[] levelInfos = new SaleableLevelInfo[]{};
    @SerializedName("ro")
    public List<RequiredObject> requiredObjects = null;
    @SerializedName("l")
    public int limit;
    @SerializedName("m")
    public boolean requiresAllExistingMaxLevel;

    public SaleableLevelInfo getLevelInfo(int level) {
        return levelInfos[level - 1];
    }

    public int levelsCount() {
        return levelInfos.length;
    }
}
