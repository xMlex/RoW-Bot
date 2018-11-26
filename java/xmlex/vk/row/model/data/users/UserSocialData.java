package xmlex.vk.row.model.data.users;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

public class UserSocialData {

    public int socialId;
    public String profileUrl, fullName;

    public static UserSocialData fromDto(JsonElement param1) {
        UserSocialData _loc2_ = new UserSocialData();
        JsonObject p1 = param1.getAsJsonObject();
        _loc2_.socialId = p1.get("i").getAsInt();
        _loc2_.profileUrl = p1.get("s") == null ? p1.get("s").getAsString() : "";
        //_loc2_.fullName = param1.n == null?"0":StringUtil.replaceSpecExpressions(param1.n);
        /*if(param1.u == null)
        {
           _loc2_._photoUrl = "";
        }
        else
        {
           _loc2_._photoUrl = UserNote.fixFbPhotoUrl(param1.u);
        }
        if(_loc2_._photoUrl.indexOf("question") != -1)
        {
           _loc2_._photoUrl = ServerManager.buildContentUrl("ui/question_a.gif");
        }
        _loc2_.sex = param1.x;
        _loc2_.locale = param1.l;
        _loc2_.customData = param1.d;
        _loc2_.hashedId = param1.h;
        _loc2_.appPermissions = param1.p;
        if(param1.m)
        {
           _loc2_.email = param1.m;
        }
        if(param1.tg)
        {
           _loc2_.paymentTestGroup = param1.tg;
        }
        if(param1.fl)
        {
           _loc2_.isLiked = param1.fl;
        }*/
        return _loc2_;
    }

}
