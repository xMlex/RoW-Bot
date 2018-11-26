package ru.xmlex.row.game.logic.quests.data;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xMlex on 4/6/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserQuestData {
    @Expose
    @SerializedName("q")
    public List<QuestState> openedStates = new ArrayList<>();

    public boolean isAllowStartNew() {
        for (QuestState state : openedStates) {
            if (state.inProgress())
                return false;
        }
        return true;
    }
}
