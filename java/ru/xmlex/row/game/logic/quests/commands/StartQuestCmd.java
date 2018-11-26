package ru.xmlex.row.game.logic.quests.commands;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.commands.BaseCommand;
import ru.xmlex.row.game.data.commands.UserRefreshCmd;
import ru.xmlex.row.game.logic.quests.data.Quest;

/**
 * Created by xMlex on 01.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class StartQuestCmd extends BaseCommand {
    @Expose
    @SerializedName("i")
    public final int id;
    @Expose
    @SerializedName("a")
    public final boolean param;

    public StartQuestCmd(int questId, boolean param) {
        id = questId;
        this.param = param;
    }

    public StartQuestCmd(int questId) {
        this(questId, false);
    }

    @Override
    public void onCommandInit() {
        setAction("StartQuest");

        UserRefreshCmd cmd = new UserRefreshCmd(this);
        cmd.setClient(getClient());
        cmd.onCommandInit();

        setBody(cmd.getBody());

        Quest q = getClient().getUser().userQuestManager.getQuestById(id);
        getClient().logAction("Начинаем квест: " + q.name);
    }

    @Override
    public void onCommandResult(String result) {

    }
}
