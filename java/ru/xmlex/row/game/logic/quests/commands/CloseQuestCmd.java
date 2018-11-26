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
public class CloseQuestCmd extends BaseCommand {
    @Expose
    @SerializedName("i")
    public final int id;
    @Expose
    @SerializedName("b")
    public final String[] param;

    public CloseQuestCmd(int id, String[] param) {
        this.id = id;
        this.param = param;
    }

    public CloseQuestCmd(int id) {
        this(id, null);
    }

    @Override
    public void onCommandInit() {
        setAction("CloseQuest");

        UserRefreshCmd cmd = new UserRefreshCmd(this);
        cmd.setClient(getClient());
        cmd.onCommandInit();

        setBody(cmd.getBody());
        Quest q = getClient().getUser().userQuestManager.getQuestById(id);
        getClient().logAction("Завершаем квест: " + q.name);
    }

    @Override
    public void onCommandResult(String result) {

    }
}
