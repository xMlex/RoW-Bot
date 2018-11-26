package ru.xmlex.vk;

import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 4/4/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class VkAppParams {
    public String access_token;
    public String ads_app_id;
    public String auth_key;
    public int api_id;
    @SerializedName("viewer_id")
    public int user_id;
}
