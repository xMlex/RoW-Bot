package ru.xmlex.zp;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import flex.messaging.io.SerializationContext;
import flex.messaging.io.amf.ASObject;
import flex.messaging.io.amf.Amf3Input;
import jawnae.pyronet.PyroClient;
import jawnae.pyronet.PyroSelector;
import ru.xmlex.common.ConfigSystem;
import ru.xmlex.common.HexDump;
import ru.xmlex.zp.core.controller.ServerEventData;
import ru.xmlex.zp.core.handler.EventDataHandler;
import ru.xmlex.zp.core.models.amf.MFActor;
import ru.xmlex.zp.model.ZpAuthKey;
import ru.xmlex.zp.net.ZpApi;
import ru.xmlex.zp.net.ZpClientAdapter;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.net.InetSocketAddress;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;
import java.util.logging.Logger;

/**
 * Created by mlex on 19.10.16.
 */
public class Test {
    protected static final Logger log = Logger.getLogger(Test.class.getName());

    public static void main(String[] args) throws Exception {
        ConfigSystem.load();

        PyroSelector.DO_NOT_CHECK_NETWORK_THREAD = true;
//        ZpStaticManager.getInstance();
        //ZaporozhyeManager.getInstance();

        // Handlers initialize
        ServerEventData.listeners.add(new EventDataHandler());

        if (true) {
            ZpAuthKey authKey = ZpAuthKey.getDao().queryForId(1);
            System.out.println("Key: " + authKey);
            ZpApi zpApi = new ZpApi(authKey);
            authKey.startResponse = zpApi.start();

            ZpClientAdapter adapter = new ZpClientAdapter();
            PyroSelector selector = new PyroSelector();

            InetSocketAddress address = new InetSocketAddress(authKey.startResponse.backend.host, 19000);
            final PyroClient client = selector.connect(address);
            client.attach(authKey);
            client.addListener(adapter);

            selector.spawnNetworkThread("main-network-thread");
        }
        if (false) {
            Path lang = Paths.get("./pinata_chicken-ver2.swf");
            byte[] bytes = Files.readAllBytes(lang);
            bytes = HexDump.decompressByteArray(bytes);

            writeFile(new String(bytes));


            Gson gson = new Gson();
            JsonObject object = gson.fromJson(new String(bytes), JsonObject.class);

            for (Map.Entry<String, JsonElement> entry : object.entrySet()) {
                System.out.println(entry.getKey() + ":" + entry.getValue());
            }
        }

        if (false) {
            log.info("Start AMF");
            File f = new File("./dicts-ver353.amf");
            if (f.exists() && f.canRead()) {
                Amf3Input deserializer = new Amf3Input(SerializationContext.getSerializationContext());
                deserializer.setInputStream(new FileInputStream(f));
                Object o = deserializer.readObject();

                if (o instanceof ASObject) {
                    ASObject ack = (ASObject) o;
                    ack = (ASObject) ack.get("global");
                    Object[] actors = (Object[]) ack.get("actors");
                    //ack = (ASObject) ack.get("actors");
                    MFActor actor;
                    for (Object o1 : actors) {
                        actor = new MFActor();
                        actor.deserialize(o1);
                        MFActor.getDao().createOrUpdate(actor);
                        //log.info("id: " + actor.id + " ident: " + actor.ident + " type: " + actor.type + " name: " + actor.name);
                    }

                }
            }
            log.info("End AMF");
        }

        if (false) {
            Path lang = Paths.get("./l-ver927.json");
            byte[] bytes = Files.readAllBytes(lang);

            Gson gson = new Gson();
            JsonObject object = gson.fromJson(new String(bytes), JsonObject.class);

            for (MFActor actor : MFActor.getDao().queryForAll()) {
                if (object.has("actor." + actor.ident + ".name")) {
                    actor.name = object.get("actor." + actor.ident + ".name").getAsString();

                    MFActor.getDao().update(actor);
                    log.info(actor.id + ":" + actor.name);
                }
            }

        }

    }

    public static void writeFile(String line) throws Exception {
        FileWriter fw = new FileWriter("decompress.txt");

        fw.write(line);

        fw.close();
    }
}
