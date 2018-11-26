package ru.xmlex.row.game.logic.skills.data;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 13.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class SkillLevelInfo {
    @Expose
    @SerializedName("v")
    public double effectValue;
    @Expose
    @SerializedName("t")
    public int improvementSeconds;
}
