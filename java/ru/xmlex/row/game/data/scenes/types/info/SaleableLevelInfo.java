package ru.xmlex.row.game.data.scenes.types.info;

import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;

/**
 * Created by xMlex on 4/2/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class SaleableLevelInfo {
    /**
     * Цена улучшения
     */
    @SerializedName("p")
    public Resources price;
    @SerializedName("g")
    public Resources goldPrice;
    @SerializedName("u")
    public int dustPrice = -1;
    /**
     * Время строительства объекта в сек.
     */
    @SerializedName("c")
    public int constructionSeconds;
    @SerializedName("d")
    public int destructionSeconds;
    @SerializedName("l")
    public int requiredUserLevel = 0;
    @SerializedName("b")
    public int constructionBlockPrize;
    @SerializedName("ro")
    public RequiredObject[] requiredObjects = new RequiredObject[]{};
    @SerializedName("a")
    public boolean isAdditionalLevel = false;
}
