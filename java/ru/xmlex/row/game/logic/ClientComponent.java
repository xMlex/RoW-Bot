package ru.xmlex.row.game.logic;

import ru.xmlex.row.game.GameClient;

/**
 * Created by xMlex on 01.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class ClientComponent {
    protected GameClient client;

    public GameClient getClient() {
        return client;
    }

    public void setClient(GameClient client) {
        this.client = client;
    }
}
