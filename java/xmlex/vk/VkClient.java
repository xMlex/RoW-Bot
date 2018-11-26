package xmlex.vk;

import com.google.gson.Gson;
import org.apache.http.Header;
import org.apache.http.NameValuePair;
import org.apache.http.client.CookieStore;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.protocol.ClientContext;
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

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;


@SuppressWarnings("deprecation")
public class VkClient {
    private static final Logger _log = Logger.getLogger(VkClient.class.getName());
    protected CloseableHttpClient _client = HttpClients.createDefault();
    protected CookieStore _clientCookieStore = new BasicCookieStore();
    protected HttpContext _clientContext = new BasicHttpContext();
    public String _login, _pass;
    public VkAppPageInfo AppInfo = null;

    public VkClient(String login, String pass) {
        _clientContext.setAttribute(ClientContext.COOKIE_STORE, _clientCookieStore);
        _login = login;
        _pass = pass;
    }

    public boolean Login() {
        _clientCookieStore.clear();
        HttpGet httpGet = new HttpGet("http://vk.com/login.php");
        ConfigRequest(httpGet);
        try {
            CloseableHttpResponse res = _client.execute(httpGet, _clientContext);
            List<NameValuePair> postParams = new ArrayList<NameValuePair>();

            String html = EntityUtils.toString(res.getEntity(), "UTF-8");

            Document doc = Jsoup.parse(html);
            Elements formelements = doc.select("form#login input[type=hidden]");

            for (Element input : formelements)
                postParams.add(new BasicNameValuePair(input.attr("name"), input.attr("value")));
            postParams.add(new BasicNameValuePair("email", _login));
            postParams.add(new BasicNameValuePair("pass", _pass));

            HttpPost httpPost = new HttpPost(doc.select("form#login").first().attr("action"));
            ConfigRequest(httpPost);
            httpPost.setEntity(new UrlEncodedFormEntity(postParams));
            res = _client.execute(httpPost, _clientContext);

            System.out.println(res.getStatusLine());


            String redirectLocation;
            Header locationHeader = res.getFirstHeader("Location");
            if (locationHeader != null) {
                redirectLocation = locationHeader.getValue();
                if (!redirectLocation.contains("q_hash")) {
                    _log.warning("VK auth  error: incorrect login or pass. Location: " + redirectLocation + " terminate");
                    return false;
                }
            } else {
                _log.warning("VK auth  error: location not faund. terminate");
                return false;
            }
            httpGet = new HttpGet(redirectLocation);
            res = _client.execute(httpGet, _clientContext);

            httpGet = new HttpGet("http://vk.com/app2164459");
            res = _client.execute(httpGet, _clientContext);
            String page = EntityUtils.toString(res.getEntity(), "UTF-8");

            AppInfo = getAppParams(page);

            _log.info("Ok request");

            _log.info("Params: " + AppInfo.getApi_id());
            _log.info("Params: " + AppInfo.getAuth_key());
            return true;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    public String getSubPage(String url) {
        HttpGet httpGet = new HttpGet("http://vk.com/" + url);
        ConfigRequest(httpGet);
        try {
            CloseableHttpResponse res = _client.execute(httpGet, _clientContext);
            return EntityUtils.toString(res.getEntity(), "UTF-8");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public VkAppPageInfo getAppParams(String page) {
        int startPos = page.indexOf("var params = ");
        int endPos = page.indexOf("var options = ");
        String ret;
        if (startPos > 0 && endPos > 0) {
            ret = page.substring(startPos + 13, endPos - 2);
            Gson gson = new Gson();
            return gson.fromJson(ret, VkAppPageInfo.class);
        } else
            _log.warning("AppParams Not found: " + startPos + " end " + endPos);

        return null;
    }

    public static void ConfigRequest(HttpGet r) {
        r.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.76 Safari/537.36");
        r.addHeader("Accept-Language", "ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4");
        r.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
    }

    public static void ConfigRequest(HttpPost r) {
        r.addHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.76 Safari/537.36");
        r.addHeader("Accept-Language", "ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4");
        r.addHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
    }

}
