package ru.xmlex.row.game.data.users.buildings;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.common.GameType;
import ru.xmlex.row.game.data.scenes.SectorScene;
import ru.xmlex.row.game.data.scenes.objects.GeoSceneObject;
import ru.xmlex.row.game.data.scenes.types.info.BuildingTypeId;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xMlex on 4/2/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class Sector {
    public static final int MAX_TURRETS_COUNT = 12;

    public static final int MAX_GATES_COUNT = 4;

    public static final int WALL_OFFSET = 11;

    public static int MAX_NAME_LENGTH = 19;
    @Expose
    @SerializedName("i")
    public String name;

    @Expose
    @SerializedName("n")
    public int nextObjectId;

    @Expose
    @SerializedName("c")
    public int lastClickId;

    @Expose
    @SerializedName("s")
    public SectorScene scene;

//    private ArrayCustom _slots;
//
//    private int _totalBoughtExtensionPacks;
//
//    public GeoScene sectorScene;
//
//    public GeoScene warcampScene;
//
//    public ArrayCustom buildingRepairedByUserIds;
//
//    private ArrayCustom _buildingRepairedForUserIds;
//
//    public ArrayCustom buildingsDeletedByUserTypeIds;
//
//    public Date lastDateBuildingRepairedByUser;
//
//    public int militaryBildingsCount = 0;
//
//    public int civilBuildingsCount = 0;
//
//    public int decorativeBuildingsCount = 0;
//
//    public int perimeterDefenseLevel = 0;
//
//    public int defensivePoints = 0;
//
//    public int defensiveIntelligencePoints = 0;
//
//    public GeoSceneObject lastBuildedOrUpdatedBuilding;

//
//    public Dictionary buildingsCountByTypeId = null;
//
//    public int towersCount;
//
//    public int gatesCount;
//
//    public int defensiveObjectsWall;
//
//    public Boolean bRepairRobotInSector = false;
//
//    public Dictionary maxLevelBuildingDictionary;

    public List<GeoSceneObject> getBuildings(int id) {
        return getBuildings(id, 0);
    }

    public List<GeoSceneObject> getBuildings(int id, int minLevel) {

        List<GeoSceneObject> result = new ArrayList<>(0);
        for (GeoSceneObject _loc4_ : this.scene.objects) {
            if (_loc4_.type == id && _loc4_.getLevel() >= minLevel) {
                result.add(_loc4_);
            }
        }
        return result;
    }

    public boolean hasActiveBuilding(int param1, int param2) {
        return hasActiveBuilding(param1, param2, 1);
    }

    public boolean hasActiveBuilding(int param1, int param2, int param3) {
        if (GameType.isNords() && this.pseudoActiveBuildings(param1)) {
            return true;
        }
        int _loc4_ = 0;
        for (GeoSceneObject _loc6_ : this.scene.objects) {
            if (_loc6_.objectType() != null && _loc6_.objectType().id == param1 && _loc6_.constructionInfo.level >= param2) {
                if (param3 == 1) {
                    return true;
                }
                _loc4_++;
                if (_loc4_ >= param3) {
                    return true;
                }
            }
        }
        return _loc4_ >= param3;
    }

    public boolean pseudoActiveBuildings(int param1) {
        switch (param1) {
            case BuildingTypeId.Senate:
            case BuildingTypeId.IndustrialSyndicate:
            case BuildingTypeId.ChamberOfCommerce:
            case BuildingTypeId.TransportService:
            case BuildingTypeId.TradeGate:
                return true;
            default:
                return false;
        }
    }
}
