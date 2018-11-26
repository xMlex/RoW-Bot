package ru.xmlex.row.game.data.units.states;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 06.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UnitStatePendingDepartureBack {
    @Expose
    @SerializedName("d")
    public Long desiredDepartureTime = null;
}
