package ru.xmlex.row.game.data;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.GameClient;
import ru.xmlex.row.game.data.scenes.SceneObject;
import ru.xmlex.row.game.data.scenes.objects.GeoSceneObject;
import ru.xmlex.row.game.data.units.Unit;
import ru.xmlex.row.game.db.models.RowAuthKeys;
import ru.xmlex.row.game.logic.UserManager;
import ru.xmlex.row.game.logic.UserNoteManager;
import ru.xmlex.row.game.logic.UserQuestManager;

import java.util.logging.Logger;

/**
 * Created by xMlex on 4/2/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class User {
    protected static final Logger log = Logger.getLogger(User.class.getName());
    @Expose
    @SerializedName("i")
    public int id;
    @Expose
    @SerializedName("c")
    public boolean canBeCyborg = false;
    @Expose
    @SerializedName("g")
    public UserGameData gameData = null;

    //public UserSocialData userSocialData = new UserSocialData(null);

    public UserRefreshData refreshData = new UserRefreshData();
    public GameClient client;
    public UserManager userManager = new UserManager();
    public UserNoteManager userNoteManager = new UserNoteManager();
    public UserQuestManager userQuestManager = new UserQuestManager();

    /**
     * Кол-во строящихсяв данный момент зданий
     */
    public int getCountBuildingInProgress() {
        int count = 0;
        for (GeoSceneObject object : gameData.sector.scene.objects)
            if (object.isBuilding() && object.constructionInfo.isInProgress() && !object.objectType().buildingInfo.canBeBroken) {
                count++;
                //log.info("InProgress: " + object.getName() + " t: " + object.type);
            }
        return count;
    }

    public SceneObject getSceneObject(int id) {
        for (GeoSceneObject geoSceneObject : gameData.sector.scene.objects) {
            if (geoSceneObject.type == id)
                return geoSceneObject;
        }

        for (SceneObject technology : gameData.technologyCenter.technologies) {
            if (technology.type == id)
                return technology;
        }
        return null;
    }

    public Unit getUnit(int id) {
//        for (Unit unit : gameData.worldData.units) {
//            if (unit.unitId == id)
//                return unit;
//        }
        return null;
    }

    public GameClient getClient() {
        return client;
    }

    public void setClient(GameClient client) {
        this.client = client;
    }

    public RowAuthKeys getAccount() {
        return client.getAccount();
    }
}
