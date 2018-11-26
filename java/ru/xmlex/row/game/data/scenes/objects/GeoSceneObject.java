package ru.xmlex.row.game.data.scenes.objects;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;
import ru.xmlex.row.game.data.User;
import ru.xmlex.row.game.data.inventory.InventoryItemObjInfo;
import ru.xmlex.row.game.data.scenes.objects.info.BuildingObjInfo;
import ru.xmlex.row.game.data.scenes.objects.info.ConstructionObjInfo;
import ru.xmlex.row.game.data.scenes.objects.info.DrawingObjInfo;
import ru.xmlex.row.game.data.scenes.types.info.*;
import ru.xmlex.row.game.data.users.BuyStatus;

import java.util.List;

/**
 * Created by xMlex on 4/6/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class GeoSceneObject extends ru.xmlex.row.game.data.scenes.SceneObject implements Cloneable {
    @Expose
    @SerializedName("c")
    public ConstructionObjInfo constructionInfo = new ConstructionObjInfo();
    @Expose
    @SerializedName("bi")
    public BuildingObjInfo buildingInfo = null;
    @Expose
    @SerializedName("ti")
    public TroopsTypeInfo troopsInfo = null;
    @Expose
    @SerializedName("tci")
    public TechnologyTypeInfo technologyInfo = null;
    @Expose
    @SerializedName("d")
    public DrawingObjInfo drawingInfo = null;
    @Expose(serialize = false)
    @SerializedName("ri")
    public InventoryItemObjInfo inventoryItemInfo = null;

    public int buyStatus = -1;
    private Resources _missingResources;
    private List<RequiredObject> missingObjects = null;

    public boolean isBuilding() {
        return buildingInfo != null;
    }

    public boolean isDrawing() {
        return drawingInfo != null;
    }

    public boolean isTroops() {
        return troopsInfo != null;
    }

    public int getLevel() {
        if (this.drawingInfo != null) {
            return this.drawingInfo.isCollected() ? 1 : 0;
        }
        return this.constructionInfo != null ? this.constructionInfo.level : 0;
    }

    public int getMaxLevel() {
        return objectType() == null ? 0 : objectType().saleableInfo.levelsCount();
    }

    public int getNextLevel() {
        int _loc1_ = this.troopsInfo == null ? this.getLevel() + 1 : 1;
        SaleableTypeInfo _loc2_ = this.geoSceneObjectType().saleableInfo;
        if (_loc2_ == null || _loc1_ > _loc2_.levelsCount()) {
            return -1;
        }
        return _loc1_;
    }

    public String getLevelString() {
        return this.getLevel() + "/" + this.getMaxLevel();
    }

    public boolean buyAllowed() {
        return this.buyStatus == BuyStatus.OBJECT_CAN_BE_BOUGHT;
    }


    public boolean buildingInProgress() {
        return this.constructionInfo != null && this.constructionInfo.constructionStartTime != null;
    }

    public boolean isBroken() {
        return isBuilding() && buildingInfo.isBroken();
    }

    public boolean canBeBroken() {
        return isBuilding() && objectType().buildingInfo != null && objectType().buildingInfo.canBeBroken;
    }

    public boolean canUpgradeOrBuy(User user) {
        if (objectType() == null)
            return false;

        if (isBuilding()) {
            if (buildingInProgress())
                return false;
            for (GeoSceneObject object : user.gameData.sector.scene.objects) {
                if (object.isBuilding() && object.buildingInProgress() && !object.canBeBroken())
                    return false;
            }
        }
        return false;
    }

    public List<RequiredObject> getMissingObjects() {
        return missingObjects;
    }

    public void setMissingObjects(List<RequiredObject> missingObjects) {
        this.missingObjects = missingObjects;
    }

    public List<RequiredObject> getRequiredObjects() {
        int level = isTroops() ? 0 : this.getLevel();
        SaleableTypeInfo typeInfo = objectType().saleableInfo;
        if (level != 0 || typeInfo == null) {
            return null;
        }
        return typeInfo.requiredObjects;
    }

    public SaleableLevelInfo getNextLevelInfo() {
        int lvl = constructionInfo.level;
        SaleableLevelInfo[] list = getAllSaleableLevelInfo();
        if (lvl >= list.length)
            return null;

        return list[lvl];
    }

    public int getTimeForNextLevelUpgrade() {
        SaleableLevelInfo levelInfo = getNextLevelInfo();
        if (levelInfo == null)
            return -1;
        return levelInfo.constructionSeconds;
    }

    // to Geo
//    public boolean canUpgrade(User user) {
//        if (geoSceneObjectType() == null)
//            return false;
//
//        if (constructionObjInfo != null && constructionObjInfo.isInProgress())
//            return false;
//
//        //log.info("P: "+user.getCountBuildingInProgress());
//        if (isBuilding() && user.getCountBuildingInProgress() > 0)
//            return false;
//
//        SaleableLevelInfo levelInfo = getNextLevelInfo();
//        if (levelInfo == null) {
//            //if (ConfigSystem.DEBUG)
//            //    log.info("Next level null");
//            return false;
//        }
//
//        if (levelInfo.requiredUserLevel > user.gameData.account.level) {
//            return false;
//        }
//
//        GeoSceneObjectType type = geoSceneObjectType();
//
//        if (type.isTechnology() && user.gameData.technologyCenter.inProgress()) {
//            return false;
//        }
//
//        if (levelInfo.requiredObjects.length > 0) {
//            log.info("Build: " + this.type + " Name: " + getName());
//            for (RequiredObject ro : levelInfo.requiredObjects) {
//                SceneObject fr = user.getSceneObject(ro.typeId);
//                boolean exist = false;
//                if (fr == null) {
//                    log.info(" RNULL: " + ro.getType().name + " Lvl: " + ro.level);
//                    return false;
//                }
//                if (ro.getType().isTechnology()) {
//                    log.info(" RTR: " + ro.getType().name + " Lvl: " + ro.level);
//                    exist = user.gameData.technologyCenter.isTechnologyLearn(ro.typeId, ro.level);
//                }
//                if (ro.getType().isBuilding()) {
//                    log.info(" BI: " + ro.getType().name + " Lvl: " + ro.level);
//                    exist = (ro.level <= fr.constructionInfo.level);
//                }
//                if (!exist) {
//                    log.info(" R: " + ro.getType().name + " Lvl: " + ro.level);
//                    return false;
//                }
//            }
//            //return false;
//        }
//
//
//        return user.gameData.account.resources.canSubstract(levelInfo.price);
//    }
    // my

    public SaleableLevelInfo getSaleableLevelInfo() {
        int _loc1_ = this.troopsInfo == null ? this.getLevel() + 1 : 1;
        SaleableTypeInfo _loc2_ = geoSceneObjectType() == null ? null : geoSceneObjectType().saleableInfo;
        if (_loc2_ == null || _loc1_ > _loc2_.levelsCount()) {
            return null;
        }
        return _loc2_.getLevelInfo(_loc1_);
    }

    public Resources getMissingResources() {
        return this._missingResources;
    }

    public void setMissingResources(Resources param1) {
        if (param1 == this._missingResources) {
            return;
        }
        if (param1 != null && this._missingResources != null && this._missingResources.equals(param1)) {
            return;
        }
        this._missingResources = param1;
    }

    public BuildingLevelInfo getBuildingLevelInfo() {
        return objectType().buildingInfo.getLevelInfo(getLevel());
    }

    // Create
    public static GeoSceneObject createBuyTroops(int type, int count) {
        GeoSceneObject object = new GeoSceneObject();
        object.troopsInfo = new TroopsTypeInfo();
        object.type = type;
        object.troopsInfo.countForBuy = count;
        return object;
    }

    public static GeoSceneObject createBuyTechnology(int type, int level) {
        GeoSceneObject object = new GeoSceneObject();
        object.technologyInfo = new TechnologyTypeInfo();
        object.type = type;
        return object;
    }

    @Override
    public String toString() {
        return "GeoSceneObject{" +
                "id=" + id +
                "typeId=" + type +
                "buyStatus=" + buyStatus +
                '}';
    }
}
