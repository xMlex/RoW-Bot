package ru.xmlex.zp.listeners;

import jawnae.pyronet.PyroClient;
import ru.xmlex.common.socks.lisrtener.OnSockerWriteListener;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.logging.FileHandler;
import java.util.logging.Logger;

/**
 * Created by xMlex on 05.10.16.
 */
public class DataLogListener implements OnSockerWriteListener {
    protected static final Logger log = Logger.getLogger(DataLogListener.class.getName());

    static {
        try {
            log.addHandler(new FileHandler("log/zp-protocol-" + System.currentTimeMillis() + ".log"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onSocketWrite(PyroClient from, PyroClient to, ByteBuffer data) {

        if (
                isZp(to.getRemoteAddress().getPort()) || isZp(from.getRemoteAddress().getPort()) ||
                        isZp(to.getLocalAddress().getPort()) || isZp(from.getLocalAddress().getPort())
        ) {
            byte[] buf = new byte[data.remaining()];
            data.get(buf);
            data.flip();
            boolean isClient = from.getLocalAddress().getHostName().equalsIgnoreCase("127.0.0.1");
            log.info("[" + (isClient ? "C" : "S") + "] " + new String(buf));
        }
    }

    private static boolean isZp(int port) {
        if (port == 843 || port == 19000) {
            return true;
        }
        return false;
    }
}
