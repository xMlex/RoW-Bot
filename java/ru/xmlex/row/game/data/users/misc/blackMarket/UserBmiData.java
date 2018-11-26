package ru.xmlex.row.game.data.users.misc.blackMarket;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class UserBmiData {
    @Expose
    @SerializedName("i")
    public long typeId;
    @Expose
    @SerializedName("t")
    public long expireDate;
}
