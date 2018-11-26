package ru.xmlex.row.model;

import java.util.List;
import java.util.logging.Logger;

/**
 * Created by xMlex on 28.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public abstract class SocialAccount extends GameAccount {
    protected static final Logger log = Logger.getLogger(SocialAccount.class.getName());

    private boolean isAuthorized = false;

    public boolean isAuthorized() {
        return isAuthorized;
    }

    public void setAuthorized(boolean authorized) {
        isAuthorized = authorized;
    }

    public void authorization() {
        if (!isAuthorized())
            doAuthorization();
    }

    protected abstract void doAuthorization();

    public abstract String getUserId();

    public abstract String getFirstName();

    public abstract String getLastName();

    public abstract List<String> getFriendsIdList();

    public abstract String getAuthKey();
}
