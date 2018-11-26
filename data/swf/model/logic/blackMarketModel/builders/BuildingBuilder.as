package model.logic.blackMarketModel.builders {
import model.data.scenes.types.GeoSceneObjectType;
import model.logic.StaticDataManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.BuildingItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class BuildingBuilder implements IBlackMarketItemBuilder {


    public function BuildingBuilder() {
        super();
    }

    protected function buildDefencePoints(param1:GeoSceneObjectType, param2:BuildingItem):int {
        if (param1.buildingInfo.getLevelInfo(1).defenceBonusPoints > 0) {
            param2.isDefence = true;
            return param1.buildingInfo.getLevelInfo(1).defenceBonusPoints;
        }
        return param1.buildingInfo.getLevelInfo(1).defenceIntelligencePoints;
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:GeoSceneObjectType = StaticDataManager.getObjectType(param1.id);
        var _loc3_:BuildingItem = new BuildingItem();
        BuilderHelper.fill(_loc3_, param1);
        _loc3_.fullName = param1.name;
        _loc3_.iconUrl = param1.iconUrl;
        _loc3_.techLevel = param1.buildingTechLevel;
        _loc3_.requiredLevel = StaticDataManager.blackMarketData.buildingsMinimalUserLevel;
        _loc3_.description = _loc2_.description;
        _loc3_.defenceBonus = this.buildDefencePoints(_loc2_, _loc3_);
        return _loc3_;
    }
}
}
