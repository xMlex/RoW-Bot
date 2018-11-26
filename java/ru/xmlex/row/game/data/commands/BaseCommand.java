package ru.xmlex.row.game.data.commands;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import io.gsonfire.GsonFireBuilder;
import ru.xmlex.common.ConfigSystem;
import ru.xmlex.common.MessageNotifier;
import ru.xmlex.common.Util;
import ru.xmlex.row.game.GameClient;
import ru.xmlex.row.game.RowSignature;
import ru.xmlex.row.game.common.gson.AdapterBooleanRow;
import ru.xmlex.row.game.logic.inventory.UserInventoryData;

import java.io.File;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Created by xMlex on 29.03.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public abstract class BaseCommand implements Runnable, ICommandAction {

    protected static final Logger log = Logger.getLogger(BaseCommand.class.getName());
    private static Gson gsonWithoutExpose = null;
    private static Gson gson = null;
    private static Gson gsonIgnoreNull = null;

    private GameClient client;
    private String action;
    private String body;
    private String method = "POST";
    private boolean safeResult = false;
    private boolean userRefresh = true;

    @Override
    public void run() {
        try {
            onCommandInit();
            if (ConfigSystem.DEBUG) {
                log.info("SendRequest: " + getAction());
                log.info("SendData: " + getBody());
            }


            File f = new File("./log/" + getClient().getAccount().id + "." + getClass().getSimpleName() + ".json");
            if (f.exists() && safeResult) {
                onCommandResult(Util.readFile(f.getAbsolutePath()));
            } else {
                String res = getClient().getCrypt().JsonCallCmd(action, body, method);
                if (ConfigSystem.DEBUG)
                    Util.writeFile(res, f.getAbsolutePath());
                if (userRefresh)
                    UserRefreshCmd.updateUserByResultDto(res, getClient().getUser());
                onCommandResult(res);
            }
        } catch (RowSignature.RowProtocolException e) {
            if (e.getCode() == -3) {
                log.log(Level.INFO, "Забанен на сервере");
                return;
            }
            String msg = "Лог ошибки: " + e.getMessage()
                    + "\nКлиент: " + client.toString()
                    + "\nSendRequest: " + client.toString()
                    + "\nSendAction: " + getAction()
                    + "\nSendData: " + getBody();

            // Смена auth_key
            if (e.getCode() == 0) {
                client.getAccount().deactivateByServerError(e.getMsg(), e.getCode());
                return;
            }

            if (!ConfigSystem.DEBUG)
                MessageNotifier.getInstance().log(msg);

            log.log(Level.SEVERE, "Ошибка в протоколе:\n" + msg, e);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public GameClient getClient() {
        return client;
    }

    public BaseCommand setClient(GameClient client) {
        this.client = client;
        return this;
    }

    public String getAction() {
        return action;
    }

    public BaseCommand setAction(String action) {
        this.action = action;
        return this;
    }

    public String getBody() {
        return body;
    }

    public BaseCommand setBody(String body) {
        this.body = body;
        return this;
    }

    public String getMethod() {
        return method;
    }

    public BaseCommand setMethod(String method) {
        this.method = method;
        return this;
    }

    public BaseCommand setSafeResult(boolean safeResult) {
        this.safeResult = safeResult;
        return this;
    }

    public static Gson getGson() {
        if (gson == null) {
            gson = new GsonBuilder()
                    .registerTypeAdapter(boolean.class, new AdapterBooleanRow())
                    .registerTypeAdapter(Boolean.class, new AdapterBooleanRow())
                    .serializeNulls().create();
        }
        return gson;
    }

    public static Gson getGsonIgnoreNull() {
        if (gson == null) {
            gson = new GsonFireBuilder()
                    .enableHooks(UserInventoryData.class)
                    .createGsonBuilder()
                    .registerTypeAdapter(boolean.class, new AdapterBooleanRow())
                    .registerTypeAdapter(Boolean.class, new AdapterBooleanRow())
                    .create();

//            gson = new GsonBuilder()
//                    .registerTypeAdapter(boolean.class, new AdapterBooleanRow())
//                    .registerTypeAdapter(Boolean.class, new AdapterBooleanRow())
//                    .create();
        }
        return gson;
    }

    public static Gson getGsonWithoutExpose() {
        if (gsonWithoutExpose == null) {
            gsonWithoutExpose = new GsonFireBuilder()
                    .enableHooks(UserInventoryData.class)
                    .createGsonBuilder()
                    .registerTypeAdapter(boolean.class, new AdapterBooleanRow())
                    .registerTypeAdapter(Boolean.class, new AdapterBooleanRow())
                    .excludeFieldsWithoutExposeAnnotation().serializeNulls().create();
        }
        return gsonWithoutExpose;
    }

    public boolean isUserRefresh() {
        return userRefresh;
    }

    public void setUserRefresh(boolean userRefresh) {
        this.userRefresh = userRefresh;
    }
}
