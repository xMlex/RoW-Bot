package ru.xmlex.row.game.data.users.raids;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 18.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class RaidLocationStoryInfo {
    @Expose
    @SerializedName("i")
    public int storyId;
    @Expose
    @SerializedName("s")
    public int stepId;
}
