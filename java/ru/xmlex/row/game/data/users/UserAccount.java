package ru.xmlex.row.game.data.users;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;

/**
 * Created by xMlex on 4/3/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserAccount {
    @Expose
    @SerializedName("r")
    public Resources resources;
    @Expose
    @SerializedName("l")
    public int level;
    @Expose
    @SerializedName("x")
    public int experience;
    @Expose
    @SerializedName("m")
    private boolean forbidMessages;
    @Expose
    @SerializedName("f")
    private long forbidMessagesDateTo = 0;

    public Resources miningPerHour = new Resources();
    public Resources minedResources = new Resources();
    public Resources resourcesPerHour = new Resources();
    public Resources resourcesLimit = new Resources();
    public Resources resourcesConsumedByTroops = new Resources();
    public Resources resourcesConsumedByBuildings = new Resources();

    /**
     * Проверяем, хватает ли нам ресурсов
     *
     * @param res
     * @return
     */
    public boolean isEnough(Resources res) {
        return resources.canSubstract(res);
    }

    public void update(UserAccount account) {
        this.resources = account.resources;
        this.experience = account.experience;
        this.level = account.level;
        this.forbidMessages = account.forbidMessages;
        this.forbidMessagesDateTo = account.forbidMessagesDateTo;
    }
}
