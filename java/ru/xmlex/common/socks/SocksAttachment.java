package ru.xmlex.common.socks;

import jawnae.pyronet.PyroClient;
import jawnae.pyronet.traffic.PyroByteSinkFeeder;
import ru.xmlex.zp.protocol.PyroProtocolFeederStatic;

/**
 * Created by xMlex on 04.10.16.
 */
public class SocksAttachment {
    public PyroByteSinkFeeder header;
    public PyroClient target;
    public PyroProtocolFeederStatic sink = null;

    public SocksAttachment(PyroByteSinkFeeder header) {
        this.header = header;
        this.target = null;
    }

    public SocksAttachment(PyroClient target) {
        this.header = null;
        this.target = target;
    }
}
