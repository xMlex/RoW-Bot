package ru.xmlex.row.game.data.commands;

import ru.xmlex.common.ConfigSystem;
import ru.xmlex.common.Util;
import ru.xmlex.row.game.logic.StaticDataManager;

import java.io.File;
import java.util.concurrent.locks.ReentrantLock;

/**
 * Created by xMlex on 01.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class StaticDataGetCmd extends BaseCommand {
    private static final ReentrantLock lock = new ReentrantLock();
    final static String DATA_BORDER_STRING = "\"";

    final String key;

    public StaticDataGetCmd(String key) {
        this.key = key;
        setAction("Client.GetStaticData");
        setMethod("get");
        setBody(DATA_BORDER_STRING + key + DATA_BORDER_STRING);
        setUserRefresh(false);
    }

    @Override
    public void onCommandInit() {
        log.info("Static data start loading...");
    }

    @Override
    public void onCommandResult(String result) {
        lock.lock();
        try {
            File file = new File("./data-v." + ConfigSystem.getInt("row_client_version", 505) + ".json");
            if (!file.exists()) {
                Util.writeFile(result, file.getAbsolutePath());
                StaticDataManager.initializeFromCache();
            }
        } finally {
            lock.unlock();
        }
    }
}
