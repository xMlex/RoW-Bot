package ru.xmlex.row.game.data.users.acceleration;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.List;

/**
 * Created by xMlex on 06.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class ConstructionData {
//    private static AccelerationBehaviorStandard accelerationBehavior;

    private boolean _constructionWorkersChanged;

    private boolean _constructionAdditionalWorkersChanged;

    private boolean _additionalWorkersUsed;

    private boolean _availableWorkersChanged;

    private boolean _consumptionChanged;

    public int workersUsed = -1;

    //    public Dictionary troopsAcceleration;
    @Expose
    @SerializedName("b")
    public int buildingAcceleration;
    @Expose
    @SerializedName("r")
    public float researchAcceleration;
    @Expose
    @SerializedName("a")
    public int numberOfAllies;
    @Expose
    @SerializedName("q")
    public int caravanQuantity;
    @Expose
    @SerializedName("p")
    public int caravanCapacityPercent;
    @Expose
    @SerializedName("c")
    public int caravanCapacity;
    @Expose
    @SerializedName("pb")
    public int caravanCapacityPercentBoost;
    @Expose
    @SerializedName("x")
    public int caravanSpeedPercent;
    @Expose
    @SerializedName("s")
    public double caravanSpeed;

//    public List<Object> resourceMiningBoosts;
//
//    public List<Object> resourceConsumptionBonusBoosts;

    public boolean resourceMiningBoostAutoRenewal;

    public boolean resourceMiningBoostAutoRenewalMoney;

    public boolean resourceMiningBoostAutoRenewalTitanite;

    public boolean resourceMiningBoostAutoRenewalUranium;

    public boolean resourceConsumptionBonusBoostAutoRenewal;

    public boolean buildTrooperFaster;

    public boolean buildDogFaster;

    public boolean buildReconFaster;

    public int constructionWorkersCount;

    public int consumptionBonusPercent;

    public int currentRepariRobotsCount;

    public boolean freeTechnologiesResearched;

    public List<Object> additionalWorkersExpireDateTimes;

//    public Dictionary troopsQueueHoursLimit;

    public int extraSectorDefenceBonus;

    public int extraSectorDefenceGlobalBonus;

    public int bioplasmConversionAcceleration;

    public int dragonAbilitiesResearchAcceleration;

    public int dragonHitsRefreshTimeAcceleration;
}
