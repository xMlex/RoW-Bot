package ru.xmlex.row.game.data.users.troops;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 29.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class TroopsLosses {
    @Expose
    @SerializedName("d")
    public long lossesDate;
    @Expose
    @SerializedName("e")
    public long expirationDate;
    @Expose
    @SerializedName("l")
    public Troops losses;
}
