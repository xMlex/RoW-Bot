package ru.xmlex;

import ru.xmlex.common.ConfigSystem;
import ru.xmlex.common.MemoryWatchDog;
import ru.xmlex.common.MessageNotifier;
import ru.xmlex.common.dbcp.BaseDatabaseFactory;
import ru.xmlex.common.threading.ThreadPoolManager;
import ru.xmlex.row.game.logic.StaticDataManager;
import ru.xmlex.row.instancemanager.RowServer;

import java.util.logging.Logger;

/**
 * Created by xMlex on 4/3/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class Server {
    private static Logger log = Logger.getLogger(Server.class.getName());

    public static void main(String[] agrs) throws Exception {
        ConfigSystem.load();
//        RSA.getInstance().loadPrivate("java/config/private.pem");
//        log.info("RSA Crypt initialized");
        ThreadPoolManager.getInstance();
        log.info("ThreadPoolManager initialized");
        BaseDatabaseFactory.getInstance();
        log.info("Database initialized");
        // Row
        if (!StaticDataManager.initializeFromCache()) {
            log.severe("Row StaticDataManager NOT initialized");
            return;
        }

        RowServer.getInstance().start();

//        AccountManager.getInstance();
//        log.info("Row AccountManager initialized");
        // Zaporoje
//        ZaporozhyeManager.getInstance();
//        log.info("ServerEventData initialized");
        // Slack Api
//        if (!ConfigSystem.DEBUG)
        MessageNotifier.getInstance();
        log.info(MemoryWatchDog.getStatus());
    }
}
