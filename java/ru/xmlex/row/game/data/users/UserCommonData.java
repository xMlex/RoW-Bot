package ru.xmlex.row.game.data.users;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 4/10/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserCommonData {
    @Expose
    @SerializedName("r")
    public long registrationTime;
    @Expose
    @SerializedName("v")
    public long lastVisitTime;
    @Expose
    @SerializedName("v2")
    public long lastVisitTimePrev;
    @Expose
    @SerializedName("l")
    public int loyaltyProgramDaysLeft;
    @Expose
    @SerializedName("lp")
    public int currentLoyalityProgramDay;

    //public var boughtTroopKitIds:ArrayCustom;

    //public var boughtResourceKitIds:ArrayCustom;

    //public var specialOffers:ArrayCustom;

    public boolean kitsDirty;

    public boolean specialOffersDirty = false;

    public long lastReturnDate;
    @Expose
    @SerializedName("i")
    public String inviterUserId;
    @Expose
    @SerializedName("d")
    public int playedDays;

    public int wallpostsCount;

    public long wallpostsLastTime;

    public long nppNextPresentationTime;
    @Expose
    @SerializedName("g")
    public long totalTimeInGame;

    public boolean isVip = false;

    private boolean isVipPre = false;
}
