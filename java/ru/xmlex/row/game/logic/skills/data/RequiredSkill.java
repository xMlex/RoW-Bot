package ru.xmlex.row.game.logic.skills.data;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 13.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class RequiredSkill {
    @Expose
    @SerializedName("i")
    public int skillTypeId;
    @Expose
    @SerializedName("l")
    public int requiredLevel;
}
