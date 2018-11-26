package ru.xmlex.zp;

import ru.xmlex.common.ConfigSystem;
import ru.xmlex.common.socks.PyroSocks4;
import ru.xmlex.zp.listeners.DataLogListener;

/**
 * Created by Mlex on 14.09.2014.
 */
public class ZaporjeProxy {

    public static void main(String[] args) throws Exception {
        ConfigSystem.load();
        final PyroSocks4 server = new PyroSocks4();
        server.addWriteListener(new DataLogListener());
    }
}
