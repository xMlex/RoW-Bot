package xmlex.vk.row.model.data.users;

import com.google.gson.JsonElement;
import xmlex.vk.row.model.data.Resources;

public class UserAccount {

    public int experience, level;
    public Resources resources, minedResources;


    public static UserAccount fromDto(JsonElement param1) {
        UserAccount _loc2_ = new UserAccount();
        _loc2_.resources = Resources.fromDto(param1.getAsJsonObject().get("r"));
        _loc2_.minedResources = new Resources();
        _loc2_.level = param1.getAsJsonObject().get("r").getAsInt();
        _loc2_.experience = param1.getAsJsonObject().get("x").getAsInt();
        return _loc2_;
    }


    public int getExperience() {
        return experience;
    }


    public void setExperience(int experience) {
        this.experience = experience;
    }


    public int getLevel() {
        return level;
    }


    public void setLevel(int level) {
        this.level = level;
    }

    public void update(UserAccount param1) {
        this.resources = param1.resources;
        this.experience = param1.experience;
        this.level = param1.level;
    }
}
