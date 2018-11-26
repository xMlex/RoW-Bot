package ru.xmlex.zp.core.tasks;

import ru.xmlex.common.threading.SafeRunnable;
import ru.xmlex.zp.core.ZpClient;
import ru.xmlex.zp.core.models.packets.BasePacket;

/**
 * Created by mlex on 25.10.16.
 */
public class PacketSendTask extends SafeRunnable {

    private final BasePacket packet;
    private ZpClient client;

    public PacketSendTask(BasePacket packet) {
        this.packet = packet;
    }

    @Override
    public void runImpl() throws Exception {
        getClient().sendPacket(packet);
    }

    public ZpClient getClient() {
        return client;
    }

    public void setClient(ZpClient client) {
        this.client = client;
    }
}
