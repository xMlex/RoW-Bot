package ru.xmlex.row.game.data.scenes;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.scenes.objects.info.GraphicsObjInfo;
import ru.xmlex.row.game.data.scenes.types.info.SaleableLevelInfo;
import ru.xmlex.row.game.logic.StaticDataManager;
import xmlex.vk.row.model.data.scenes.types.GeoSceneObjectType;

import java.util.logging.Logger;

/**
 * Created by xMlex on 4/2/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class SceneObject implements ru.xmlex.row.game.objects.SceneObject {
    protected static final Logger log = Logger.getLogger(SceneObject.class.getName());

    @Expose
    @SerializedName("i")
    public int id = -1;
    @Expose
    @SerializedName("t")
    public int type;
    @Expose
    @SerializedName("gi")
    public GraphicsObjInfo graphicsObjInfo = new GraphicsObjInfo();

    private GeoSceneObjectType geoSceneObjectType = null;
    private String name = null;

    public String getName() {
        if (name == null)
            name = geoSceneObjectType().name.value;
        return name;
    }

    public int getColumn() {
        return graphicsObjInfo.x;
    }

    public int getRow() {
        return graphicsObjInfo.y;
    }

    public boolean isMirrored() {
        return graphicsObjInfo.isMirrored;
    }

    public boolean isBroken() {
        return false;
    }

    public int getLevel() {
        return 0;
    }

    public GeoSceneObjectType objectType() {
        if (geoSceneObjectType == null) {
            geoSceneObjectType = StaticDataManager.getInstance().findSceneObjectById(type);
            if (geoSceneObjectType == null)
                geoSceneObjectType = new GeoSceneObjectType();
        }
        return geoSceneObjectType;
    }


    public GeoSceneObjectType geoSceneObjectType() {
        if (geoSceneObjectType == null) {
            geoSceneObjectType = StaticDataManager.getInstance().findSceneObjectById(type);
        }
        return geoSceneObjectType;
    }

    public SaleableLevelInfo[] getAllSaleableLevelInfo() {
//        if (geoSceneObjectType() == null || (!geoSceneObjectType().isBuilding() && !geoSceneObjectType().isTechnology())) {
//            return new SaleableLevelInfo[]{};
//        }
        return geoSceneObjectType().saleableInfo.levelInfos;
    }
}
