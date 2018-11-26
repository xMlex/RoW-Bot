package ru.xmlex.row.game.logic.quests.data;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 4/6/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class QuestState {
    public static final int StateId_New = 0;
    public static final int StateId_InProgress = 5;
    public static final int StateId_Completed = 9;
    @Expose
    @SerializedName("l")
    public int questId;
    @Expose
    @SerializedName("i")
    public int prototypeId;
    @Expose
    @SerializedName("s")
    public int stateId;
    @Expose
    @SerializedName("a")
    public long timeAdded;
    @Expose
    @SerializedName("d")
    public long timeDeadline;
    @Expose
    @SerializedName("t")
    public long timeStarted;
    //
//    public Array completions;
//
//    public ArrayCustom discountItems;
//
//    public Array bonuses:model.logic.quests.data.QuestBonuses;
//
//    public var selectableBonuses;
//
//    public int isWindowOpened;
//
//    public Boolean isRead;
//
//    public int colorIndex;
    @Expose
    @SerializedName("m")
    public long timeToRemind;

    public boolean isComplete() {
        return stateId == StateId_Completed;
    }

    public boolean inProgress() {
        return stateId == StateId_InProgress;
    }
}
