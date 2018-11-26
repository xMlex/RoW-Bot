package ru.xmlex.row.game.data;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.SocialUser;

import java.util.ArrayList;

/**
 * Created by xMlex on 29.03.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserSocialData {

    @Expose
    @SerializedName("i")
    public String socialId;

    @Expose
    @SerializedName("s")
    public String profileUrl = null;

    @Expose
    @SerializedName("n")
    public String fullName = "";

    @Expose
    @SerializedName("u")
    public String photoUrl = "";

    @Expose
    @SerializedName("x")
    public String sex = "NaN";

    @Expose
    @SerializedName("l")
    public String locale = "ru-RU";

    @Expose
    @SerializedName("d")
    public String customData = "";

    @Expose(serialize = false, deserialize = false)
    @SerializedName("h")
    private String hashedId = "";

    @Expose
    @SerializedName("p")
    public String appPermissions = null;

    @Expose
    @SerializedName("ar")
    public String ageRange = null;

    @Expose
    @SerializedName("np")
    public boolean nppAvailable = false;

    @Expose
    @SerializedName("a")
    public boolean isApproved = true;

    @Expose
    @SerializedName("im")
    public boolean incognitoMode = false;

    @Expose
    @SerializedName("vk")
    public pVk vk = new pVk();

    @Expose
    @SerializedName("t")
    public int userType = 0;

    @Expose
    @SerializedName("tg")
    public int paymentTestGroup = 0;

    @Expose
    @SerializedName("fl")
    public boolean isLiked = false;

    @Expose
    @SerializedName("gr")
    public String giftRequests = null;

    @Expose
    @SerializedName("tpi")
    public String thirdPartyId = null;

    @SerializedName("de")
    @Expose
    public String devicesList = null;

    public ArrayList<String> friends = new ArrayList<String>();


    public UserSocialData(SocialUser su) {
        this();
        fromSocialUser(su);
    }

    public UserSocialData() {

    }

    private void fromSocialUser(SocialUser su) {
        socialId = su.uid;
        fullName = su.first_name + " " + su.last_name;
        locale = normalizeLocale(su.locale);
        customData = su.getSocialNetworkData();
        friends.add("vk8087287");
        friends.add("vk135321214");
        friends.add("vk144157510");
        friends.add("vk154911613");
    }

    private static String normalizeLocale(String param1) {
        if (param1 == null) {
            return null;
        }
        return param1.replace("_", "-");
    }

    private static class pVk {
        @Expose
        @SerializedName("b")
        boolean vkShowInMenuStatus = false;
    }
}
