package ru.xmlex.row.game.logic.units;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xMlex on 05.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UnitSettings {
    @Expose
    @SerializedName("e")
    public boolean bunkerEnabled;

    @Expose
    @SerializedName("i")
    public boolean minesEnabled;

    @Expose
    @SerializedName("b")
    public boolean bunkerLimitsRobbery;

    @Expose
    @SerializedName("d")
    public boolean dailyIncomingLimitEnabled;

    @Expose
    @SerializedName("m")
    public int dailyIncomingMoneyLimit;

    @Expose
    @SerializedName("u")
    public int dailyIncomingUraniumLimit;

    @Expose
    @SerializedName("t")
    public int dailyIncomingTitaniteLimit;

    @Expose
    @SerializedName("p")
    public int dailyIncomingDrawingsLimit;

    @Expose
    @SerializedName("a")
    public int maximumAttackConsumption;

    @Expose
    @SerializedName("g")
    public int maximumCooperativeAttackConsumption;
    @Expose
    @SerializedName("w")
    public List<Object> maximumTowersAttackConsumption = new ArrayList<>();
    @Expose
    @SerializedName("c")
    public CooperativeAttack cooperativeAttack;

    @Expose
    @SerializedName("s")
    public int maximumMissileStrikeCapacity;

    @Expose
    @SerializedName("o")
    public int userResourcesFlowLimit = 0;

    @Expose
    @SerializedName("r")
    public int userDailyRobberyLimit = 0;

    @Expose
    @SerializedName("mr")
    public int minutesMovingToRaidLocation = -1;

    @Expose
    @SerializedName("y")
    public int fastMovingBoost = 24;

    @Expose
    @SerializedName("v")
    public int reconMovingBoost = 1;

    @Expose
    @SerializedName("z")
    public int troopsMovingBoost = 1;

//    @Expose
//    @SerializedName("av")
//    public model.logic.units.avpSettings avpSettings = new model.logic.units.AvpSettings();
}
