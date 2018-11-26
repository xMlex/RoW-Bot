package ru.xmlex.row.game.data.commands;

/**
 * Created by xMlex on 29.03.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public interface ICommandAction {
    public abstract void onCommandInit();

    public abstract void onCommandResult(String result);
}
