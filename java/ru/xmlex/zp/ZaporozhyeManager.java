package ru.xmlex.zp;

import ru.xmlex.zp.actors.ClientManager;
import ru.xmlex.zp.actors.ItemRequest;

import java.util.logging.Logger;

/**
 * Created by mlex on 19.10.16.
 */
public class ZaporozhyeManager {
    protected static Logger log = Logger.getLogger(ZaporozhyeManager.class.getName());
    private static ZaporozhyeManager instance;

    // Actors
    public final ItemRequest itemRequestActor;
    public final ClientManager clientManager;

    public ZaporozhyeManager() {
        log.info("[BEGIN] ZaporozhyeManager");
        itemRequestActor = new ItemRequest();
        clientManager = new ClientManager();
        log.info("[END] ZaporozhyeManager");
    }

    public static ZaporozhyeManager getInstance() {
        if (instance == null)
            instance = new ZaporozhyeManager();
        return instance;
    }
}
