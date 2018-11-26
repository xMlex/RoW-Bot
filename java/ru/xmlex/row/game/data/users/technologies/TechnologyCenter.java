package ru.xmlex.row.game.data.users.technologies;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;
import ru.xmlex.row.game.data.User;
import ru.xmlex.row.game.data.scenes.objects.GeoSceneObject;
import ru.xmlex.row.game.data.users.BuyStatus;
import ru.xmlex.row.game.data.users.UserBuyingData;
import ru.xmlex.row.game.logic.StaticDataManager;
import ru.xmlex.row.game.logic.commands.sector.BuyCommand;
import ru.xmlex.row.instancemanager.listeners.UserListener;
import xmlex.vk.row.model.data.scenes.types.GeoSceneObjectType;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xMlex on 19.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class TechnologyCenter implements UserListener {
    @Expose
    @SerializedName("tl")
    public List<GeoSceneObject> technologies = new ArrayList<>();

    //public Dictionary technologiesDic;

    public int researchedTechnologiesCount = 0;

    public int drawingPartCount = 0;

    public int technologiesResearching = 0;


    public boolean isTechnologyLearn(int id, int level) {
        for (GeoSceneObject technology : technologies) {
            if (technology.type == id && technology.constructionInfo.level <= level)
                return true;
        }
        return false;
    }

    /**
     * @return true если есть хоть 1 технология в процессе.
     */
    public boolean inProgress() {
        for (GeoSceneObject technology : technologies) {
            if (technology.constructionInfo.isInProgress())
                return true;
        }
        return false;
    }

    public GeoSceneObject getTechnology(int id) {
        for (GeoSceneObject object : technologies) {
            if (object.type == id)
                return object;
        }
        return null;
    }

    public boolean hasActiveTechnology(int param1, int param2) {
        for (GeoSceneObject _loc3_ : this.technologies) {
            if (_loc3_.objectType().id == param1 && _loc3_.constructionInfo.level >= param2) {
                return true;
            }
        }
        return false;
    }

    /**
     * Выбираем лучшую технологию для улучшения. По принципу: быстрее - лучше :)
     *
     * @param user
     * @return
     */
    public GeoSceneObject getBestForUpgrade(User user) {

        // Ищем все, которые можем изучить - но не изучили
        for (GeoSceneObjectType objectType : StaticDataManager.getInstance().geoSceneObjectTypeList) {
            if (!objectType.isTechnology() || hasActiveTechnology(objectType.id, 1))
                continue;

            GeoSceneObject buy = GeoSceneObject.createBuyTechnology(objectType.id, 1);

        }


        GeoSceneObject object = null;
        for (GeoSceneObject technology : technologies) {
            UserBuyingData.updateObjectStatus(technology, user);
            //System.out.println("T: " + technology.getName() + " lvl: " + technology.getLevel()+" buy: "+BuyStatus.getNameById(technology.buyStatus));
            if (technology.buyStatus == BuyStatus.OBJECT_CAN_BE_BOUGHT) {
                if (object == null) {
                    object = technology;
                } else {
                    if (technology.getTimeForNextLevelUpgrade() < object.getTimeForNextLevelUpgrade())
                        object = technology;
                }
            }
        }
        return object;
    }

    @Override
    public void processUser(User user) {
        GeoSceneObject object = getBestForUpgrade(user);
        if (object == null)
            return;

        Resources price = object.getNextLevelInfo().price;
        user.gameData.account.resources.substract(price);
        user.getClient().executeCmd(new BuyCommand(object));
    }
}
