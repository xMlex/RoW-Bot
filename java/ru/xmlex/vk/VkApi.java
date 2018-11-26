package ru.xmlex.vk;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import org.apache.http.message.BasicNameValuePair;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by xMlex on 4/5/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class VkApi {
    public static final String URL = "https://api.vk.com/method/";
    public static final String VERSION = "5.50";
    public static final String GET_USERS_FILEDS = "verified,sex,has_photo,photo_max,photo_100";
    public static final Gson GSON = new GsonBuilder().create();

    private IHttpExecutor httpExecutor;

    public VkApi(IHttpExecutor executor) {
        if (executor == null)
            throw new IllegalArgumentException("HttpExecutor = null");
        this.httpExecutor = executor;
    }

    public List<VkApiUsers> getUsers(String userIds) throws IOException {
        List<BasicNameValuePair> params = preparePapams();
        params.add(new BasicNameValuePair("user_id", userIds.replace("vk", "")));
        params.add(new BasicNameValuePair("fields", GET_USERS_FILEDS));
        String json = httpExecutor.executeGet(URL + "users.get", params);
        JsonElement responce = parseResponce(json);
        List<VkApiUsers> result = new ArrayList<>();
        if (responce.isJsonArray()) {
            for (JsonElement jsonElement : responce.getAsJsonArray()) {
                result.add(GSON.fromJson(jsonElement, VkApiUsers.class));
            }
        }
        return result;
    }

    public static List<BasicNameValuePair> preparePapams() {
        List<BasicNameValuePair> params = new ArrayList<>();
        params.add(new BasicNameValuePair("v", VERSION));
        return params;
    }

    public static JsonElement parseResponce(String str) {
        JsonObject object = GSON.fromJson(str, JsonObject.class);
        if (object.has("response")) {
            return object.get("response");
        } else {
            return object;
        }
    }
}
