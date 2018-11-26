package ru.xmlex.vk;


import org.apache.http.Header;
import org.apache.http.client.CookieStore;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.client.protocol.ClientContext;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.cookie.Cookie;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import ru.xmlex.common.Util;
import ru.xmlex.row.model.VkAccount;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by xMlex on 04.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class VkHttpClient implements IHttpExecutor {
    private static final Logger log = Logger.getLogger(VkHttpClient.class.getName());
    private static final Pattern patternUserId = Pattern.compile("id: (\\d+),");
    private static final Pattern patternUserIdMobile = Pattern.compile("id=(\\d+)\"");
    private static final Pattern patternOnLoginDone = Pattern.compile("parent\\.onLoginDone\\('/(.*?)'\\)");

    private VkAccount user;
    private CloseableHttpClient httpClient = HttpClients.createDefault();
    private HttpContext clientContext = new BasicHttpContext();
    private CookieStore cookieStore = new BasicCookieStore();

    public VkHttpClient(VkAccount user) {
        this.user = user;
        clientContext.setAttribute(ClientContext.COOKIE_STORE, cookieStore);
        loadCookie();
    }

    public boolean authorization() {
        if (user.isAuthorized())
            return true;

        try {
            String loginPage = executeRequest(new HttpGet("https://m.vk.com/login"));
            Document doc = Jsoup.parse(loginPage);

            if (loginPage.indexOf("<div class=\"reply_fakebox\">") > 0) {
                trySetUserId(loginPage);
                return true;
            }

            List<BasicNameValuePair> authParams = new ArrayList<>();

            Elements loginFormHiddens = doc.select("form input[type=hidden]");
            for (Element input : loginFormHiddens)
                authParams.add(new BasicNameValuePair(input.attr("name"), input.attr("value")));

            authParams.add(new BasicNameValuePair("email", user.getLogin()));
            authParams.add(new BasicNameValuePair("pass", user.getPassword()));

            String action = doc.select("form").first().attr("action");
            assert action != null;

            HttpPost authRequest = new HttpPost(action);
            authRequest.setEntity(new UrlEncodedFormEntity(authParams));

            CloseableHttpResponse response = httpClient.execute(authRequest, clientContext);
            Header locationHeader = response.getFirstHeader("Location");
            response.close();

            if (locationHeader == null || locationHeader.getValue().isEmpty()) {
                log.warning("VkHttpClient->authorization redirect url = null");
                return false;
            } else {
                if (!locationHeader.getValue().contains("__q_hash")) {
                    log.warning("VkHttpClient->authorization login or password incorrect: " + locationHeader.getValue());
                    return false;
                }
                String result = executeRequest(new HttpGet(locationHeader.getValue()));
                result = executeRequest(new HttpGet("http://vk.com/settings"));
                trySetUserId(result);
                System.out.println("Autorized: " + user.getUserId());
                return !user.getUserId().equalsIgnoreCase("0");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return false;
    }

    public String executeGet(String url, List<BasicNameValuePair> params) throws IOException {

        if (params != null) {
            url = url + "?" + URLEncodedUtils.format(params, "utf-8");
        }
        log.info("vkGet: " + url);
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

    private void saveCookie() {
        if (cookieStore.getCookies().isEmpty())
            return;
        try {
            Util.writeObject(new File("./data/cookies/" + user.getLogin() + ".ser"), cookieStore);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void loadCookie() {
        cookieStore.getCookies().clear();
        try {
            BasicCookieStore cookies = Util.readObject(new File("./data/cookies/" + user.getLogin() + ".ser"), BasicCookieStore.class);
            if (cookies == null || cookies.getCookies().isEmpty())
                return;
            for (Cookie cookie : cookies.getCookies())
                cookieStore.addCookie(cookie);
            String result = executeRequest(new HttpGet("http://vk.com/settings"));
            if (result.contains("Моя Страница")) {
                user.setAuthorized(true);
                trySetUserId(result);
            } else {
                user.setAuthorized(false);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public void trySetUserId(String str) {
        Matcher m = patternUserId.matcher(str);
        if (m.find()) {
            user.setUserId(Integer.valueOf(m.group(1)));
        } else {
            m = patternUserIdMobile.matcher(str);
            if (m.find()) {
                user.setUserId(Integer.valueOf(m.group(1)));
            } else {
                System.out.println("User id not found");
            }
        }
    }

    public static void configRequest(HttpRequestBase r) {
        r.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.76 Safari/537.36");
        r.addHeader("Accept-Language", "ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4");
        r.addHeader("Accept-Encoding", "gzip, deflate, sdch");
        r.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
        r.addHeader("X-Compress", "null");
    }
}
