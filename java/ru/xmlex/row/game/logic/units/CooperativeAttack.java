package ru.xmlex.row.game.logic.units;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 05.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class CooperativeAttack {
    @Expose
    @SerializedName("e")
    public boolean enabled;
    @Expose
    @SerializedName("s")
    public int maximumSupportUsersint;
    @Expose
    @SerializedName("d")
    public boolean disableSectorAttacks;
}
