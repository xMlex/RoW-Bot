package ru.xmlex.row.game.data.users;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 28.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class DailyResourceFlow {
    @Expose
    @SerializedName("r")
    public float resources;
    @Expose
    @SerializedName("d")
    public long date;
}
