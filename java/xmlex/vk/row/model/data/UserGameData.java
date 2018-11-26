package xmlex.vk.row.model.data;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import xmlex.vk.row.model.data.map.MapPos;
import xmlex.vk.row.model.data.users.UserAccount;
import xmlex.vk.row.model.data.users.UserCommonData;

import java.util.Date;

public class UserGameData {

    public int revision = 0;
    public Date normalizationTime;
    public boolean settingsDirty;
    public UserAccount account;
    public MapPos mapPos;
    public UserCommonData commonData;
    public int resourcesUraniumCount = 5, resourcesTitaniumCount = 5;

    public static UserGameData fromDto(JsonElement param1) {
        UserGameData _loc2_ = new UserGameData();
        JsonObject p1 = param1.getAsJsonObject();
        _loc2_.revision = p1.get("r").getAsInt();
        _loc2_.normalizationTime = new Date(p1.get("t").getAsLong());
        _loc2_.account = UserAccount.fromDto(p1.get("a"));
        _loc2_.mapPos = MapPos.fromDto(p1.get("map"));
        _loc2_.commonData = UserCommonData.fromDto(p1.get("cd"));
        //clanData
        //messageData


        return _loc2_;
    }

}
