package ru.xmlex.row.game.data.users.misc;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.users.DailyResourceFlow;

/**
 * Created by xMlex on 28.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserResourceFlow {
    @Expose
    @SerializedName("i")
    public int userId;
    @Expose
    @SerializedName("c")
    public int resourceCaravansSentToday;
    @Expose
    @SerializedName("x")
    public DailyResourceFlow[] dailyResourceFlows = new DailyResourceFlow[]{};
}
