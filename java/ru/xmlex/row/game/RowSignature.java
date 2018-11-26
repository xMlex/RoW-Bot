package ru.xmlex.row.game;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import org.apache.commons.codec.binary.Hex;
import org.apache.http.NameValuePair;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import ru.xmlex.common.ConfigSystem;
import ru.xmlex.row.game.db.models.RowAuthKeys;

import java.nio.charset.Charset;
import java.security.MessageDigest;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Logger;

public class RowSignature {
    private static final Logger _log = Logger.getLogger(RowSignature.class.getName());

    private static final String CRYPT_KEY = "The Matrix has you...";
    private static final String ENCRYPT_KEY = "Follow the white rabbit.";
    public String[] SERVER_LIST = new String[]{
            "https://pvvk1s00.plrm.zone/GeoVk/Segment00/segment.ashx", // Geotopia
            "https://pvvk2s00.plrm.zone/GeoVk2/Segment00/segment.ashx", // Red Zero
    };

    private String _userSocialId = "", _userHashedId = "", _userSocialAuthKey = "", _userSocialAuthSeed = "", _sessionId = "",
            _localeName = "";
    private String _url = null;
    private boolean isActive = false;

    private CloseableHttpClient _client = HttpClients.createDefault();

    public boolean callGetTouch(RowAuthKeys account) {
        isActive = false;
        setUserHashedId(account.getSocialId());
        int serverId = account.serverId - 1;
        setUrl(SERVER_LIST[serverId]);
        try {
            String r = JsonCallCmd("GetTouch", "[\"" + account.getSocialId() + "\"]");
            isActive = true;
            return true;
        } catch (RowSignature.RowProtocolException e) {
            account.deactivateByServerError(e.getMsg(), e.getCode());
            if (ConfigSystem.DEBUG)
                _log.info(_url);
            _log.throwing(this.getClass().getSimpleName(), "callGetTouch1", e);
        } catch (Exception e) {
            _log.info(_url);
            _log.throwing(this.getClass().getSimpleName(), "callGetTouch2", e);
        }
        return isActive;
    }

    public String JsonCallCmd(String method, String data, String httpMethod) throws Exception {
        if (_url == null) {
            _log.warning("JsonCallCmd->url null");
            return "";
        }
        int clientVersion = ConfigSystem.getInt("row_client_version", 505);
        // _countActiveCommands++;
        if (ConfigSystem.DEBUG)
            _log.info("--- Sign BEGIN: " + clientVersion + " Url: " + _url);
        String result = "EMPTY";

        HttpRequestBase http = null;

        if (httpMethod == null || httpMethod.equalsIgnoreCase("post")) {
            http = new HttpPost(_url);

            http.addHeader("client-type", String.valueOf(ConfigSystem.getInt("row_client_type", 1)));
            http.addHeader("client-ver", String.valueOf(clientVersion));
            http.addHeader("server-method", method);
            http.addHeader("locale-name", "ru-RU");
            if (_userSocialId != null && !_userSocialId.equals("")) {
                http.addHeader("signin-userId", _userSocialId);
            } else if (_userHashedId != null && !_userHashedId.equals("")) {
                http.addHeader("signin-userId", _userHashedId);
                if (ConfigSystem.DEBUG)
                    _log.info("--- signin-userId: " + _userHashedId);
            }
            if (_userSocialAuthKey != null && !_userSocialAuthKey.isEmpty()) {
                http.addHeader("signin-authKey", _userSocialAuthKey);
                if (ConfigSystem.DEBUG)
                    _log.info("--- signin-authKey: " + _userSocialAuthKey);
            }
            if (_userSocialAuthSeed != null && !_userSocialAuthSeed.isEmpty()) {
                http.addHeader("signin-authSeed", _userSocialAuthSeed);
                if (ConfigSystem.DEBUG)
                    _log.info("--- signin-authSeed: " + _userSocialAuthSeed);
            }
            if (_sessionId != null && !_sessionId.isEmpty()) {
                http.addHeader("signin-session", _sessionId);
                if (ConfigSystem.DEBUG)
                    _log.info("--- signin-session: " + _sessionId);
            }
            if (_localeName != null && !_localeName.isEmpty()) {
                http.addHeader("locale-name", _localeName);
                if (ConfigSystem.DEBUG)
                    _log.info("--- locale-name: " + _localeName);
            }
            String sigInCode = generateRequestSignature(method, data);
            if (ConfigSystem.DEBUG)
                _log.info("--- sign-code: " + sigInCode);
            http.addHeader("sign-code", sigInCode);

            StringEntity _et = new StringEntity(data);
            _et.setContentType("text/html");
            ((HttpPost) http).setEntity(_et);
        } else {
            List<NameValuePair> params = new LinkedList<NameValuePair>();

            params.add(new BasicNameValuePair("ver", String.valueOf(clientVersion)));
            params.add(new BasicNameValuePair("method", method));
            if (_localeName != null && !_localeName.isEmpty())
                params.add(new BasicNameValuePair("locale", _localeName));
            params.add(new BasicNameValuePair("sign", generateSignature(method, data)));
            params.add(new BasicNameValuePair("data", data));

            String paramString = URLEncodedUtils.format(params, "utf-8");

            String tempUrl = _url;
            if (!tempUrl.endsWith("?"))
                tempUrl += "?";
            tempUrl += paramString;
            _log.fine(tempUrl);
            http = new HttpGet(tempUrl);
        }
        ConfigRequest(http);


        CloseableHttpResponse res = _client.execute(http);
        result = EntityUtils.toString(res.getEntity(), "UTF-8");

        if (result.length() > 0 && result.startsWith("e")) {
            result = result.replace("e!", "").replace("e{", "{");
            throw new RowProtocolException(result);
        }
        if (result.length() > 33 && http instanceof HttpPost)
            result = result.substring(0, result.length() - 33).trim();
        return result;
    }

