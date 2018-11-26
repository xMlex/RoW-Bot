package ru.xmlex.zp.net;

import com.google.gson.Gson;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.cookie.BasicClientCookie;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import ru.xmlex.common.Rnd;
import ru.xmlex.zp.model.ZpAuthKey;
import ru.xmlex.zp.net.api.ZpStartResponse;
import xmlex.extensions.crypt.StringMD5;

import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.logging.Logger;

/**
 * Created by mlex on 21.10.16.
 */
public class ZpApi {
    protected static final Logger log = Logger.getLogger(ZpApi.class.getName());
    private static final String HOST_VK = "https://village-vkontakte.crazypanda.ru";
    private static final String HOST_OK = "https://village-odnoklassniki.crazypanda.ru";
    private static final Gson gson = new Gson();


    private final ZpAuthKey authKey;

    private BasicCookieStore cookieStore = new BasicCookieStore();
    private final CloseableHttpClient httpclient;

    public ZpApi(ZpAuthKey authKey) {
        this.authKey = authKey;
        BasicClientCookie pandaCookie = new BasicClientCookie("panda", "1");
        pandaCookie.setDomain(getHost());
        cookieStore.addCookie(pandaCookie);

        httpclient = HttpClients.custom().setDefaultCookieStore(cookieStore).build();
        log.info("ZpAPi host: " + getHost());
    }

    public ZpStartResponse start() throws Exception {
        return gson.fromJson(request("/social/start", authKey.generateAuth(), true), ZpStartResponse.class);
    }

    private String request(String subUrl, String auth, boolean friends) throws Exception {
        HttpPost httpPost = new HttpPost(getHost() + subUrl);

        List<NameValuePair> nvps = new ArrayList<NameValuePair>();
        nvps.add(new BasicNameValuePair("AUTH", Base64.getEncoder().encodeToString(auth.getBytes())));
        nvps.add(new BasicNameValuePair("env", "Canvas"));
        nvps.add(new BasicNameValuePair("lang", "ru_RU"));
        if (friends) {
            String res = "2398338";
            for (int i = 0; i < 20; i++)
                res += "," + Rnd.get(10729988, 19729988);
            String k = authKey.socialId + StringMD5.MD5String(res) + authKey.getAppId();
            nvps.add(new BasicNameValuePair("afkey", StringMD5.MD5String(k)));
            nvps.add(new BasicNameValuePair("afids", res));
            nvps.add(new BasicNameValuePair("ref_uid", authKey.socialId));
        }
        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse response2 = httpclient.execute(httpPost);

        try {
            HttpEntity entity2 = response2.getEntity();
            return EntityUtils.toString(entity2);
        } finally {
            response2.close();
        }
    }

    public String getHost() {
        if (authKey.socialType.equalsIgnoreCase("vk")) {
            return HOST_VK;
        } else {
            return HOST_OK;
        }
    }
}
