package model.logic.blackMarketModel.builders {
import common.localization.LocaleUtil;

import model.data.scenes.types.GeoSceneObjectType;
import model.logic.StaticDataManager;
import model.logic.blackMarketModel.core.DrawingItem;
import model.logic.blackMarketModel.core.DrawingPartItem;

public class DrawingPartBuilder {


    public function DrawingPartBuilder() {
        super();
    }

    public function build(param1:DrawingItem, param2:int, param3:int):DrawingPartItem {
        var _loc4_:GeoSceneObjectType = StaticDataManager.getObjectType(param1.id);
        var _loc5_:DrawingPartItem = new DrawingPartItem();
        _loc5_.id = -1;
        _loc5_.name = this.createStringItem(param2, param3);
        _loc5_.fullName = _loc5_.name;
        _loc5_.drawingId = param1.drawingId;
        _loc5_.partNumber = param2;
        _loc5_.iconUrl = _loc4_.getUrlForTechnologyDrawing();
        return _loc5_;
    }

    private function createStringItem(param1:int, param2:int):String {
        var _loc3_:String = "";
        var _loc4_:String = "";
        if (param2 >= 1) {
            _loc4_ = String(" (" + param2 + " " + LocaleUtil.getText("model-data-scenes-types-info-buildingTypeInfo-items") + ")");
        }
        _loc3_ = LocaleUtil.buildString("form-formTechnologyInfo_part", param1 + 1) + _loc4_;
        return _loc3_;
    }
}
}
