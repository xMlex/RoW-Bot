package ru.xmlex.row.game.data.users.troops;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.users.raids.RaidResult;

/**
 * Created by xMlex on 18.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class BattleResult {
    @Expose
    @SerializedName("t")
    public long time;

    @Expose
    @SerializedName("s")
    public int sectorUserId;

    @Expose
    @SerializedName("h")
    public int sectorTypeId;

    public int attackerAllianceId;

    @Expose
    @SerializedName("a")
    public int attackerUserId;

    public int attackerUserAllianceRankId;

    @Expose
    @SerializedName("d")
    public int defenderUserId;

    public int defenderAllianceId;

    public int percentage;

    @Expose
    @SerializedName("o")
    public int attackerTroopsOrder;

    @Expose
    @SerializedName("w")
    public boolean attackerWon;

    public boolean isSectorProtection;

//    public Dictionary attackerLossesPowerByUser;
//
//    public Dictionary defenderLossesPowerByUser;

    @Expose
    @SerializedName("r")
    public int refUserId;

    @Expose
    @SerializedName("i")
    public Troops troopsInitial;

    @Expose
    @SerializedName("l")
    public Troops troopsLosses;

    @Expose
    @SerializedName("e")
    public int experience;

    @Expose
    @SerializedName("e")
    public int newExperience;

    public int pvpPoints;

    @Expose
    @SerializedName("i")
    public Troops friendlytroopsInitial;

    @Expose
    @SerializedName("l")
    public Troops friendlyTroopsLosses;

    @Expose
    @SerializedName("i")
    public Troops opponentTroopsInitial;

    @Expose
    @SerializedName("l")
    public Troops opponentTroopsLosses;

    @Expose
    @SerializedName("b")
    public RobberyResult robberyResult;

//    @Expose
//    @SerializedName("g")
//    public IntelligenceResult intelligenceResult;

    public RaidResult raidResult;

    public int antigenGained;

//    public RatingResult ratingResult;
//
//    @Expose
//    @SerializedName("j")
//    public List<Object> supporters;
//
//    public Array statisticsByTournament;
//
//    public Dictionary attackerEffectsByUserId;
//
//    public Dictionary defenderEffectsByUserId;
//
//    public Array blackMarketItemsByUserId;
//
//    public AllianceCityBattleInfo allianceCityInfo;
}
