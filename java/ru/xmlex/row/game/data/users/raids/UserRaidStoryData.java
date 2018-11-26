package ru.xmlex.row.game.data.users.raids;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 18.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserRaidStoryData {
    @Expose
    @SerializedName("s")
    public UserStoryInfo storyInfoById;
}
