package ru.xmlex.zp.protocol;

import jawnae.pyronet.traffic.ByteSink;

import java.nio.ByteBuffer;

/**
 * Created by Mlex on 14.09.2014.
 */
public abstract class ByteSinkEndByte implements ByteSink {

    private final ByteBuffer result;
    private final byte endByte;
    private final boolean includeEndsWith;
    private int matchCount;
    private int filled;

    public ByteSinkEndByte(byte endByte, int capacity, boolean includeEndsWith) {
        this.result = ByteBuffer.allocate(capacity);
        this.endByte = endByte;
        this.includeEndsWith = includeEndsWith;

        this.reset();
    }

    @Override
    public void reset() {
        this.result.clear();
        this.matchCount = 0;
        this.filled = 0;
    }

    @Override
    public int feed(byte b) {
        this.result.put(this.filled, b);

        this.filled += 1;

        if (this.endByte == b) {
            int len = this.filled - (this.includeEndsWith ? 0 : 1);
            this.result.limit(len);
            this.onReady(this.result);
            this.reset();
            return FEED_ACCEPTED_LAST;
        }

        return ByteSink.FEED_ACCEPTED;
    }

}