    public String JsonCallCmd(String method, String data) throws Exception {
        return JsonCallCmd(method, data, "POST");
    }

    public String generateRequestSignature(String method, String data) {
        String paramTextForSignatureCalculation = "";
        if (_userSocialId != null && !_userSocialId.equals("")) {
            paramTextForSignatureCalculation = method + (_userSocialId == null ? "" : _userSocialId)
                    + (_userSocialAuthKey == null ? "" : _userSocialAuthKey);
        } else {

            paramTextForSignatureCalculation = method + (_userHashedId == null ? "" : _userHashedId)
                    + (_userSocialAuthKey == null ? "" : _userSocialAuthKey);
        }
        return generateSignature(paramTextForSignatureCalculation, data);
    }

    public String generateSignature(String method, String data) {
        return MD5String(CRYPT_KEY + data + method);
    }

    public static boolean validateResponseSignature(String response, String TextForSignatureCalculation, String signature) {
        String str = ENCRYPT_KEY + response + TextForSignatureCalculation;
        return MD5String(str).equalsIgnoreCase(signature);
    }

    public static String MD5String(String str) {
        try {
            final MessageDigest messageDigest = MessageDigest.getInstance("MD5");
            messageDigest.reset();
            messageDigest.update(str.getBytes(Charset.forName("UTF8")));
            final byte[] resultByte = messageDigest.digest();
            return new String(Hex.encodeHex(resultByte));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public String getUserSocialId() {
        return _userSocialId;
    }

    public void setUserSocialId(String _userSocialId) {
        this._userSocialId = _userSocialId;
    }

    public String getUserHashedId() {
        return _userHashedId;
    }

    public void setUserHashedId(String _userHashedId) {
        this._userHashedId = _userHashedId;
    }

    public String getUserSocialAuthKey() {
        return _userSocialAuthKey;
    }

    public void setUserSocialAuthKey(String _userSocialAuthKey) {
        this._userSocialAuthKey = _userSocialAuthKey;
    }

    public static void ConfigRequest(HttpRequestBase r) {
        r.addHeader("User-Agent",
                "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.104 Safari/537.36");
        r.addHeader("Accept-Language", "ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4,de;q=0.2");
        r.addHeader("Accept", "*/*");
        r.addHeader("Accept-Encoding", "gzip, deflate");
        r.addHeader("Connection", "keep-alive");
        r.addHeader("Cache-Control", "no-cache");
        r.addHeader("Content-Type", "text/html");
        r.addHeader("Origin", "http://cdn01.x-plarium.com");
        r.addHeader("X-Compress", "null");
        r.addHeader("X-Requested-With", "ShockwaveFlash/21.0.0.197");
        r.addHeader("Referer", "http://cdn01.x-plarium.com/geo/client/vk/uc_03_23_0941_635943228607744404.swf");
    }

    public String getUserSocialAuthSeed() {
        return _userSocialAuthSeed;
    }

    public void setUserSocialAuthSeed(String _userSocialAuthSeed) {
        this._userSocialAuthSeed = _userSocialAuthSeed;
    }

    public String getSessionId() {
        return _sessionId;
    }

    public void setSessionId(String _sessionId) {
        this._sessionId = _sessionId;
    }

    public String getLocaleName() {
        return _localeName;
    }

    public void setLocaleName(String _localeName) {
        this._localeName = _localeName;
    }

    public String getUrl() {
        return _url;
    }

    public void setUrl(String _url) {
        _log.fine("Set segmentUrl: " + _url);
        if (_url != null && !_url.startsWith("http"))
            _url = "http://" + _url;
        this._url = _url;
    }

    public boolean isActive() {
        return isActive;
    }

    public static class RowProtocolException extends Exception {
        private int code = 0;
        private String msg = "NO MESSAGE";

        public RowProtocolException(String message) {
            super(message);
            Gson gson = new GsonBuilder().create();
            code = 0;
            msg = message;
            try {
                JsonObject object = gson.fromJson(message, JsonObject.class);
                code = object.get("c").getAsInt();
                msg = object.get("m").getAsString();
            } catch (Exception e) {
            }
        }

        public int getCode() {
            return code;
        }

        public String getMsg() {
            return msg;
        }
    }
}
