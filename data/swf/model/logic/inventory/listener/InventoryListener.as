package model.logic.inventory.listener {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.Dictionary;

import model.data.scenes.objects.GeoSceneObject;
import model.logic.UserManager;
import model.logic.inventory.InventoryManager;

public class InventoryListener extends EventDispatcher {


    private var _actionTypeConverter:InventoryItemActionTypeConverter;

    public function InventoryListener() {
        super();
        this._actionTypeConverter = new InventoryItemActionTypeConverter();
    }

    private static function getUpgradingItems(param1:Dictionary):Array {
        var _loc3_:GeoSceneObject = null;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            if (_loc3_.constructionInfo.constructionFinishTime && !_loc3_.constructionInfo.isDestruction) {
                _loc2_.push(_loc3_);
            }
        }
        return _loc2_;
    }

    private static function getPowderingItems(param1:Dictionary):Array {
        var _loc3_:GeoSceneObject = null;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            if (_loc3_.constructionInfo.constructionFinishTime && _loc3_.constructionInfo.isDestruction) {
                _loc2_.push(_loc3_);
            }
        }
        return _loc2_;
    }

    public function listen():void {
        InventoryManager.events.addEventListener(InventoryManager.START_UPGRADING, this.onChange);
        InventoryManager.events.addEventListener(InventoryManager.START_POWDERING, this.onChange);
        InventoryManager.events.addEventListener(InventoryManager.ITEM_IS_POWDERED, this.onChange);
        InventoryManager.events.addEventListener(InventoryManager.ITEM_IS_UPGRADED, this.onChange);
        this.refreshAndDispatch(InventoryItemActionType.UPGRADING);
        this.refreshAndDispatch(InventoryItemActionType.POWDERING);
    }

    public function ignore():void {
        InventoryManager.events.removeEventListener(InventoryManager.START_UPGRADING, this.onChange);
        InventoryManager.events.removeEventListener(InventoryManager.START_POWDERING, this.onChange);
        InventoryManager.events.removeEventListener(InventoryManager.ITEM_IS_POWDERED, this.onChange);
        InventoryManager.events.removeEventListener(InventoryManager.ITEM_IS_UPGRADED, this.onChange);
    }

    private function onChange(param1:Event):void {
        var _loc2_:int = this._actionTypeConverter.convert(param1.type);
        this.refreshAndDispatch(_loc2_);
    }

    private function refreshAndDispatch(param1:int):void {
        var _loc3_:Array = null;
        var _loc2_:Dictionary = UserManager.user.gameData.inventoryData.inventoryItemsById;
        switch (param1) {
            case InventoryItemActionType.UPGRADING:
                _loc3_ = getUpgradingItems(_loc2_);
                break;
            case InventoryItemActionType.POWDERING:
                _loc3_ = getPowderingItems(_loc2_);
                break;
            default:
                _loc3_ = [];
        }
        dispatchEvent(new InventoryListenerEvent(Event.CHANGE, false, false, _loc3_, param1));
    }
}
}
