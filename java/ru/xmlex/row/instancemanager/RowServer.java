package ru.xmlex.row.instancemanager;

import ru.xmlex.common.ConfigSystem;
import ru.xmlex.common.threading.SafeRunnable;
import ru.xmlex.common.threading.ThreadPoolManager;
import ru.xmlex.row.game.GameClient;
import ru.xmlex.row.game.db.models.RowAuthKeys;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ScheduledFuture;
import java.util.logging.Logger;

/**
 * Created by mlex on 21.12.16.
 */
public class RowServer extends SafeRunnable {
    private static Logger log = Logger.getLogger(RowServer.class.getName());
    private static RowServer instance;

    private ScheduledFuture<?> scheduledFuture;

    public static RowServer getInstance() {
        if (instance == null)
            instance = new RowServer();
        return instance;
    }

    public void start() {
        stop();
        scheduledFuture = ThreadPoolManager.getInstance().scheduleAtFixedRate(
                this, 2000,
                ConfigSystem.getInt("row_account_manager_refresh", 1200) * 1000);
    }

    public void stop() {
        if (scheduledFuture != null && !scheduledFuture.isCancelled()) {
            scheduledFuture.cancel(true);
        }
    }

    @Override
    public void runImpl() throws Exception {
        log.fine("RowServer task begin");
        List<RowAuthKeys> users;
        if (ConfigSystem.DEBUG) {
            RowAuthKeys key = RowAuthKeys.getDao().queryForId(48);
            if (key == null)
                throw new Exception("Not found debug auth_key, for id: 1");
            users = new ArrayList<>(1);
            users.add(key);
        } else {
            users = RowAuthKeys.getDao().query(
                    RowAuthKeys.getDao().queryBuilder().where()
                            .eq("is_active", 1).prepare()
            );
        }
        if (users == null)
            return;
        for (RowAuthKeys key : users) {
            log.info("Begin Row account: " + key.toString());
            try {
                GameClient client = new GameClient(key);
                if (client.initialize()) {
                    log.info("Initialize ok: " + key.toString());
                } else {
                    log.info("Initialize error: " + key.toString());
                }
            } catch (Exception e) {
                log.severe("Initialize error: " + key.toString() + e.getMessage());
            }
        }
    }
}
