package ru.xmlex.row.game.logic;

/**
 * Created by xMlex on 31.03.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class ServerManager extends ClientComponent {
    public String[] segmentServerAddresses;
    public String contentServerAddress;
    public String clientVersion = "0";
    public String clientType = "1";

    public void updateLocale(String locale) {
        getClient().getCrypt().setLocaleName(locale.replace("_", "-"));
    }
}
