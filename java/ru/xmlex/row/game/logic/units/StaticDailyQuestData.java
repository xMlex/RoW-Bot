package ru.xmlex.row.game.logic.units;

import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.logic.quests.data.DailyQuestType;

/**
 * Created by xMlex on 30.04.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class StaticDailyQuestData {
    @SerializedName("r")
    public int refreshesNumberPerDay;
    @SerializedName("d")
    public double refreshDelayHours;
    @SerializedName("t")
    public DailyQuestType[] dailyQuestTypes = new DailyQuestType[]{};
    @SerializedName("m")
    public int maximumClosedQuests;
//    @SerializedName("rl")
//    public Dictionary refreshLimitByKind;
//    @SerializedName("cl")
//    public Dictionary questCountBonusByVipLevel;

    public String getNameTypeQuestByTypeId(int id) {
        for (DailyQuestType type : dailyQuestTypes) {
            if (type.id == id)
                return type.nameLocalized.value;
        }
        return "dailyQuestType: " + id;
    }
}
