package ru.xmlex.row.game;

import ru.xmlex.common.Util;
import ru.xmlex.row.game.data.User;
import ru.xmlex.row.game.data.commands.BaseCommand;
import ru.xmlex.row.game.data.commands.UserSignInCmd;
import ru.xmlex.row.game.db.models.RowAuthKeys;
import ru.xmlex.row.game.logic.ClientComponent;
import ru.xmlex.row.game.logic.ServerManager;
import ru.xmlex.row.game.logic.ServerTimeManager;

import java.util.logging.Logger;

/**
 * Created by xMlex on 29.03.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class GameClient {
    private static final Logger log = Logger.getLogger(GameClient.class.getName());

    private final RowAuthKeys account;
    private RowSignature crypt;

    // Game objects
    public final ServerManager serverManager;
    public final ServerTimeManager serverTimeManager;

    private User user = null;

    public GameClient(RowAuthKeys account) {
        this.account = account;
        assert account != null;
        serverManager = createComponent(ServerManager.class);
        serverTimeManager = createComponent(ServerTimeManager.class);
    }

    public void executeCmd(BaseCommand command) {
        command.setClient(this);
        command.run();
        //ThreadPoolManager.getInstance().executeGeneral(command);
    }

    public void executeCmdCurrent(BaseCommand command) {
        command.setClient(this);
        command.run();
    }

    public void executeCmdDebug(BaseCommand command) {
        command.setClient(this);
        command.onCommandInit();
        log.info("Cmd: " + command.getClass().getSimpleName());
        log.info("SendRequestMethod: " + command.getMethod());
        log.info("SendRequest: " + command.getAction());
        log.info("SendData: " + command.getBody());
    }

    public RowSignature getCrypt() {
        if (crypt == null)
            crypt = new RowSignature();
        return crypt;
    }

    public void setCrypt(RowSignature crypt) {
        this.crypt = crypt;
    }

    public boolean initialize() {
        getCrypt();
        switch (account.socialType) {
            case "vk":
                crypt.SERVER_LIST = new String[]{
                        "https://pvvk1s00.plrm.zone/GeoVk/Segment00/segment.ashx", // Geotopia
                        "https://pvvk2s00.plrm.zone/GeoVk2/Segment00/segment.ashx", // Red Zero
                };
                break;
            case "pp":
                crypt.SERVER_LIST = new String[]{
                        "http://173.244.172.50/GeoPortalRus/segment00/segment.ashx", // Geotopia
                        "http://173.244.172.50/GeoPortalRus2/segment00/segment.ashx", // Red Zero
                };
                break;
        }

        if (crypt.callGetTouch(account)) {
            crypt.setUserHashedId(account.getSocialId());
            if (account.seed == null || account.seed.isEmpty()) {
                crypt.setUserSocialAuthSeed(Util.randomString(86));
            } else {
                crypt.setUserSocialAuthSeed(account.seed);
            }
            crypt.setUserSocialAuthKey(account.getAuthKey());
            executeCmd(new UserSignInCmd());
            return true;
        }
        return false;
    }

    private <T extends ClientComponent> T createComponent(Class<T> classOfT) {
        T instance = null;
        try {
            instance = classOfT.newInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }
        assert instance != null;
        instance.setClient(this);
        return instance;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public RowAuthKeys getAccount() {
        return account;
    }

    public void logAction(String msg, int id) {
        if (getAccount() != null)
            getAccount().log(msg, id);
    }

    public void logAction(String msg) {
        logAction(msg, 0);
    }

    @Override
    public String toString() {
        return "GameClient{" +
                "account=" + account +
                ", user=" + user +
                '}';
    }
}
