package ru.xmlex.zp.net;

import jawnae.pyronet.PyroClient;
import jawnae.pyronet.events.PyroClientListener;
import jawnae.pyronet.traffic.ByteStream;
import ru.xmlex.common.HexDump;
import ru.xmlex.common.listener.Listener;
import ru.xmlex.common.listener.ListenerList;
import ru.xmlex.zp.core.xclient.XPacket;
import ru.xmlex.zp.listeners.OnZpClientListener;
import ru.xmlex.zp.model.ZpAuthKey;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.logging.Logger;

/**
 * Created by mlex on 20.10.16.
 */
public class ZpClientAdapter extends ByteSinkEndByte implements PyroClientListener {
    protected static final Logger log = Logger.getLogger(ZpClientAdapter.class.getName());

    public static final ZpClientListenerList listeners = new ZpClientListenerList();

    protected Set<PyroClient> clients = new CopyOnWriteArraySet<PyroClient>();

    private final ByteStream inbound;
    private final ByteBuffer buf;

    public ZpClientAdapter() {
        inbound = new ByteStream();
        buf = ByteBuffer.allocate(8192);
    }

    @Override
    public void connectedClient(PyroClient client) {
        log.info("Connected");
        clients.add(client);
        listeners.onZpClientConnected(client);
        ZpAuthKey authKey = client.attachment();
        authKey.getClient().socket = client;
        ByteBuffer buf = null;
        try {
            String str = "SYN QUE " + authKey.startResponse.backend.id + " " + authKey.generateAuth(true) + " " + authKey.startResponse.backend.getStaticKey() + "\0";
            buf = ByteBuffer.wrap(str.getBytes("UTF-8"));
            client.write(buf);
            client.flush();
        } catch (Exception e) {
            e.printStackTrace();
            client.dropConnection();
        }
    }

    @Override
    public void unconnectableClient(PyroClient pyroClient) {
        log.info("Unconnectable");
    }

    @Override
    public void droppedClient(PyroClient client, IOException e) {
        log.info("Dropped");
        clients.remove(client);
        listeners.onZpClientDisconnected(client);
    }

    @Override
    public void disconnectedClient(PyroClient client) {
        log.info("disconnected");
        clients.remove(client);
        listeners.onZpClientDisconnected(client);
    }

    @Override
    public void receivedData(PyroClient pyroClient, ByteBuffer byteBuffer) {
        ByteBuffer copy = pyroClient.selector().copy(byteBuffer);
        this.inbound.append(copy);
        this.buf.clear();
        this.inbound.get(this.buf);

        int off = 0;
        int end = this.buf.position();
        while (off < end) {
            switch (feed(this.buf.get(off), pyroClient)) {
                case 1:
                    ++off;
                    continue;
                case 2:
                    ++off;
                    break;
                case 3:
                    off += 0;
            }
        }
        inbound.discard(off);
    }

    @Override
    public void sentData(PyroClient pyroClient, int i) {
        log.info("sentData " + i);
    }

    @Override
    public void onReady(ByteBuffer byteBuffer, PyroClient client) {
        byte[] buf = new byte[byteBuffer.remaining()];
        byteBuffer.get(buf);
        String pkt = HexDump.bytesToString(buf);

        XPacket packet = XPacket.parsePacket(pkt);
        log.info("[S]: " + packet.toString());

        ZpAuthKey authKey = client.attachment();
        authKey.getClient().onPacket(packet);
    }

    public static class ZpClientListenerList extends ListenerList<PyroClient> {
        public void onZpClientConnected(PyroClient client) {
            for (Listener<PyroClient> listener : getListeners())
                if (OnZpClientListener.class.isInstance(listener))
                    ((OnZpClientListener) listener).onZpClientConnected(client);
        }

        public void onZpClientDisconnected(PyroClient client) {
            for (Listener<PyroClient> listener : getListeners())
                if (OnZpClientListener.class.isInstance(listener))
                    ((OnZpClientListener) listener).onZpClientDisconnected(client);
        }
    }
}
