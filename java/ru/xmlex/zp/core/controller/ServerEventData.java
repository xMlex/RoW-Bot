package ru.xmlex.zp.core.controller;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import ru.xmlex.common.listener.Listener;
import ru.xmlex.common.listener.ListenerList;
import ru.xmlex.zp.core.ZpClient;
import ru.xmlex.zp.listeners.OnServerEventData;

import java.util.Map;
import java.util.logging.Logger;

/**
 * Created by mlex on 25.10.16.
 */
public class ServerEventData {
    protected static final Logger log = Logger.getLogger(ServerEventData.class.getName());
    public static final ServerEventDataListenerList listeners = new ServerEventDataListenerList();

    public String name;
    public JsonObject users;
    public JsonObject clans;

    public ServerEventData(JsonObject event) {
        //log.info("ServerEventData: " + event.toString());
        name = event.get("name").getAsString();
        if (event.has("users"))
            users = event.get("users").getAsJsonObject();
        if (event.has("clans"))
            clans = event.get("clans").getAsJsonObject();
    }

    public JsonObject getMineData() {
        if (users != null) {
            for (Map.Entry<String, JsonElement> entry : users.entrySet()) {
                return entry.getValue().getAsJsonObject();
            }
        }
        return null;
    }

    public static class ServerEventDataListenerList extends ListenerList<ServerEventData> {
        public void onServerEventData(ZpClient client, ServerEventData data) {
            for (Listener<ServerEventData> listener : getListeners())
                if (OnServerEventData.class.isInstance(listener))
                    ((OnServerEventData) listener).onServerEventData(client, data);
        }
    }
}
