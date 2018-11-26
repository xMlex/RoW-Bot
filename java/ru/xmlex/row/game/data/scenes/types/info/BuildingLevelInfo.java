package ru.xmlex.row.game.data.scenes.types.info;

import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;

/**
 * Created by xMlex on 4/2/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class BuildingLevelInfo {
    @SerializedName("p")
    public Resources protectedResources;
    @SerializedName("r")
    public Resources resources;
    @SerializedName("s")
    public Resources storageLimit;
    @SerializedName("l")
    public Resources localStorageLimit;
    @SerializedName("a")
    public Resources miningAcceleration;
    //    @SerializedName("b")
//    public Dictionary troopsAcceleration;
    @SerializedName("c")
    public int buildingAcceleration = 0;
    @SerializedName("d")
    public int researchAcceleration = 0;
    @SerializedName("e")
    public int numberOfAllies = 0;
    @SerializedName("f")
    public int caravanQuantity = 0;
    @SerializedName("g")
    public int caravanCapacityPercent = 0;
    @SerializedName("h")
    public int caravanSpeed = 0;
    @SerializedName("x")
    public int defenceBonusPoints = 0;
    @SerializedName("y")
    public int defenceIntelligencePoints = 0;
    @SerializedName("rr")
    public int mineRadarRadius = 0;
    @SerializedName("z")
    public int cyborgsPerDay = 0;
    @SerializedName("w")
    public int troopsTypeId = 0;
    @SerializedName("t")
    public int repairSeconds = 0;
    @SerializedName("k")
    public int consumptionBonusPercent = 0;
    @SerializedName("i")
    public int gemCraftLevelLimit = 0;
    @SerializedName("u")
    public int freeLossesRessurectionPercentAttack = 0;
    @SerializedName("ud")
    public int freeLossesRessurectionPercentDefence = 0;
    //    @SerializedName("j")
//    public Dictionary troopsQueueHoursLimit;
    @SerializedName("v")
    public boolean isAdditionalLevel = false;
}
