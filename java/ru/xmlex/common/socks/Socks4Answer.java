package ru.xmlex.common.socks;

import jawnae.pyronet.traffic.ByteSinkEndsWith;

import java.nio.ByteBuffer;

/**
 * Created by xMlex on 04.10.16.
 */
public class Socks4Answer extends ByteSinkEndsWith {

    protected final SocksRedirectRequest request;

    private static final byte[] zero_byte = new byte[]{(byte) 0x00};

    public Socks4Answer(SocksRedirectRequest request) {
        super(zero_byte, 16, false);
        this.request = request;
    }

    @Override
    public void onReady(ByteBuffer buffer) {
        request.userid = new byte[buffer.remaining()];
        buffer.get(request.userid);

        request.handshake();
    }
}
