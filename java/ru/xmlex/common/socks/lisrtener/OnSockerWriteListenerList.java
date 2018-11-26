package ru.xmlex.common.socks.lisrtener;

import jawnae.pyronet.PyroClient;
import ru.xmlex.common.listener.Listener;
import ru.xmlex.common.listener.ListenerList;
import ru.xmlex.common.socks.SocksAttachment;

import java.nio.ByteBuffer;

/**
 * Created by xMlex on 05.10.16.
 */
public class OnSockerWriteListenerList extends ListenerList<SocksAttachment> {
    public void onSocketWrite(PyroClient from, PyroClient to, ByteBuffer data) {
        for (Listener<SocksAttachment> listener : getListeners())
            if (OnSockerWriteListener.class.isInstance(listener))
                ((OnSockerWriteListener) listener).onSocketWrite(from, to, data);
    }
}
