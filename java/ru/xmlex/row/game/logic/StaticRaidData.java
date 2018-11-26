package ru.xmlex.row.game.logic;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xMlex on 18.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class StaticRaidData {
    @Expose
    @SerializedName("t")
    public List<RaidLocationType> raidLocationTypes = new ArrayList<>();
}
