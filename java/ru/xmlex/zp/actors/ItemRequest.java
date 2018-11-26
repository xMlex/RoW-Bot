package ru.xmlex.zp.actors;

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
import ru.xmlex.common.threading.SafeRunnable;
import ru.xmlex.common.threading.ThreadPoolManager;
import ru.xmlex.zp.model.ZpAuthKey;

import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.concurrent.ScheduledFuture;

/**
 * Created by mlex on 19.10.16.
 */
public class ItemRequest extends SafeRunnable {

    private static final String HOST_VK = "https://village-vkontakte.crazypanda.ru";
    private static final String HOST_OK = "https://village-odnoklassniki.crazypanda.ru";

    private ScheduledFuture<?> future;

    public ItemRequest() {
        log.info("Item request actor initialized");
        future = ThreadPoolManager.getInstance().scheduleAtFixedRate(this, 3000, 300000);
    }

    @Override
    public void runImpl() throws Exception {
        log.fine("[BEGIN] ItemRequest");
        String auth, responce;
        Gson gson = new Gson();
        ZEAnswerStatusList status;
        ZERequest zeRequest;
        for (ZpAuthKey key : ZpAuthKey.getDao().queryForAll()) {
            if (!key.active) {
                log.fine("No active: " + key);
                continue;
            }
            log.fine("Acc: " + key);
            auth = key.generateAuth();
            auth = Base64.getEncoder().encodeToString(auth.getBytes());

            responce = request("/post/list/", auth, false);
            status = gson.fromJson(responce, ZEAnswerStatusList.class);

            if (status.requests != null) {
                for (ZERequestResponses rr : status.requests) {
                    responce = request("/post/send_response/" + rr.id, auth, false);
                    log.fine("requests: " + responce);
                }
            }
            if (status.responses != null) {
                for (ZERequestResponses rr : status.responses) {
                    responce = request("/post/accept_response/" + rr.id + "/1", auth, false);
                    log.fine("responses: " + responce);
                }
            }

            responce = request("/post/send_request/" + key.itemId, auth, true);
            log.fine("sendRequest: " + responce);
            zeRequest = gson.fromJson(responce, ZERequest.class);
            if (zeRequest.type.equalsIgnoreCase("time_limit")) {
                status.request_constraint.time_to_recovery = 3600;
            }
            log.fine("Request for: " + key.itemId + " time_to_recovery: " + status.request_constraint.time_to_recovery + " Status: " + zeRequest.name);
        }

        log.fine("[END] ItemRequest");
    }

    private String request(String subUrl, String auth, boolean friends) throws Exception {
        BasicClientCookie pandaCookie = new BasicClientCookie("panda", "1");
        pandaCookie.setDomain(HOST_VK);

        BasicCookieStore cookieStore = new BasicCookieStore();
        cookieStore.addCookie(pandaCookie);

        CloseableHttpClient httpclient = HttpClients.custom().setDefaultCookieStore(cookieStore).build();
        HttpPost httpPost = new HttpPost(HOST_VK + subUrl);

        List<NameValuePair> nvps = new ArrayList<NameValuePair>();
        nvps.add(new BasicNameValuePair("env", "Canvas"));
        nvps.add(new BasicNameValuePair("AUTH", auth));
        nvps.add(new BasicNameValuePair("lang", "ru_RU"));
        if (friends) {
            String res = "2398338,7386091,8107314,8191704,11165473,16059000,17882992,19387164,19729988,22554362,25015434,25210127,26308308,28612588,29620862,43343313,44750398,45384953,45762249,46471834,48185680,50465218,54445635,54817235,55835006,57782124,59295284,61102421,61938014,68662946,71147719,76093215,89575178,95096290,96011321,98405356,99061878,100978226,105344557,133147324,135286089,135321214,136015820,136379980,136479004,139275606,146828179,154911613,156664633,160818234,165283238,175437621,179163026,187346302,191160631,195265665,209570291,209965803,213759904,231825204,235186179,241231163,244821935,245418671,246239225,260903691";
            for (int i = 0; i < 2000; i++)
                res += "," + Rnd.get(10729988, 19729988);

            nvps.add(new BasicNameValuePair("friends", res));
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

    class ZERequest {
        public String name = "false";
        public String type = "";
        //public xConstraint constraint = null;
    }

    public class ZEAnswerLeft {
        public int left = 0;
        public int interval = 3800;
        public int time_to_recovery = 3800;
    }

    public class ZERequestResponses {
        public String user = "";
        public int id = 3800;
        public int date = 3800;
        public String actor = "";
    }

    public class ZEAnswerStatusList {
        public ZEAnswerLeft request_constraint = new ZEAnswerLeft();
        public ArrayList<ZERequestResponses> responses = new ArrayList<ZERequestResponses>();
        public ArrayList<ZERequestResponses> requests = new ArrayList<ZERequestResponses>();
    }
}
