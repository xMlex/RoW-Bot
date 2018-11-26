package ru.xmlex.zp.net;

import jawnae.pyronet.PyroClient;
import jawnae.pyronet.traffic.ByteSink;

import java.nio.ByteBuffer;

/**
 * Created by Mlex on 14.09.2014.
 */
public abstract class ByteSinkEndByte implements ByteSink {

    private final ByteBuffer result;
    private final byte endByte;
    private final boolean includeEndsWith;
    private int filled;

    public ByteSinkEndByte() {
        this.result = ByteBuffer.allocate(1024 * 1024 * 2);
        this.endByte = (byte) 0x00;
        this.includeEndsWith = false;

        this.reset();
    }

    @Override
    public void reset() {
        this.result.clear();
        this.filled = 0;
    }

    public abstract void onReady(ByteBuffer var1, PyroClient client);

    @Override
    public void onReady(ByteBuffer var1) {
        onReady(var1, null);
    }

    @Override
    public int feed(byte b) {
        return feed(b, null);
    }

    public int feed(byte b, PyroClient client) {
        this.result.put(this.filled, b);

        this.filled += 1;

        if (this.endByte == b) {
            int len = this.filled - (this.includeEndsWith ? 0 : 1);
            this.result.limit(len);
            this.onReady(this.result, client);
            this.reset();
            return FEED_ACCEPTED_LAST;
        }

        return ByteSink.FEED_ACCEPTED;
    }

    public void feedArray(byte[] bytes) {
        for (byte b : bytes) {
            feed(b);
        }
    }
}
