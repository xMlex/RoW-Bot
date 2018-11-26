package ru.xmlex.zp.protocol;

import jawnae.pyronet.traffic.ByteSink;

import java.nio.ByteBuffer;

/**
 * Created by xMlex on 05.10.16.
 */
public class EndWithProtocol implements ByteSink {

    private final ByteBuffer result;
    private final byte endByte;
    private final boolean includeEndsWith;
    private int matchCount;
    private int filled;

    public EndWithProtocol(ByteBuffer result, byte endByte, boolean includeEndsWith) {
        this.result = result;
        this.endByte = endByte;
        this.includeEndsWith = includeEndsWith;
        this.reset();
    }

    @Override
    public int feed(byte b) {
        return 0;
    }

    @Override
    public void reset() {
        this.result.clear();
        this.matchCount = 0;
        this.filled = 0;
    }

    @Override
    public void onReady(ByteBuffer byteBuffer) {

    }
}
