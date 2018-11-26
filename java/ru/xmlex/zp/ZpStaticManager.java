package ru.xmlex.zp;

import gnu.trove.map.hash.TIntObjectHashMap;
import ru.xmlex.zp.core.models.amf.MFActor;

import java.sql.SQLException;

/**
 * Created by mlex on 25.10.16.
 */
public class ZpStaticManager {
    private static ZpStaticManager instance;
    public TIntObjectHashMap<MFActor> actors;

    public ZpStaticManager() {
        try {
            actors = new TIntObjectHashMap<MFActor>((int) MFActor.getDao().countOf());
            for (MFActor actor : MFActor.getDao().queryForAll()) {
                actors.put(actor.id, actor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public static ZpStaticManager getInstance() {
        if (instance == null) {
            instance = new ZpStaticManager();
        }
        return instance;
    }
}
