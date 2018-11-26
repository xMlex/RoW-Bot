package model.logic.inventory {
import flash.utils.Dictionary;

import model.data.User;
import model.data.normalization.INEvent;
import model.data.normalization.INormalizable;
import model.data.scenes.objects.GeoSceneObject;

public class InventoryNormalizable implements INormalizable {

    private static var _instance:InventoryNormalizable;


    public function InventoryNormalizable() {
        super();
    }

    public static function get instance():InventoryNormalizable {
        if (_instance == null) {
            _instance = new InventoryNormalizable();
        }
        return _instance;
    }

    public function getNextEvent(param1:User, param2:Date):INEvent {
        if (!param1.gameData.inventoryData) {
            return null;
        }
        var _loc3_:GeoSceneObject = this.getNextUpgradedInventoryItem(param1, param2);
        if (_loc3_ != null) {
            return new NEventInventoryItemFinished(_loc3_, param2);
        }
        var _loc4_:GeoSceneObject = this.getNextPowderedInventoryItem(param1, param2);
        return _loc4_ != null ? new NEventInventoryItemFinished(_loc4_, param2) : null;
    }

    private function getNextUpgradedInventoryItem(param1:User, param2:Date):* {
        var _loc5_:GeoSceneObject = null;
        var _loc6_:Date = null;
        var _loc3_:GeoSceneObject = null;
        var _loc4_:Dictionary = param1.gameData.inventoryData.inventoryItemsById;
        for each(_loc5_ in _loc4_) {
            _loc6_ = _loc5_.constructionInfo.constructionFinishTime;
            if (!(_loc6_ == null || _loc5_.constructionInfo.isDestruction || _loc6_ > param2)) {
                _loc3_ = _loc5_;
                param2 = _loc6_;
            }
        }
        return _loc3_;
    }

    private function getNextPowderedInventoryItem(param1:User, param2:Date):* {
        var _loc4_:GeoSceneObject = null;
        var _loc5_:Date = null;
        var _loc3_:GeoSceneObject = null;
        for each(_loc4_ in param1.gameData.inventoryData.inventoryItemsById) {
            _loc5_ = _loc4_.constructionInfo.constructionFinishTime;
            if (!(_loc5_ == null || !_loc4_.constructionInfo.isDestruction || _loc5_ > param2)) {
                _loc3_ = _loc4_;
                param2 = _loc5_;
            }
        }
        return _loc3_;
    }
}
}
