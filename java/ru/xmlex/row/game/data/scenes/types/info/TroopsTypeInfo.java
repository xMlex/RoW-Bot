package ru.xmlex.row.game.data.scenes.types.info;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 19.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class TroopsTypeInfo {
    @Expose(serialize = false)
    @SerializedName("lc")
    public TroopsLevelInfo[] levelInfos;
    @Expose(serialize = false)
    @SerializedName("g")
    public int groupId;
    @Expose(serialize = false)
    @SerializedName("k")
    public int kindId;
    //    @Expose
//    @SerializedName("s")
//    public  SupportParameters  supportParameters ;
    @Expose(serialize = false)
    @SerializedName("p")
    public int diePriority;
//    @Expose
//    @SerializedName("m")
//    public  model.data.scenes.types.info.MissileInfo  missileInfo ;

    @Expose(serialize = true)
    @SerializedName("c")
    public int countForBuy = 1;

    public TroopsLevelInfo getLevelInfo(int param1) {
        return this.levelInfos[param1 - 1];
    }
}
