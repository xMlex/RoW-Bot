package ru.xmlex.zp.protocol;

import jawnae.pyronet.PyroClient;
import jawnae.pyronet.events.PyroClientListener;
import jawnae.pyronet.traffic.PyroByteSinkFeeder;
import ru.xmlex.common.HexDump;
import ru.xmlex.zp.core.xclient.XPacket;
import ru.xmlex.zp.protocol.SOCKS4.SocksAttachment;

import java.io.FileWriter;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class SOCKS4Listener implements PyroClientListener {

    private PyroClient _server = null, _client = null;
    private boolean _connected = false;
    private FileWriter fw;

    public SOCKS4Listener() {
        try {
            fw = new FileWriter("log.txt");
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    private void log(String s) {
        try {
            System.out.println("log: " + s);
            fw.write(s);
            fw.write("\n;\n");
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public void setServer(PyroClient target) {
        _server = target;
        setProtocol(target);
        // target.addListener(this);
        // System.out.println("ServerEventData: " + target+" Client: "+_client);
    }

    public void setClient(PyroClient target) {
        _client = target;
        setProtocol(target);
        // target.addListener(this);
        // System.out.println("Client: " + target+" ServerEventData: "+_server);
    }

    public void recvData(ByteBuffer data, PyroClient target) {
        target.writeCopy(data);
        //setProtocol(target);
    }

    public void receivedData(PyroClient client, ByteBuffer data) {

        SocksAttachment sa = client.attachment();
        log("data to: " + sa.target.getRemoteAddress().getAddress().getHostAddress() + " Len: " + data.remaining());

        byte[] buf = new byte[data.remaining()];
        data.get(buf);
        data.flip();

        recvData(data, sa.target);
        log(HexDump.bytesToString(buf));
        //System.out.println(HexDump.dumpHexString(buf));

    }

    private void handle(String p) {
        String pkt = "";
        int pos = 0;
        if (checkRegExp("^\\d+>.+", p)) {
            int _loc5_ = p.indexOf(">");
            int _loc2_ = Integer.valueOf(p.substring(0, _loc5_));
            pos = _loc5_ + 1;
        }
        if (p.charAt(pos) == 'G' && p.charAt(pos) == 'R') {
            //_loc2_.isGroup = true;
            pos = pos + 4;
            System.out.println("GROUP");
        }
        if (p.charAt(pos) == 'D') {
            pkt = XPacket.parsePacket(p.substring(pos + 1)).raw;
        } else
            pkt = p.substring(pos);
        log(pkt);
    }

    private static int BUFFER_SIZE = 1024 * 1024 * 5;

    public static boolean checkRegExp(String rg, String s) {
        Pattern p = Pattern.compile(rg);
        Matcher m = p.matcher(s);
        return m.matches();
    }

    private void setProtocol(final PyroClient client) {
        PyroByteSinkFeeder feeder = new PyroByteSinkFeeder(client.selector(), 1024 * 1024 * 10);

        ByteSinkEndsWithCLient c = new ByteSinkEndsWithCLient(ZERO_BYTE, 1024 * 1024 * 4, true) {

            @Override
            public void onReady(ByteBuffer buffer) {

                byte[] data = new byte[buffer.remaining()];
                buffer.get(data);
                buffer.flip();

                if (!_connected) {
                    String text = new String(data);
                    if (text.startsWith("HELO"))
                        _connected = true;
                } else {
                    //System.out.println(HexDump.bytesToString(data));
                    String p = HexDump.bytesToString(data);
                    if (!p.startsWith("NOOP") && !p.startsWith("POON")) {
                        handle(p.trim());
                    }
                    //this.reset();
                    //if(getFeeder() != null)
                    //	getFeeder().addByteSink(this);
                }

                SocksAttachment sa = this.getClient().attachment();
                recvData(buffer, sa.target);

            }
        };
        c.setClient(client);
        feeder.addByteSink(c);
        c.setFeeder(feeder);
        client.addListener(feeder);
        //client.addListener(this);
    }

    public static byte[] ZERO_BYTE = {0x00};

    @Override
    public void connectedClient(PyroClient client) {
        // TODO Auto-generated method stub

    }

    @Override
    public void unconnectableClient(PyroClient client) {
        // TODO Auto-generated method stub

    }

    @Override
    public void droppedClient(PyroClient client, IOException cause) {
        // TODO Auto-generated method stub

    }

    @Override
    public void disconnectedClient(PyroClient client) {
        // TODO Auto-generated method stub

    }

    @Override
    public void sentData(PyroClient client, int bytes) {
        // TODO Auto-generated method stub

    }
}
