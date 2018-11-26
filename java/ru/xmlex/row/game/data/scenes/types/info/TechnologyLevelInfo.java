package ru.xmlex.row.game.data.scenes.types.info;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;

/**
 * Created by xMlex on 19.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class TechnologyLevelInfo {
//    @Expose
//    @SerializedName("de")
//    public  Dictionary  troopsBonus ;

    //    public  model.data.scenes.types.info.MovingUnitCount  unitCountLimitBonus ;
//
//    public  model.data.scenes.types.info.ArmySize  armySizeLimitBonus ;
    @Expose
    @SerializedName("f")
    public int caravanQuantity;
    @Expose
    @SerializedName("g")
    public int caravanCapacityPercent;
    @Expose
    @SerializedName("h")
    public int caravanSpeed;

    @Expose(deserialize = false, serialize = false)
    public Resources dynamicResourceMiningSpeedPerHour;
    //@Expose(deserialize = false, serialize = false)
    //private TechnologyLevelInfo _nextLevel = new TechnologyLevelInfo();
}
