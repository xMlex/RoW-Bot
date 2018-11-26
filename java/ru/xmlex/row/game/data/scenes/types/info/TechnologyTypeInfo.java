package ru.xmlex.row.game.data.scenes.types.info;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.common.RowName;

/**
 * Created by xMlex on 19.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class TechnologyTypeInfo {
    @Expose(serialize = false)
    @SerializedName("de")
    public RowName bonusDescription = new RowName();
    @Expose(serialize = false)
    @SerializedName("ud")
    public RowName upgradeDescription = new RowName();
    @Expose(serialize = false)
    @SerializedName("lc")
    public TechnologyLevelInfo[] levelInfos;
    @Expose(serialize = false)
    @SerializedName("b")
    public boolean isBlockedForeTrade;

    public TechnologyLevelInfo getLevelInfo(int lvl) {
        return levelInfos[lvl - 1];
    }
}
