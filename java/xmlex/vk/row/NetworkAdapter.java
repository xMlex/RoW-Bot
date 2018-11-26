package xmlex.vk.row;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import org.apache.http.HttpHost;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import ru.xmlex.common.ConfigSystem;
import ru.xmlex.common.Util;
import ru.xmlex.row.game.RowSignature;
import xmlex.vk.VkUserInfo;
import xmlex.vk.row.model.StaticData;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.util.logging.Logger;

public class NetworkAdapter {

    private static final Logger _log = Logger.getLogger(NetworkAdapter.class.getName());

    protected CloseableHttpClient _client = HttpClients.createDefault();
    private HttpHost proxy = new HttpHost("127.0.0.1", 8888, "http");
    public RequestConfig config = RequestConfig.custom().setProxy(proxy).build();

    public int clientVersion = 449, revison = 756;
    public VkUserInfo _user = null;
    public static boolean debug = false, proxyuse = false;
    private String locale_name = "ru-RU",
            _sessionId = null,
            _dafaultUrl = "http://173.244.186.162/GeoVk/Segment02/segment.ashx",
            _stringData = "";

    protected RowClient _clientx;

    public NetworkAdapter(RowClient client) {
        clientVersion = ConfigSystem.getInt("row_client_version", 600);
        _log.info("clientVersion: " + clientVersion);
        debug = ConfigSystem.getBoolean("row_debug", true);
        proxyuse = ConfigSystem.getBoolean("row_proxy", true);
        _clientx = client;
    }

    public synchronized void setVkUser(VkUserInfo client) {
        _user = client;

        String ret = "";

        if (debug) {
            _log.info("debug load sign.json");
            ret = Util.readFile("sign.json");
        } else {
            ret = RequestSigIn();
            //Util.writeFile(ret,"sign.json");
        }

        if (ret == null) {
            //_log.warning("RequestSigIn not load static data.");
            return;
        }

        if (ret.equals("")) {
            _log.warning("RequestSigIn debug.");
            return;
        }


        GsonBuilder gson_builder = new GsonBuilder();
        Gson gson = gson_builder.create();

        JsonElement element = gson.fromJson(ret, JsonElement.class);
        JsonObject dto = element.getAsJsonObject();

        _stringData = "\"" + dto.get("s").getAsString() + "\"";

        if (!getStaticData()) {
            _log.warning("End. Not load static data.");
            return;
        }
        StaticData.getInstance();

        _clientx.serverTimeManager.initialize(dto.get("t").getAsLong(), dto.get("u")
                .getAsJsonObject().get("g").getAsJsonObject().get("cd").getAsJsonObject().get("g")
                .getAsLong());

        _sessionId = dto.get("k").getAsString();

        _clientx.parseSelf(dto);

    }

    public synchronized String RequestSigIn() {
        String ret = null;

        JSONObject reqp = new JSONObject();
        reqp.put("x", "NaN");
        reqp.put("a", true);
        reqp.put("p", (Object) null);
        reqp.put("s", (Object) null);
        reqp.put("tg", 0);
        reqp.put("fl", false);
        reqp.put("n", _user.fName + " " + _user.lName);
        reqp.put("i", "vk" + _user.userId);
        reqp.put("t", 0);
        reqp.put("u", _user.photo);
        reqp.put("d", _user.fName + ";" + _user.lName + ";NaN;ru_RU;0;;");
        reqp.put("l", "ru-RU");

        JSONObject req = new JSONObject();
        req.put("s", reqp);
        req.put("i", "vk" + _user.userId);
        req.put("mr", "");
        req.put("l", "user_apps");
        req.put("f", new JSONArray());

        ret = requestAction("SignIn", req, "POST");
        //_log.info("sign: "+ret);
        return ret;
    }

    private static String generateRequestSignature(String data, String key) {
        String ret = "The Matrix has you..." + data + key;
        RowSignature rowSignature = new RowSignature();
        return rowSignature.generateRequestSignature(key, data);
    }

    public synchronized String requestAction(String act, JSONObject obj) {
        return requestAction(act, obj, "POST");
    }

    @SuppressWarnings("deprecation")
    public String requestAction(String act, JSONObject obj, String metod) {
        String data = "", ret = "";
        if (obj != null) {
            data = obj.toString();
        }
        if (debug)
            return data;

        try {

            if (metod.startsWith("GET")) {
                String urlx = _dafaultUrl + "?ver=" + String.valueOf(clientVersion) + "&method="
                        + act + "&locale=" + locale_name + "&sign=";
                urlx = urlx + generateRequestSignature(_stringData, act);
                urlx = urlx + "&data=" + URLEncoder.encode(_stringData);
                HttpGet query = new HttpGet(urlx);
                ConfigRequest(query);
                if (debug || proxyuse)
                    query.setConfig(config);
                CloseableHttpResponse res = _client.execute(query);
                ret = EntityUtils.toString(res.getEntity(), "UTF-8");
                // query.setEntity(new StringEntity(data));
            } else {
                HttpPost query = new HttpPost(_dafaultUrl);
                ConfigRequest(query);
                StringEntity _et = new StringEntity(data);
                _et.setContentType("text/html");
                query.setEntity(_et);
                query.addHeader("sign-code",
                        generateRequestSignature(data, act + "vk" + _user.userId + _user.authKey));
                if (_sessionId != null)
                    query.addHeader("signin-session", _sessionId);
                query.addHeader("locale-name", locale_name);
                query.addHeader("signin-authKey", _user.authKey);
                query.addHeader("signin-userId", "vk" + _user.userId);
                query.addHeader("server-method", act);
                query.addHeader("client-ver", String.valueOf(clientVersion));

                if (debug || proxyuse)
                    query.setConfig(config);

                CloseableHttpResponse res = _client.execute(query);
                ret = EntityUtils.toString(res.getEntity(), "UTF-8");
                ret = ret.substring(0, ret.length() - 33).trim();
            }
        } catch (Exception e) {
            _log.warning("Request error: " + e.getMessage());
            return null;
        }
        return ret;
    }

    public void setDefaultAddress(String url) {
        _dafaultUrl = "http://" + url + "/segment.ashx";
    }

    public static void ConfigRequest(HttpGet r) {
        r.addHeader(
                "User-Agent",
                "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.76 Safari/537.36");
        r.addHeader("Accept-Language", "ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4");
        r.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
        r.addHeader("Referer", "http://vk.com/app2164459");
    }

    public static void ConfigRequest(HttpPost r) {
        r.addHeader(
                "User-Agent",
                "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.76 Safari/537.36");
        r.addHeader("Accept-Language", "ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4");
        r.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
        r.addHeader("Accept-Encoding", "gzip, deflate");
        r.addHeader("Connection", "keep-alive");
        r.addHeader("Referer", "http://vk.com/app2164459");
    }

    public synchronized boolean getStaticData() {
        File vFile = new File(clientVersion + "_static.json");
        File sFile = new File("static.json");
        boolean ret = false;
        if (vFile.exists()) {
            ret = true;
        } else {
            _log.info("Loading static data...");
            String res = requestAction("Client.GetStaticData", null, "GET");
            try {
                PrintWriter out = new PrintWriter(clientVersion + "_static.json");
                out.println(res);
                out.close();

                if (sFile.exists())
                    sFile.delete();
                Files.copy(vFile.toPath(), sFile.toPath());
                ret = true;
            } catch (FileNotFoundException e) {
                _log.warning("File not found: " + e);
            } catch (IOException e) {
                _log.warning("File not copy: " + e);
            }
            _log.info("Static data loaded.");
        }
        return ret;
    }

}
