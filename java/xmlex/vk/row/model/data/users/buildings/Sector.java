package xmlex.vk.row.model.data.users.buildings;

import com.google.gson.JsonElement;

import java.util.Date;

public class Sector {
    public static final int MAX_TURRETS_COUNT = 12;
    public static final int MAX_GATES_COUNT = 4;
    public static final int WALL_OFFSET = 11;
    public static final int MAX_NAME_LENGTH = 19;
    public static final String CLASS_NAME = "Sector";
    public static final String BUILDINGS_CHANGED = CLASS_NAME + "BuildingsChanged";
    public static final String BUILDINGS_CHANGED_ANY = CLASS_NAME + "BuildingsChangedAny";
    public static final String SECTOR_NAME_CHANGED = CLASS_NAME + "SectorNameChanged";
    public static final String BUILDING_REPAIREDfOR_USER_CHANGE_EVENT = "buildingRepairedForUserChanged";
    public int nextObjectId;

    public Date lastDateBuildingRepairedByUser;
    public int militaryBildingsCount = 0;
    public int civilBuildingsCount = 0;
    public int decorativeBuildingsCount = 0;
    public int perimeterDefenseLevel = 0;
    public int defensivePoints = 0;
    public int defensiveIntelligencePoints = 0;
    //public var lastBuildedOrUpdatedBuilding:GeoSceneObject;
    public int lastClickId;
    //public var buildingsCountByTypeId:Dictionary = null;
    public int towersCount;
    public int gatesCount;
    public int defensiveObjectsWall;

    public static Sector fromDto(JsonElement param1) {

        Sector _ret = new Sector();


        return null;
    }

}
