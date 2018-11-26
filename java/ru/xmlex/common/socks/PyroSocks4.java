package ru.xmlex.common.socks;

import jawnae.pyronet.PyroClient;
import jawnae.pyronet.PyroSelector;
import jawnae.pyronet.PyroServer;
import jawnae.pyronet.addon.PyroRoundrobinSelectorProvider;
import jawnae.pyronet.addon.PyroSelectorProvider;
import jawnae.pyronet.events.PyroLazyBastardAdapter;
import jawnae.pyronet.traffic.PyroByteSinkFeeder;
import ru.xmlex.common.socks.lisrtener.OnSockerWriteListener;
import ru.xmlex.common.socks.lisrtener.OnSockerWriteListenerList;

import java.io.IOException;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;

/**
 * Created by xMlex on 04.10.16.
 */
public class PyroSocks4 extends PyroLazyBastardAdapter {

    protected final String host;
    protected final int port;

    protected final PyroSelector[] pool;
    protected PyroServer pyroServer;

    protected OnSockerWriteListenerList writeListenerList = new OnSockerWriteListenerList();

    public PyroSocks4(String host, int port, int selectorCount) throws IOException {
        this.host = host;
        this.port = port;
        pool = new PyroSelector[selectorCount];
        for (int i = 0; i < selectorCount; i++) {
            pool[i] = new PyroSelector(this);
            // launch the threads that will handle network I/O (1 NIO selector per thread)
            pool[i].spawnNetworkThread("traffic-thread #" + (i + 1));
        }
        PyroSelector selector = new PyroSelector(this);
        InetSocketAddress bind = new InetSocketAddress(InetAddress.getByName(host), port);
        pyroServer = selector.listen(bind);
        pyroServer.addListener(this);
        PyroSelectorProvider roundrobin = new PyroRoundrobinSelectorProvider(pool);
        pyroServer.installSelectorProvider(roundrobin);
        pyroServer.selector().spawnNetworkThread("socks4-handler");
        System.out.println("Socks server started on: " + host + ":" + port);
    }

    public PyroSocks4() throws IOException {
        this("localhost", 1080, 4);
    }

    @Override
    public void acceptedClient(final PyroClient src) {
        //System.out.println("accepted-client: " + src + " using " + Thread.currentThread().getName());
        SocksRedirectRequest request = new SocksRedirectRequest(this, src);

        PyroByteSinkFeeder feeder = new PyroByteSinkFeeder(src.selector());
        feeder.addByteSink(new Socks4Request(request));
        feeder.addByteSink(new Socks4Answer(request));

        src.attach(new SocksAttachment(feeder));

        src.addListener(this);
    }

    public void terminate() {
        pyroServer.selector().scheduleTask(new Runnable() {
            @Override
            public void run() {
                try {
                    System.out.println("Terminated");
                    getPyroServer().terminate();
                    for (int i = 0; i < pool.length; i++) {
                        pool[i].networkThread().stop();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        });
    }

    public void addWriteListener(final OnSockerWriteListener listener) {
        writeListenerList.add(listener);
    }

    @Override
    public void connectedClient(PyroClient dst) {
        //System.out.println(" => connected-to-target: " + dst);
        ByteBuffer response = ByteBuffer.allocate(8);
        response.put((byte) 0x00);
        response.put((byte) 0x5a); // granted and succeeded! w00t!
        response.clear();

        SocksAttachment attachment = dst.attachment();
        attachment.target.write(response);
    }

    @Override
    public void unconnectableClient(PyroClient dst) {
        //System.out.println(" => target-unreachable: " + dst);

        // SOCK4 ru.xmlex.zp.protocol
        ByteBuffer response = ByteBuffer.allocate(8);
        response.put((byte) 0x00);
        response.put((byte) 0x5b); // failed
        response.clear();

        SocksAttachment attachment = dst.attachment();
        attachment.target.write(response);
        attachment.target.shutdown();
    }

    @Override
    public void receivedData(PyroClient client, ByteBuffer data) {
        //System.out.println("receivedData: " + data.remaining());
        SocksAttachment attachment = client.attachment();
        if (attachment.header != null) {
            if (attachment.target == null) {
                attachment.header.feed(data);
            } else {
                ByteBuffer pending = attachment.header.shutdown();
                attachment.header = null;
                if (pending.hasRemaining())
                    this.receivedData(client, pending);
                this.receivedData(client, data);
            }
        } else {
            writeListenerList.onSocketWrite(client, attachment.target, data);
            attachment.target.writeCopy(data);
        }
    }

    @Override
    public void droppedClient(PyroClient client, IOException cause) {
        if (cause != null)
            cause.printStackTrace(System.out);
        dropTarget(client);
    }

    @Override
    public void disconnectedClient(PyroClient client) {
        dropTarget(client);
    }

    protected void dropTarget(PyroClient client) {
        SocksAttachment attachment = client.attachment();

        if (attachment != null && attachment.target != null && !attachment.target.isDisconnected()) {
            attachment.target.shutdown();
            attachment.target.attach(null);
            client.attach(null);
        }
    }

    public PyroServer getPyroServer() {
        return pyroServer;
    }
}
