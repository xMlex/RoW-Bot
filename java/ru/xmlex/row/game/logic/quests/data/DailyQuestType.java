package ru.xmlex.row.game.logic.quests.data;

import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.common.RowName;

/**
 * Created by xMlex on 30.04.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class DailyQuestType {
    @SerializedName("i")
    public int id;
    @SerializedName("l")
    public RowName nameLocalized;
    @SerializedName("u")
    public String iconUrl;
}
