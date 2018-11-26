package ru.xmlex.zp.listeners;

import ru.xmlex.common.listener.Listener;
import ru.xmlex.zp.core.ZpClient;
import ru.xmlex.zp.core.controller.ServerEventData;

/**
 * Created by mlex on 25.10.16.
 */
public interface OnServerEventData extends Listener<ServerEventData> {
    public void onServerEventData(ZpClient client, ServerEventData data);
}
