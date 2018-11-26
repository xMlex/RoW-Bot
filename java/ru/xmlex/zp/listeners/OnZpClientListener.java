package ru.xmlex.zp.listeners;

import jawnae.pyronet.PyroClient;
import ru.xmlex.common.listener.Listener;

/**
 * Created by mlex on 25.10.16.
 */
public interface OnZpClientListener extends Listener<PyroClient> {
    public void onZpClientConnected(PyroClient client);

    public void onZpClientDisconnected(PyroClient client);
}
