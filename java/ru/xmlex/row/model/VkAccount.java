package ru.xmlex.row.model;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.apache.http.client.methods.HttpGet;
import ru.xmlex.common.Util;
import ru.xmlex.vk.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by xMlex on 28.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class VkAccount extends SocialAccount {
    public static final String VK_APP_ID = "2164459";
    private VkHttpClient client;
    private VkApi vkApi;
    private VkApiUsers info;
    private int userId;


    /**
     * Список друзей установивших это приложение
     */
    public VkApiAppFriends getAppFriends(String appId) {
        try {
            VkAppParams app = getAppParams(appId);
            assert app != null;

            String json = client.executeRequest(new HttpGet(
                    "https://api.vk.com/method/friends.getAppUsers?user_id=" + app.user_id + "&v=5.50&access_token=" + app.access_token
            ));
            Gson gson = new GsonBuilder().create();
            return gson.fromJson(json, VkApiAppFriends.class);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    public VkAppParams getAppParams(String appId) {
        try {
            String html = client.executeRequest(new HttpGet("http://vk.com/app" + appId));

            String vkUser = Util.getStringBetween(html, "var vk = ", ";\n\nwindow.locDomain");
            String appParams = Util.getStringBetween(html, "var params = ", ";\nvar options =");

            Gson gson = new Gson();
            return gson.fromJson(appParams, VkAppParams.class);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public VkHttpClient getClient() {
        if (client == null)
            client = new VkHttpClient(this);
        return client;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }


    public String getUserId() {
        return "vk" + String.valueOf(userId);
    }

    @Override
    public String getFirstName() {
        return getInfo().first_name;
    }

    @Override
    public String getLastName() {
        return getInfo().last_name;
    }

    @Override
    public List<String> getFriendsIdList() {
        List<String> friends = new ArrayList<>();
        VkApiAppFriends l = getAppFriends(VK_APP_ID);
        for (Integer i : l.response)
            friends.add("vk" + i);
        return friends;
    }

    @Override
    public String getAuthKey() {
        VkAppParams params = getAppParams(VK_APP_ID);
        return params.auth_key;
    }

    public VkApiUsers getInfo() {
        if (info == null) {
            List<VkApiUsers> list = null;
            try {
                list = getApi().getUsers(String.valueOf(getUserId()));
            } catch (IOException e) {
                e.printStackTrace();
            }
            if (!list.isEmpty()) {
                info = list.get(0);
            }
        }
        return info;
    }

    public VkApi getApi() {
        if (vkApi == null)
            vkApi = new VkApi(getClient());
        return vkApi;
    }

    @Override
    protected void doAuthorization() {
        setAuthorized(getClient().authorization());
    }
}
