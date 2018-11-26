package ru.xmlex.row.game.data;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.logic.quests.data.Quest;

/**
 * Created by xMlex on 18.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserRefresh extends User {
    @Expose
    @SerializedName("e")
    public long refreshTimeoutMs = 0;
    @Expose
    @SerializedName("t")
    public long serverTime = 0;

    @Expose
    @SerializedName("q")
    public Quest[] questData;
    @Expose
    @SerializedName("v")
    public int revision = -1;
}
