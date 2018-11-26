package ru.xmlex.zp.actors;

import ru.xmlex.common.threading.SafeRunnable;
import ru.xmlex.common.threading.ThreadPoolManager;
import ru.xmlex.zp.model.ZpAuthKey;

import java.util.concurrent.ScheduledFuture;

/**
 * Created by mlex on 20.10.16.
 */
public class ClientManager extends SafeRunnable {
    private ScheduledFuture<?> future;

    public ClientManager() {
        future = ThreadPoolManager.getInstance().scheduleAtFixedRate(this, 3000, 3600000);
    }

    @Override
    public void runImpl() throws Exception {
        // Каждый час проходимся по активным аккаунтам, и заходим в игру
        for (ZpAuthKey key : ZpAuthKey.getDao().queryForAll()) {
            if (!key.active)
                continue;


        }
    }
}
