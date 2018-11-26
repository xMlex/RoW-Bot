package model.logic.blackMarketModel.builders {
import model.data.scenes.objects.GeoSceneObject;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderHelper;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.DrawingItem;
import model.logic.blackMarketModel.core.DrawingPartItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class DrawingBuilder implements IBlackMarketItemBuilder {


    public function DrawingBuilder() {
        super();
    }

    protected function buildParts(param1:DrawingItem):Vector.<DrawingPartItem> {
        var _loc6_:int = 0;
        var _loc7_:DrawingPartItem = null;
        var _loc2_:DrawingPartBuilder = new DrawingPartBuilder();
        var _loc3_:GeoSceneObject = UserManager.user.gameData.drawingArchive.getDrawing(param1.drawingId);
        if (!_loc3_) {
            _loc3_ = GeoSceneObject.makeDrawing(StaticDataManager.getObjectType(param1.drawingId));
        }
        var _loc4_:Vector.<DrawingPartItem> = new Vector.<DrawingPartItem>();
        var _loc5_:int = 0;
        while (_loc5_ < _loc3_.drawingInfo.drawingParts.length) {
            _loc6_ = _loc3_.drawingInfo.drawingParts[_loc5_];
            _loc7_ = _loc2_.build(param1, _loc5_, _loc6_);
            if (_loc7_) {
                _loc4_.push(_loc7_);
            }
            _loc5_++;
        }
        return _loc4_;
    }

    protected function buildIconUrl(param1:BlackMarketItemRaw):String {
        return StaticDataManager.getObjectType(param1.id + 100).getUrlForTechnologyDrawing().replace("_d.png", "_t.png");
    }

    protected function createItem():DrawingItem {
        return new DrawingItem();
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:DrawingItem = this.createItem();
        BuilderHelper.fill(_loc2_, param1);
        _loc2_.description = param1.geoSceneObjectType.descriptionExtended;
        _loc2_.iconUrl = this.buildIconUrl(param1);
        _loc2_.fullName = param1.name;
        _loc2_.drawingId = param1.id + 100;
        _loc2_.parts = this.buildParts(_loc2_);
        _loc2_.newUntil = param1.newUntil;
        return _loc2_;
    }
}
}
