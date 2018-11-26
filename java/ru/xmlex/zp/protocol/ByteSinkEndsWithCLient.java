package ru.xmlex.zp.protocol;

import jawnae.pyronet.PyroClient;
import jawnae.pyronet.traffic.ByteSink;
import jawnae.pyronet.traffic.PyroByteSinkFeeder;

import java.nio.ByteBuffer;

public abstract class ByteSinkEndsWithCLient implements ByteSink {

    private PyroClient _client;
    private PyroByteSinkFeeder _feeder;

    private final ByteBuffer result;
    private final byte[] endsWith;
    private final boolean includeEndsWith;
    private int matchCount;
    private int filled;

    public ByteSinkEndsWithCLient(byte[] endsWith, int capacity,
                                  boolean includeEndsWith) {
        if (endsWith == null || endsWith.length == 0)
            throw new IllegalStateException();
        this.result = ByteBuffer.allocate(capacity);
        this.endsWith = endsWith;
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
        if (this.endsWith[this.matchCount] == b) {
            this.matchCount++;
        } else {
            this.matchCount = 0;
        }

        this.result.put(this.filled, b);

        this.filled += 1;

        if (this.matchCount == this.endsWith.length) {
            int len = this.filled
                    - (this.includeEndsWith ? 0 : this.endsWith.length);
            this.result.limit(len);
            this.onReady(this.result);
            this.reset();
            return FEED_ACCEPTED;
        }

        return ByteSink.FEED_ACCEPTED;
    }

    public void setClient(PyroClient c) {
        _client = c;
    }

    public PyroClient getClient() {
        return _client;
    }

    public PyroByteSinkFeeder getFeeder() {
        return _feeder;
    }

    public void setFeeder(PyroByteSinkFeeder _feeder) {
        this._feeder = _feeder;
    }
}
