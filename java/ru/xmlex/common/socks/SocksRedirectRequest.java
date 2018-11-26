package ru.xmlex.common.socks;

import jawnae.pyronet.PyroClient;
import jawnae.pyronet.events.PyroClientListener;

import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;

/**
 * Created by xMlex on 04.10.16.
 */
public class SocksRedirectRequest {
    public final PyroClientListener listener;
    private final PyroClient src;

    public int version;
    public int command;
    public int port;
    public byte[] addr = new byte[4];
    public byte[] userid;

    public SocksRedirectRequest(PyroClientListener listener, PyroClient src) {
        this.listener = listener;
        this.src = src;
    }

    public void handshake() {

        if (this.version != 0x04 || this.command != 1) {
            rejectClient();
            return;
        }

        try {
            InetAddress iaddr = InetAddress.getByAddress(this.addr);
            InetSocketAddress connect = new InetSocketAddress(iaddr, this.port);
            PyroClient dst = src.selector().connect(connect);
            {
                SocksAttachment srcAtt = src.attachment();
                srcAtt.target = dst;

                dst.attach(new SocksAttachment(src));
            }
            dst.addListener(listener);
        } catch (Exception exc) {
            rejectClient();
        }
    }

    protected void rejectClient() {
        System.out.println("Rejected client");
        ByteBuffer response = ByteBuffer.allocate(8);
        response.put((byte) 0x00);
        response.put((byte) 0x5b); // failed
        response.clear();
        src.write(response);
        src.shutdown();
    }
}
