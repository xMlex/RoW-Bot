package model.data.users {
import common.ArrayCustom;

import model.data.Resources;
import model.data.UserGameData;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.RequiredObject;
import model.data.scenes.types.info.SaleableLevelInfo;
import model.logic.StaticDataManager;
import model.logic.UserManager;

public class UserBuyingData {


    private var _buyingObjects:Array;

    public function UserBuyingData() {
        var _loc1_:GeoSceneObjectType = null;
        this._buyingObjects = new Array();
        super();
        for each(_loc1_ in StaticDataManager.types) {
            if (_loc1_.buildingInfo != null) {
                this._buyingObjects.push(GeoSceneObject.makeBuyingBuilding(_loc1_, 0, 0, false));
            }
            if (_loc1_.troopsInfo != null) {
                this._buyingObjects.push(GeoSceneObject.makeBuyingTroops(_loc1_, 0));
            }
        }
    }

    public static function updateObjectStatus(param1:GeoSceneObject, param2:UserGameData, param3:Boolean = false, param4:Boolean = false):void {
        var _loc6_:int = 0;
        var _loc7_:Resources = null;
        if (param1.buyStatus == BuyStatus.OBJECT_CANNOT_BE_BOUGHT && !param4) {
            return;
        }
        var _loc5_:SaleableLevelInfo = param1.getSaleableLevelInfo();
        if (_loc5_ == null) {
            param1.missingResources = null;
        }
        else {
            _loc7_ = UserManager.user.gameData.getPrice(UserManager.user, param1.objectType, param1.getNextLevel());
            param1.missingResources = getMissingResources(param2, _loc7_);
        }
        if (param3) {
            if (param1.getLevel() > 0) {
                param1.missingObjects = null;
            }
            else {
                param1.missingObjects = getMissingObjects(param2, param1.getRequiredObjects());
            }
        }
        if (param1.buildingInProgress || param2.objectFromSameGroupIsInProgress(param1.objectType)) {
            _loc6_ = BuyStatus.OBJECT_OF_SAME_GROUP_IN_PROGRESS;
        }
        else if (param1.missingObjects != null) {
            _loc6_ = BuyStatus.REQUIRED_OBJECT_MISSING;
        }
        else {
            _loc6_ = param2.getBuyStatus(param1, param1.getLevel() + 1);
        }
        if (param2.objectAdditionalWorkerNotEnoughTime(param1)) {
            _loc6_ = BuyStatus.OBJECT_OF_SAME_GROUP_IN_PROGRESS;
        }
        if (_loc6_ != param1.buyStatus) {
            param1.buyStatus = _loc6_;
            param1.dirtyNormalized = true;
        }
    }

    private static function getMissingResources(param1:UserGameData, param2:Resources):Resources {
        if (param2 == null) {
            return null;
        }
        var _loc3_:Resources = param1.account.resources.clone();
        if (param2.goldMoney == 0) {
            _loc3_.goldMoney = 0;
        }
        if (param2.uranium == 0) {
            _loc3_.uranium = 0;
        }
        if (param2.titanite == 0) {
            _loc3_.titanite = 0;
        }
        if (param2.money == 0) {
            _loc3_.money = 0;
        }
        if (_loc3_.greaterOrEquals(param2)) {
            return null;
        }
        var _loc4_:Resources = param2.clone();
        _loc4_.substract(param1.account.resources);
        return _loc4_;
    }

    private static function getMissingObjects(param1:UserGameData, param2:ArrayCustom):ArrayCustom {
        var _loc4_:RequiredObject = null;
        if (param2 == null) {
            return null;
        }
        var _loc3_:ArrayCustom = new ArrayCustom();
        for each(_loc4_ in param2) {
            if (!param1.hasRequiredObject(_loc4_)) {
                _loc3_.addItem(_loc4_);
            }
        }
        return _loc3_.length == 0 ? null : _loc3_;
    }

    public function getBuyingObject(param1:GeoSceneObjectType):GeoSceneObject {
        var _loc2_:GeoSceneObject = null;
        for each(_loc2_ in this._buyingObjects) {
            if (_loc2_.type.id == param1.id) {
                return _loc2_;
            }
        }
        return null;
    }

    public function getBuyingObjectByTypeId(param1:int):GeoSceneObject {
        var _loc2_:GeoSceneObject = null;
        var _loc4_:GeoSceneObject = null;
        var _loc3_:int = 0;
        while (_loc3_ < this._buyingObjects.length) {
            _loc4_ = this._buyingObjects[_loc3_];
            if (_loc4_.type.id == param1) {
                _loc2_ = _loc4_;
            }
            _loc3_++;
        }
        return _loc2_;
    }

    public function updateStatus(param1:UserGameData, param2:Boolean = false, param3:Boolean = false):void {
        var _loc4_:GeoSceneObject = null;
        for each(_loc4_ in this._buyingObjects) {
            updateObjectStatus(_loc4_, param1, param2, param3);
        }
    }

    public function dispatchEvents():void {
        var _loc1_:GeoSceneObject = null;
        for each(_loc1_ in this._buyingObjects) {
            _loc1_.dispatchEvents();
        }
    }
}
}
