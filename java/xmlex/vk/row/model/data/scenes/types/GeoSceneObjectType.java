package xmlex.vk.row.model.data.scenes.types;

import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.scenes.types.info.*;
import ru.xmlex.row.game.objects.SceneObjectType;

/**
 * Created by xMlex on 4/2/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class GeoSceneObjectType extends SceneObjectType {
    @SerializedName("s")
    public SotValue slogan = new SotValue();
    @SerializedName("e")
    public SotValue descriptionExtended = new SotValue();
    @SerializedName("gi")
    public GraphicsTypeInfo graphicsInfo;
    @SerializedName("si")
    public SaleableTypeInfo saleableInfo;
    @SerializedName("bi")
    public BuildingTypeInfo buildingInfo;
    @SerializedName("ti")
    public TroopsTypeInfo troopsInfo;
    @SerializedName("ci")
    public TechnologyTypeInfo technologyInfo;
    @SerializedName("di")
    public DrawingTypeInfo drawingInfo;
    @SerializedName("ai")
    public ArtifactTypeInfo artifactInfo;
    @SerializedName("mi")
    public GemTypeInfo gemInfo;
    @SerializedName("ri")
    public InventoryItemTypeInfo inventoryItemInfo;

    public boolean isTechnology() {
        return this.technologyInfo != null;
    }

    public boolean isBuilding() {
        return this.buildingInfo != null;
    }

    public boolean isTroops() {
        return troopsInfo != null;
    }

    public boolean isBuildingFunctional() {
        return this.isBuilding() && BuildingGroupId.IsFunctional(this.buildingInfo.groupId);
    }

    public boolean isOre() {
        return id == BuildingTypeId.UraniumOre || id == BuildingTypeId.TitaniumOre || id == BuildingTypeId.HousingEstateOre;
    }

    public boolean isResource() {
        return this.isBuilding() && this.buildingInfo.groupId == BuildingGroupId.RESOURCE;
    }

    public boolean isAdministrative() {
        return this.isBuilding() && this.buildingInfo.groupId == BuildingGroupId.ADMINISTRATIVE;
    }

    public boolean isMilitary() {
        return this.isBuilding() && this.buildingInfo.groupId == BuildingGroupId.MILITARY;
    }

    public boolean isScout() {
        return this.troopsInfo != null && this.troopsInfo.kindId == TroopsKindId.RECON;
    }

    public boolean isTacticalBuilding() {
        return this.troopsInfo != null && this.troopsInfo.getLevelInfo(1) != null
                && this.troopsInfo.getLevelInfo(1).battleBehaviour != null
                && this.troopsInfo.getLevelInfo(1).battleBehaviour.civilUnit;
    }

    public boolean isNotMilitaryBuilding() {
        return this.isBuilding() && (id == BuildingTypeId.BuildingIdRobotBoostResources || id == BuildingTypeId.BuildingIdRobotRepair);
    }


    public String getUrl() {
        return graphicsInfo != null ? graphicsInfo.url : "";
    }
}
