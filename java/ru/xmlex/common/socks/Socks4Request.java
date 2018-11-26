package ru.xmlex.common.socks;

import jawnae.pyronet.traffic.ByteSinkLength;

import java.nio.ByteBuffer;

/**
 * Created by xMlex on 04.10.16.
 */
public class Socks4Request extends ByteSinkLength {

    protected final SocksRedirectRequest request;

    public Socks4Request(SocksRedirectRequest request) {
        super(8);
        this.request = request;
    }

    @Override
    public void onReady(ByteBuffer buffer) {
        request.version = buffer.get() & 0xFF;
        request.command = buffer.get() & 0xFF;
        request.port = buffer.getShort() & 0xFFFF;
        buffer.get(request.addr);
        if (buffer.hasRemaining())
            throw new IllegalStateException();
    }
}
