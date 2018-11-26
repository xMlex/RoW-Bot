package ru.xmlex.zp.core.xclient;

import com.google.gson.Gson;
import org.apache.http.client.CookieStore;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.client.protocol.ClientContext;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * Created by theml on 08.10.2016.
 */
public class CrazyPandaApi {
    private CloseableHttpClient httpClient = HttpClients.createDefault();
    private HttpContext clientContext = new BasicHttpContext();
    private CookieStore cookieStore = new BasicCookieStore();

    private static Random rnd = new Random();

    public CrazyPandaApi() {
        clientContext.setAttribute(ClientContext.COOKIE_STORE, cookieStore);
    }

    public String socialStart(String auth) throws IOException {
        List<BasicNameValuePair> authParams = new ArrayList<>();
        authParams.add(new BasicNameValuePair("lang", "ru_RU"));
        authParams.add(new BasicNameValuePair("AUTH", auth));
        authParams.add(new BasicNameValuePair("env", "Canvas"));

        HttpPost authRequest = new HttpPost("https://village-odnoklassniki.crazypanda.ru/social/start");
        authRequest.setEntity(new UrlEncodedFormEntity(authParams));

        CloseableHttpResponse response = httpClient.execute(authRequest, clientContext);
        response.close();

        return executeRequest(authRequest);
    }

    public String getAuth() throws IOException {
        String html = executeRequest(new HttpGet("https://village-odnoklassniki.crazypanda.ru/social/application?web_server=https%3A%2F%2Fok.ru&first_start=0&logged_user_id=155190229697&sig=f243cd61d905a5e58c8f5cd05cc92ebe&refplace=user_apps&new_sig=1&apiconnection=1541888_1476005618076&authorized=1&session_key=b179ZvlNEf043zkto270aSINF92batlGjd64Xvmvn4a47UpNf94.6UsLne5&clientLog=0&session_secret_key=363bd18bcdc840d1f56b72cbea211f7b&auth_sig=b368600989358272b1fb742e31086e30&api_server=https%3A%2F%2Fapi.ok.ru%2F&ip_geo_location=RU%2C69%2CSmolensk&application_key=CBAIIIBBABABABABA"));

        int posStart = html.indexOf("data       : ");
        html = html.substring(posStart).substring(13);
        int posEnd = html.indexOf(",\n              overlay");
        html = html.substring(0, posEnd);

        Gson gson = new Gson();
        FlashData flashData = gson.fromJson(html, FlashData.class);

        //System.out.println(html);
        return flashData.socialAuth;
    }

    public String getStaticKey() {
        String str = "";//Base64.encodeBase64(new String("{\"main\":1,\"subenv\":null,\"environment\":\"Canvas\",\"instance\":\"198767770442137" + rnd.nextInt(9) + "\",\"env\":\"Canvas\"}").replace("\n", "").replace("\r", "").getBytes());
        System.out.println(str);
        return str;
    }

    public String executeGet(String url) throws IOException {
        return executeRequest(new HttpGet(url));
    }

    public String executeGet(String url, List<BasicNameValuePair> params) throws IOException {

        if (params != null) {
            url = url + "?" + URLEncodedUtils.format(params, "utf-8");
        }
        //log.info("vkGet: " + url);
        return executeRequest(new HttpGet(url));
    }

    public String executeRequest(HttpRequestBase r) throws IOException {
        configRequest(r);
        CloseableHttpResponse response = httpClient.execute(r, clientContext);
        String text = EntityUtils.toString(response.getEntity(), "UTF-8");
        response.close();
        saveCookie();
        return text;
    }

    public static void configRequest(HttpRequestBase r) {
        r.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.76 Safari/537.36");
        r.addHeader("Accept-Language", "ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4");
        r.addHeader("Accept-Encoding", "gzip, deflate, sdch");
        r.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
        r.addHeader("Origin", "https://village-odnoklassniki.static.crazypanda.ru");
        r.addHeader("Referer", "https://village-odnoklassniki.static.crazypanda.ru/s/swf/apploader-ver457.swf");
        r.addHeader("X-Requested-With", "ShockwaveFlash/23.0.0.162");
        r.addHeader("X-Compress", "null");
    }

    private void saveCookie() {
        if (cookieStore.getCookies().isEmpty())
            return;
//        try {
//            //Util.writeObject(new File("./data/cookies/" + user.getLogin() + ".ser"), cookieStore);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
    }


    public String myTop(String authKey) throws IOException {
        List<BasicNameValuePair> authParams = new ArrayList<>();
        authParams.add(new BasicNameValuePair("lang", "ru_RU"));
        authParams.add(new BasicNameValuePair("AUTH", authKey));
        authParams.add(new BasicNameValuePair("env", "Canvas"));
        authParams.add(new BasicNameValuePair("count", "500"));
        authParams.add(new BasicNameValuePair("nocache", "" + rnd.nextInt()));
        authParams.add(new BasicNameValuePair("friends", "957152500912,166564227775,196193655339,137640520845,68342799895,162890934294,148210736010,181604722426,928451106988,164169077206,156879069733,160826879937,956355430687"));

        HttpPost authRequest = new HttpPost("https://village-odnoklassniki.crazypanda.ru/mytop");
        authRequest.setEntity(new UrlEncodedFormEntity(authParams));

        CloseableHttpResponse response = httpClient.execute(authRequest, clientContext);
        response.close();

        return executeRequest(authRequest);
    }

    public String handshake(String authKey) throws IOException {
        List<BasicNameValuePair> authParams = new ArrayList<>();
//        authParams.add(new BasicNameValuePair("lang", "ru_RU"));
//        authParams.add(new BasicNameValuePair("AUTH", authKey));
//        authParams.add(new BasicNameValuePair("env", "Canvas"));
//        authParams.add(new BasicNameValuePair("count", "500"));
//        authParams.add(new BasicNameValuePair("nocache", ""+rnd.nextInt()));
        authParams.add(new BasicNameValuePair("handshake", "{\"sns\":\"Odnoklassniki\",\"prj\":\"villageOdnoklassniki\",\"uid\":\"155190229697\",\"sex\":2,\"age\":25,\"tags\":[\"begin_record\"],\"lvl\":52}"));

        HttpPost authRequest = new HttpPost("https://playtest.crazypanda.ru/handshake");
        authRequest.setEntity(new UrlEncodedFormEntity(authParams));

        CloseableHttpResponse response = httpClient.execute(authRequest, clientContext);
        response.close();

        return executeRequest(authRequest);
    }

    public String postList(String authKey) throws IOException {
        List<BasicNameValuePair> authParams = new ArrayList<>();
        authParams.add(new BasicNameValuePair("lang", "ru_RU"));
        authParams.add(new BasicNameValuePair("AUTH", authKey));
        authParams.add(new BasicNameValuePair("env", "Canvas"));

        HttpPost authRequest = new HttpPost("https://village-odnoklassniki.crazypanda.ru/post/list/");
        authRequest.setEntity(new UrlEncodedFormEntity(authParams));

        CloseableHttpResponse response = httpClient.execute(authRequest, clientContext);
        response.close();

        return executeRequest(authRequest);
    }
}
