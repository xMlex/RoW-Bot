package xmlex.vk.row.model.data;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import xmlex.vk.row.model.data.users.UserSocialData;

public class User {

    public int id;
    public UserSocialData socialData;
    public UserGameData gameData;

    public static User fromDto(JsonElement param1) {
        User _loc2_ = new User();
        JsonObject p1 = param1.getAsJsonObject();
        _loc2_.id = p1.get("i").getAsInt();
        _loc2_.socialData = UserSocialData.fromDto(p1.get("s"));
        _loc2_.gameData = UserGameData.fromDto(p1.get("g"));
        return _loc2_;
    }
}
