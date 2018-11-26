package ru.xmlex.row.model;

import ru.xmlex.row.game.db.models.Accounts;

/**
 * Created by xMlex on 28.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public abstract class GameAccount {
    private Accounts account;
    private String login, password;

    public String getLogin() {
        return account.getLogin();
    }

    public String getPassword() {
        return account.getPassword();
    }

    public Accounts getAccount() {
        return account;
    }

    public void setAccount(Accounts account) {
        this.account = account;
    }
}
