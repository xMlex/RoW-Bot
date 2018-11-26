package ru.xmlex.zp;

import jawnae.pyronet.PyroClient;
import jawnae.pyronet.PyroSelector;
import ru.xmlex.common.ConfigSystem;
import ru.xmlex.zp.core.xclient.CrazyPandaApi;
import ru.xmlex.zp.net.ZpClientAdapter;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;

/**
 * Created by theml on 06.10.2016.
 */
public class XClient extends ZpClientAdapter {

    //opera.exe	4324	TCP	192.168.101.99	51311	91.234.119.215	19000	ESTABLISHED	59	1 141	161	5 587
    //chuck.crazypanda.ru
    //f2.village-odnoklassniki.crazypanda.ru

    private String backendId = "game-21";
    public String authKey = "";
    public String staticKey = "";

    private boolean authorized;
    private String reconnectKey;
    private int lastMessageID = -1;
    private int sentMessageID = -1;

    CrazyPandaApi api = new CrazyPandaApi();

    public static void main(String[] agrs) throws IOException {

        ConfigSystem.load();

        final XClient xClient = new XClient();
        CrazyPandaApi api = new CrazyPandaApi();
        xClient.authKey = api.getAuth();
        xClient.staticKey = api.getStaticKey();

        api.socialStart(xClient.authKey);

        PyroSelector selector = new PyroSelector();
        InetSocketAddress address = new InetSocketAddress("f2.village-odnoklassniki.crazypanda.ru", 19000);
        final PyroClient client = selector.connect(address);

        client.addListener(xClient);

        selector.spawnNetworkThread("main-network-thread");
    }

    public void connectedClient(PyroClient client) {
        log.info("Connected");

        ByteBuffer buf = null;
        try {
            String str = "SYN QUE " + backendId + " " + authKey + " " + staticKey + "\0";
            //System.out.println(str);
            buf = ByteBuffer.wrap(str.getBytes("UTF-8"));
            //System.out.println(HexDump.dumpHexString(buf.array()));
            client.write(buf);
            client.flush();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
