package ru.xmlex.zp.core;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import jawnae.pyronet.PyroClient;
import ru.xmlex.common.threading.SafeRunnable;
import ru.xmlex.common.threading.ThreadPoolManager;
import ru.xmlex.zp.core.controller.ServerEventData;
import ru.xmlex.zp.core.models.ClientInfo;
import ru.xmlex.zp.core.models.User;
import ru.xmlex.zp.core.models.packets.BasePacket;
import ru.xmlex.zp.core.models.packets.Initialize;
import ru.xmlex.zp.core.tasks.PacketSendTask;
import ru.xmlex.zp.core.xclient.XPacket;
import ru.xmlex.zp.listeners.OnZpClientListener;

import java.nio.ByteBuffer;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.ScheduledFuture;
import java.util.logging.Logger;

/**
 * Created by mlex on 21.10.16.
 */
public class ZpClient extends SafeRunnable implements OnZpClientListener {
    protected static final Logger log = Logger.getLogger(ZpClient.class.getName());
    public static final Gson gson = new Gson();

    public PyroClient socket;
    public ClientInfo info;
    public User user;

    private int packetNum = 0;
    private final ScheduledFuture<?> future;
    public final LinkedBlockingDeque<Runnable> tasks = new LinkedBlockingDeque<>();

    public ZpClient() {
        future = ThreadPoolManager.getInstance().scheduleAtFixedRate(this, 3000, 2000);
    }

    public void onPacket(XPacket packet) {
        if (packet.raw.startsWith("ACK ")) {
            packet.raw = packet.raw.substring(packet.raw.indexOf("{"));
            JsonObject jsonObject = gson.fromJson(packet.raw, JsonObject.class).get("client").getAsJsonObject();
            info = gson.fromJson(jsonObject, ClientInfo.class);
            sendPacket(new Initialize());
            return;
        }
        if (packet.isJson) {
            BasePacket basePacket = gson.fromJson(packet.raw, BasePacket.class);
            log.info(packet.number + " [" + basePacket.name + "] ");

            if (packet.asJson.has("events")) {
                for (JsonElement event : packet.asJson.get("events").getAsJsonArray()) {
                    ServerEventData.listeners.onServerEventData(this, new ServerEventData(event.getAsJsonObject()));
                }
            }
        }
    }

    public void sendPacket(BasePacket pkt) {
        String buf = packetNum + ">PAS JSN ";
        packetNum++;
        pkt.cmdId = "g:" + packetNum;
        buf = buf + gson.toJson(pkt) + "\0";
        log.info("send: " + buf);
        socket.writeCopy(ByteBuffer.wrap(buf.getBytes()));
        socket.flush();
    }

    @Override
    public void runImpl() throws Exception {

        if (tasks.isEmpty())
            return;
        Runnable r = tasks.removeFirst();
        if (r instanceof PacketSendTask) {
            ((PacketSendTask) r).setClient(this);
        }
        socket.lock();
        try {
            r.run();
        } finally {
            socket.unLock();
        }
    }

    @Override
    public void onZpClientConnected(PyroClient client) {

    }

    @Override
    public void onZpClientDisconnected(PyroClient client) {
        if (client == this.socket) {
            log.info("Canseled task");
            future.cancel(true);
        }
    }
}
