package ru.xmlex.row.game.logic.skills.commands;

import ru.xmlex.row.game.data.commands.BaseCommand;

/**
 * Created by xMlex on 19.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class ImproveSkillCmd extends BaseCommand {

    private int skillTypeId;

    public void ImproveSkillCmd(int id) {
        this.skillTypeId = id;
        setAction("ImproveSkill");

    }

    @Override
    public void onCommandInit() {

    }

    @Override
    public void onCommandResult(String result) {

    }
}
