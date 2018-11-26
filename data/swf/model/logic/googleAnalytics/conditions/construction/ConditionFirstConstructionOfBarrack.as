package model.logic.googleAnalytics.conditions.construction {
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.info.BuildingTypeId;
import model.logic.googleAnalytics.conditions.GAConditionBase;

public class ConditionFirstConstructionOfBarrack extends GAConditionBase {


    private var _buyingObj:GeoSceneObject;

    public function ConditionFirstConstructionOfBarrack(param1:*) {
        super();
        if (param1 is GeoSceneObject) {
            this._buyingObj = param1 as GeoSceneObject;
        }
    }

    override public function get check():Boolean {
        if (this._buyingObj && this._buyingObj.type.id == BuildingTypeId.Barracks) {
            return !!this._buyingObj.constructionInfo ? this._buyingObj.constructionInfo.level == 0 : false;
        }
        return false;
    }
}
}
