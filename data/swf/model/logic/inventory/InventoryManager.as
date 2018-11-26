package model.logic.inventory {
import Events.EventWithTargetObject;

import common.ArrayCustom;
import common.DateUtil;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.TimerEvent;
import flash.utils.Dictionary;
import flash.utils.Timer;

import model.data.inventory.InventoryItemObjInfo;
import model.data.inventory.InventoryItemTier;
import model.data.inventory.InventoryItemTypeInfo;
import model.data.inventory.InventorySlotInfo;
import model.data.inventory.InventorySlotType;
import model.data.inventory.UserInventorySlot;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.objects.info.ConstructionObjInfo;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.SaleableLevelInfo;
import model.data.scenes.types.info.TroopsGroupId;
import model.logic.ServerTimeManager;
import model.logic.StaticConstructionData;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.InventoryItemData;
import model.logic.commands.inventory.BuyInventoryStorageSlotCmd;
import model.logic.commands.inventory.MoveInventoryItemFromActiveSlotCmd;
import model.logic.commands.inventory.MoveInventoryItemToActiveSlotCmd;
import model.logic.commands.inventory.MoveInventoryItemToStorageSlotCmd;
import model.logic.commands.inventory.PowderInventoryItemCmd;
import model.logic.commands.inventory.RemoveInventoryItemCmd;
import model.logic.commands.inventory.ReorderInventoryCmd;
import model.logic.commands.inventory.SwapInventoryItemsCmd;
import model.logic.commands.inventory.UnsealInventoryItemCmd;
import model.logic.commands.inventory.UpgradeInventoryItemCmd;

public class InventoryManager {

    public static const CLASS_NAME:String = "InventoryManager";

    public static const CHEST_OPEN:String = CLASS_NAME + "ChestOpen";

    public static const ITEM_IS_POWDERED:String = CLASS_NAME + "ItemIsPowdered";

    public static const ITEM_IS_UPGRADED:String = CLASS_NAME + "ItemIsUpgraded";

    public static const ITEM_IS_DRUGGING:String = CLASS_NAME + "ItemIsDragging";

    public static const START_POWDERING:String = CLASS_NAME + "StartPowdering";

    public static const START_UPGRADING:String = CLASS_NAME + "StartUpgrading";

    public static const STATUS_CHANGED:String = CLASS_NAME + "StatusChanged";

    private static var tickItemsToSpraying:Vector.<ITimerTickToPowderOrUpgrade>;

    private static var timerToSpraying:Timer;

    private static var tickItemsToRemoveItems:Vector.<ITimerTickToRemoveItems>;

    private static var timerToRemoveItems:Timer;

    private static var _instance:InventoryManager;

    private static var _haveChangesInInventory:Boolean = false;

    private static var _events:EventDispatcher = new EventDispatcher();


    protected var _subscriberCount:int = 0;

    public function InventoryManager() {
        super();
        timerToSpraying = new Timer(1000);
        tickItemsToSpraying = new Vector.<ITimerTickToPowderOrUpgrade>();
        timerToSpraying.addEventListener(TimerEvent.TIMER, this.timerTickToSpraying_eventHandler);
        timerToRemoveItems = new Timer(1000);
        tickItemsToRemoveItems = new Vector.<ITimerTickToRemoveItems>();
        timerToRemoveItems.addEventListener(TimerEvent.TIMER, this.timerTickToRemoveItems_eventHandler);
    }

    public static function get instance():InventoryManager {
        if (!_instance) {
            _instance = new InventoryManager();
        }
        return _instance;
    }

    public static function addElementsInInventory(param1:InventoryItemData):void {
        var _loc4_:InventorySlotInfo = null;
        var _loc5_:Dictionary = null;
        var _loc6_:Vector.<InventorySlotInfo> = null;
        var _loc7_:int = 0;
        var _loc8_:UserInventorySlot = null;
        var _loc9_:int = 0;
        var _loc10_:GeoSceneObject = null;
        var _loc11_:SealedInventoryType = null;
        var _loc2_:UserInventoryData = UserManager.user.gameData.inventoryData;
        var _loc3_:int = 0;
        while (_loc3_ < param1.count) {
            _loc5_ = _loc2_.inventoryItemsBySlotId;
            _loc6_ = StaticDataManager.InventoryData.inventorySlotInfos_inventory.concat(StaticDataManager.InventoryData.inventorySlotInfos_temporary);
            while (_loc7_ < _loc6_.length) {
                _loc8_ = _loc2_.inventorySlotsById[_loc6_[_loc7_].id];
                if (!_loc8_.locked) {
                    _loc4_ = StaticDataManager.InventoryData.inventorySlotsById[_loc8_.id];
                    if (!(_loc4_.inventorySlotKind == InventorySlotType.ACTIVE || _loc4_.inventorySlotKind == InventorySlotType.TEMPORARY_STORAGE)) {
                        if (!_loc5_[_loc8_.id]) {
                            _loc9_ = _loc2_.nextInventoryItemId++;
                            _loc10_ = new GeoSceneObject(_loc9_, null, 0, 0, false);
                            _loc10_.inventoryItemInfo = new InventoryItemObjInfo(ServerTimeManager.serverTimeNow, _loc8_.id, true, UserManager.user.gameData.account.level, 0, 0);
                            _loc10_.constructionInfo = new ConstructionObjInfo();
                            _loc2_.inventoryItemsById[_loc10_.id] = _loc10_;
                            _loc11_ = new SealedInventoryType();
                            _loc11_.inventoryItemRareness = param1.rareness;
                            _loc11_.affectedGroupIds = getAffectedGroupIds(param1.tier);
                            _loc2_.sealedItemDataById[_loc10_.id] = _loc11_;
                            _loc5_[_loc8_.id] = _loc10_;
                            break;
                        }
                    }
                }
                _loc7_++;
            }
            _loc3_++;
        }
        UserManager.user.gameData.inventoryData.dirty = true;
    }

    public static function getAffectedGroupIds(param1:int):Vector.<int> {
        var _loc2_:Vector.<int> = new Vector.<int>();
        _loc2_.push(TroopsGroupId.INFANTRY);
        if (param1 == InventoryItemTier.TIER_1) {
            return _loc2_;
        }
        _loc2_.push(TroopsGroupId.ARTILLERY);
        if (param1 == InventoryItemTier.TIER_2) {
            return _loc2_;
        }
        _loc2_.push(TroopsGroupId.ARMOURED);
        if (param1 == InventoryItemTier.TIER_3) {
            return _loc2_;
        }
        _loc2_.push(TroopsGroupId.AEROSPACE);
        if (param1 == InventoryItemTier.TIER_4) {
            return _loc2_;
        }
        return null;
    }

    public static function needShowCompareItems(param1:GeoSceneObject):GeoSceneObject {
        var _loc5_:int = 0;
        var _loc7_:GeoSceneObject = null;
        var _loc2_:Vector.<InventorySlotInfo> = StaticDataManager.InventoryData.inventorySlotInfos_active;
        var _loc3_:InventorySlotInfo = StaticDataManager.InventoryData.inventorySlotsById[param1.inventoryItemInfo.slotId];
        if (!_loc3_ || _loc3_.inventorySlotKind == InventorySlotType.ACTIVE) {
            return null;
        }
        var _loc4_:Array = [];
        _loc5_ = 0;
        while (_loc5_ < _loc2_.length) {
            if (checkInventoryItemsGroup(_loc2_[_loc5_].inventoryItemGroups, param1.objectType.inventoryItemInfo.inventoryItemGroup)) {
                _loc7_ = UserManager.user.gameData.inventoryData.inventoryItemsBySlotId[_loc2_[_loc5_].id];
                _loc4_.push(_loc7_);
            }
            _loc5_++;
        }
        var _loc6_:GeoSceneObject = null;
        if (_loc4_.length > 1) {
            _loc6_ = sortingForRings(_loc4_, param1);
        }
        else {
            _loc6_ = _loc4_[0];
        }
        if (param1 == _loc6_) {
            _loc6_ = null;
        }
        return _loc6_;
    }

    private static function sortingForRings(param1:Array, param2:GeoSceneObject):GeoSceneObject {
        var _loc6_:TroopsGroupBonus = null;
        var _loc7_:TroopsGroupBonus = null;
        var _loc8_:TroopsGroupBonus = null;
        var _loc9_:GeoSceneObject = null;
        var _loc10_:TroopsGroupBonus = null;
        var _loc3_:GeoSceneObject = null;
        var _loc4_:GeoSceneObject = param1[0];
        var _loc5_:GeoSceneObject = param1[1];
        if (!_loc4_ || !_loc5_) {
            return null;
        }
        if (_loc4_.objectType.inventoryItemInfo.inventoryItemRareness > _loc5_.objectType.inventoryItemInfo.inventoryItemRareness) {
            _loc9_ = _loc4_;
            _loc4_ = _loc5_;
            _loc5_ = _loc9_;
        }
        _loc6_ = InventoryManager.instance.getInventoryItemBonus(param2);
        _loc7_ = InventoryManager.instance.getInventoryItemBonus(_loc4_);
        _loc8_ = InventoryManager.instance.getInventoryItemBonus(_loc5_);
        if (_loc4_.objectType.inventoryItemInfo.inventoryItemRareness == _loc5_.objectType.inventoryItemInfo.inventoryItemRareness && (_loc7_.attack > _loc8_.attack || _loc7_.defense > _loc8_.defense)) {
            _loc9_ = _loc4_;
            _loc4_ = _loc5_;
            _loc5_ = _loc9_;
            _loc10_ = _loc7_;
            _loc7_ = _loc8_;
            _loc8_ = _loc10_;
        }
        if (_loc6_.isAttack && _loc7_.isAttack || _loc6_.isDefense && _loc7_.isDefense) {
            _loc3_ = _loc4_;
        }
        else if (_loc6_.isAttack && _loc8_.isAttack || _loc6_.isDefense && _loc8_.isDefense) {
            _loc3_ = _loc5_;
        }
        if (!_loc3_) {
            _loc3_ = _loc4_;
        }
        return _loc3_;
    }

    protected static function checkInventoryItemsGroup(param1:Vector.<int>, param2:int):Boolean {
        var _loc4_:int = 0;
        var _loc3_:Boolean = false;
        for each(_loc4_ in param1) {
            if (param2 == _loc4_) {
                _loc3_ = true;
            }
        }
        return _loc3_;
    }

    public static function get allInventorySlotsEmpty():Boolean {
        var _loc4_:UserInventorySlot = null;
        var _loc1_:Boolean = true;
        var _loc2_:Dictionary = UserManager.user.gameData.inventoryData.inventorySlotsById;
        var _loc3_:Dictionary = UserManager.user.gameData.inventoryData.inventoryItemsBySlotId;
        for each(_loc4_ in _loc2_) {
            if (_loc3_[_loc4_.id]) {
                _loc1_ = false;
            }
        }
        return _loc1_;
    }

    public static function get inventoryIsEmpty():Boolean {
        var _loc3_:UserInventorySlot = null;
        var _loc1_:Boolean = true;
        var _loc2_:Vector.<InventorySlotInfo> = StaticDataManager.InventoryData.inventorySlotInfos_inventory;
        var _loc4_:Dictionary = UserManager.user.gameData.inventoryData.inventorySlotsById;
        var _loc5_:Dictionary = UserManager.user.gameData.inventoryData.inventoryItemsBySlotId;
        var _loc6_:int = 0;
        while (_loc6_ < _loc2_.length) {
            _loc3_ = _loc4_[_loc2_[_loc6_].id];
            if (!_loc3_ || _loc3_.locked) {
                break;
            }
            if (_loc5_[_loc3_.id]) {
                _loc1_ = false;
            }
            _loc6_++;
        }
        return _loc1_;
    }

    public static function get userHasNoItems():Boolean {
        var _loc5_:UserInventorySlot = null;
        var _loc1_:Boolean = true;
        var _loc2_:Vector.<InventorySlotInfo> = StaticDataManager.InventoryData.inventorySlotInfos_inventory;
        var _loc3_:Vector.<InventorySlotInfo> = StaticDataManager.InventoryData.inventorySlotInfos_active;
        var _loc4_:Vector.<InventorySlotInfo> = StaticDataManager.InventoryData.inventorySlotInfos_temporary;
        var _loc6_:Dictionary = UserManager.user.gameData.inventoryData.inventorySlotsById;
        var _loc7_:Dictionary = UserManager.user.gameData.inventoryData.inventoryItemsBySlotId;
        var _loc8_:int = 0;
        while (_loc8_ < _loc2_.length) {
            _loc5_ = _loc6_[_loc2_[_loc8_].id];
            if (!_loc5_ || _loc5_.locked) {
                break;
            }
            if (_loc7_[_loc5_.id]) {
                _loc1_ = false;
            }
            _loc8_++;
        }
        _loc8_ = 0;
        while (_loc8_ < _loc3_.length) {
            _loc5_ = _loc6_[_loc2_[_loc8_].id];
            if (!_loc5_ || _loc5_.locked) {
                break;
            }
            if (_loc7_[_loc5_.id]) {
                _loc1_ = false;
            }
            _loc8_++;
        }
        _loc8_ = 0;
        while (_loc8_ < _loc4_.length) {
            _loc5_ = _loc6_[_loc2_[_loc8_].id];
            if (!_loc5_ || _loc5_.locked) {
                break;
            }
            if (_loc7_[_loc5_.id]) {
                _loc1_ = false;
            }
            _loc8_++;
        }
        return _loc1_;
    }

    public static function getAllSlots():Array {
        var _loc3_:Object = null;
        var _loc1_:Array = [];
        var _loc2_:Dictionary = UserManager.user.gameData.inventoryData.inventorySlotsById;
        for each(_loc3_ in _loc2_) {
            _loc1_.push(_loc3_);
        }
        return _loc1_;
    }

    public static function checkInventoryOnTheEmptySlots(param1:int, param2:Boolean = false):Boolean {
        var _loc5_:InventorySlotInfo = null;
        var _loc8_:int = 0;
        var _loc9_:UserInventorySlot = null;
        var _loc3_:UserInventoryData = UserManager.user.gameData.inventoryData;
        _loc3_.sortedTemporaryItems();
        var _loc4_:Dictionary = _loc3_.inventoryItemsBySlotId;
        var _loc6_:int = 0;
        var _loc7_:Vector.<InventorySlotInfo> = StaticDataManager.InventoryData.inventorySlotInfos_inventory.concat(StaticDataManager.InventoryData.inventorySlotInfos_temporary);
        while (_loc8_ < _loc7_.length && _loc6_ < param1) {
            _loc9_ = _loc3_.inventorySlotsById[_loc7_[_loc8_].id];
            if (!_loc9_.locked) {
                _loc5_ = StaticDataManager.InventoryData.inventorySlotsById[_loc9_.id];
                if (!(_loc5_.inventorySlotKind == InventorySlotType.ACTIVE || !param2 && _loc5_.inventorySlotKind == InventorySlotType.TEMPORARY_STORAGE)) {
                    if (!_loc4_[_loc9_.id]) {
                        _loc6_++;
                    }
                }
            }
            _loc8_++;
        }
        return _loc6_ >= param1;
    }

    private static function startTimerToSpraying():void {
        if (!timerToSpraying.running) {
            timerToSpraying.start();
        }
    }

    private static function stopTimerToSpraying():void {
        if (timerToSpraying.running) {
            timerToSpraying.stop();
        }
    }

    public static function dispatchEventDrugIsStarted():void {
        events.dispatchEvent(new Event(ITEM_IS_DRUGGING));
    }

    private static function startTimerToRemoveItems():void {
        if (!timerToRemoveItems.running) {
            timerToRemoveItems.start();
        }
    }

    private static function stopTimerToRemoveItems():void {
        if (timerToRemoveItems.running) {
            timerToRemoveItems.stop();
        }
    }

    public static function get haveChangesInInventory():Boolean {
        return _haveChangesInInventory;
    }

    public static function set haveChangesInInventory(param1:Boolean):void {
        _haveChangesInInventory = param1;
    }

    public static function get events():EventDispatcher {
        if (_events == null) {
            _events = new EventDispatcher();
        }
        return _events;
    }

    public function getTroopsActiveGroupBonus(param1:int):TroopsGroupBonus {
        var _loc6_:InventorySlotInfo = null;
        var _loc7_:GeoSceneObject = null;
        var _loc8_:GeoSceneObjectType = null;
        var _loc9_:InventoryItemObjInfo = null;
        var _loc10_:InventoryItemTypeInfo = null;
        var _loc11_:TroopsGroupBonus = null;
        var _loc12_:int = 0;
        var _loc2_:Number = 0;
        var _loc3_:Number = 0;
        var _loc4_:Dictionary = UserManager.user.gameData.inventoryData.inventoryItemsBySlotId;
        var _loc5_:Vector.<InventorySlotInfo> = StaticDataManager.InventoryData.inventorySlotInfos_active;
        for each(_loc6_ in _loc5_) {
            _loc7_ = _loc4_[_loc6_.id];
            _loc8_ = !!_loc7_ ? _loc7_.type as GeoSceneObjectType : null;
            if (_loc7_) {
                _loc9_ = _loc7_.inventoryItemInfo;
                _loc10_ = _loc8_.inventoryItemInfo;
                _loc11_ = this.getInventoryItemBonus(_loc7_);
                for each(_loc12_ in _loc10_.affectedGroupIds) {
                    if (_loc12_ == param1 || TroopsGroupId.ToRegularGroupId(param1) == _loc12_) {
                        _loc2_ = _loc2_ + _loc11_.attack;
                        _loc3_ = _loc3_ + _loc11_.defense;
                    }
                }
            }
        }
        _loc2_ = int(_loc2_ * 10) / 10;
        _loc3_ = int(_loc3_ * 10) / 10;
        return new TroopsGroupBonus(_loc2_, _loc3_);
    }

    public function getTroopsGroupBonus(param1:int, param2:Dictionary):TroopsGroupBonus {
        var _loc5_:GeoSceneObject = null;
        var _loc6_:GeoSceneObjectType = null;
        var _loc7_:InventoryItemTypeInfo = null;
        var _loc8_:TroopsGroupBonus = null;
        var _loc9_:int = 0;
        var _loc3_:Number = 0;
        var _loc4_:Number = 0;
        for each(_loc5_ in param2) {
            if (_loc5_ && _loc5_.inventoryItemInfo && _loc5_.inventoryItemInfo.slotId <= 10) {
                _loc6_ = !!_loc5_ ? _loc5_.type as GeoSceneObjectType : null;
                _loc7_ = _loc6_.inventoryItemInfo;
                _loc8_ = this.getInventoryItemBonus(_loc5_);
                for each(_loc9_ in _loc7_.affectedGroupIds) {
                    if (_loc9_ == param1) {
                        _loc3_ = _loc3_ + _loc8_.attack;
                        _loc4_ = _loc4_ + _loc8_.defense;
                    }
                }
            }
        }
        return new TroopsGroupBonus(_loc3_, _loc4_);
    }

    public function activateItem(param1:Number, param2:Number, param3:Function = null):void {
        var itemId:Number = param1;
        var slotId:Number = param2;
        var onResult:Function = param3;
        new MoveInventoryItemToActiveSlotCmd(itemId, slotId).ifResult(function ():void {
            events.dispatchEvent(new Event(STATUS_CHANGED, true, false));
            if (onResult != null) {
                onResult();
            }
        }).execute();
    }

    public function swapItemCmd(param1:Number, param2:Number, param3:Function = null):void {
        var activeItemId:Number = param1;
        var storageItemId:Number = param2;
        var onResult:Function = param3;
        if (_haveChangesInInventory) {
            this.saveInventory(function ():void {
                new SwapInventoryItemsCmd(activeItemId, storageItemId).ifResult(function ():void {
                    events.dispatchEvent(new Event(STATUS_CHANGED, true, false));
                    if (onResult != null) {
                        onResult();
                    }
                }).execute();
            });
        }
        else {
            new SwapInventoryItemsCmd(activeItemId, storageItemId).ifResult(function ():void {
                events.dispatchEvent(new Event(STATUS_CHANGED, true, false));
                if (onResult != null) {
                    onResult();
                }
            }).execute();
        }
    }

    public function deactivateItem(param1:Number, param2:Number, param3:Function = null):void {
        var itemId:Number = param1;
        var slotId:Number = param2;
        var onResult:Function = param3;
        if (_haveChangesInInventory) {
            this.saveInventory(function ():void {
                new MoveInventoryItemFromActiveSlotCmd(itemId, slotId).ifResult(function ():void {
                    if (onResult != null) {
                        onResult();
                    }
                    events.dispatchEvent(new Event(STATUS_CHANGED, true, false));
                }).execute();
            });
        }
        else {
            new MoveInventoryItemFromActiveSlotCmd(itemId, slotId).ifResult(function ():void {
                if (onResult != null) {
                    onResult();
                }
                events.dispatchEvent(new Event(STATUS_CHANGED, true, false));
            }).execute();
        }
    }

    public function moveInventoryItemToStorageSlot(param1:Number, param2:Number, param3:Function = null):void {
        var itemId:Number = param1;
        var slotId:Number = param2;
        var onResult:Function = param3;
        if (_haveChangesInInventory) {
            this.saveInventory(function ():void {
                new MoveInventoryItemToStorageSlotCmd(itemId, slotId).ifResult(function ():void {
                    events.dispatchEvent(new Event(STATUS_CHANGED, true, false));
                    if (onResult != null) {
                        onResult();
                    }
                }).execute();
            });
        }
        else {
            new MoveInventoryItemToStorageSlotCmd(itemId, slotId).ifResult(function ():void {
                events.dispatchEvent(new Event(STATUS_CHANGED, true, false));
                if (onResult != null) {
                    onResult();
                }
            }).execute();
        }
    }

    public function upgradeInventoryItem(param1:int, param2:Function = null):void {
        var itemId:int = param1;
        var onResult:Function = param2;
        new UpgradeInventoryItemCmd(itemId).ifResult(function ():void {
            events.dispatchEvent(new Event(STATUS_CHANGED, true, false));
            events.dispatchEvent(new Event(START_UPGRADING, true, false));
            if (onResult != null) {
                onResult();
            }
        }).execute();
    }

    public function powderItem(param1:Number, param2:Function = null):void {
        var itemId:Number = param1;
        var onResult:Function = param2;
        new PowderInventoryItemCmd(itemId).ifResult(function ():void {
            events.dispatchEvent(new Event(STATUS_CHANGED, true, false));
            events.dispatchEvent(new Event(START_POWDERING, true, false));
            if (onResult != null) {
                onResult();
            }
        }).execute();
    }

    public function checkPossibilityOfToPowder():Boolean {
        var _loc2_:GeoSceneObject = null;
        var _loc1_:Boolean = false;
        var _loc3_:Dictionary = UserManager.user.gameData.inventoryData.inventoryItemsById;
        for each(_loc2_ in _loc3_) {
            if (_loc2_.constructionInfo.constructionFinishTime && _loc2_.constructionInfo.isDestruction) {
                _loc1_ = true;
                break;
            }
        }
        return _loc1_;
    }

    public function checkPossibilityOfToPowderWithAdditionalDestroyingItem():Boolean {
        var _loc4_:int = 0;
        var _loc1_:int = StaticConstructionData.INVENTORY_DESTROYER_DEFAULT_COUNT;
        var _loc2_:ArrayCustom = UserManager.user.gameData.constructionData.additionalInventoryDestroyerExpireDateTimes;
        if (_loc2_) {
            _loc4_ = 0;
            while (_loc4_ < _loc2_.length) {
                if (DateUtil.compare(ServerTimeManager.serverTimeNow, _loc2_[_loc4_]) == DateUtil.FIRST_BEFORE) {
                    _loc1_++;
                }
                _loc4_++;
            }
        }
        var _loc3_:int = this.powderingItems.length;
        if (_loc1_ > _loc3_) {
            return false;
        }
        return true;
    }

    public function get maxSprayingQueuesUsing():Boolean {
        var _loc4_:int = 0;
        var _loc6_:int = 0;
        var _loc1_:int = StaticDataManager.constructionData.getMaxAdditionalInventoryDestroyersCount();
        var _loc2_:int = StaticConstructionData.INVENTORY_DESTROYER_DEFAULT_COUNT + _loc1_;
        var _loc3_:int = InventoryManager.instance.powderingItems.length;
        var _loc5_:ArrayCustom = UserManager.user.gameData.constructionData.additionalInventoryDestroyerExpireDateTimes;
        if (_loc5_) {
            _loc6_ = 0;
            while (_loc6_ < _loc5_.length) {
                if (DateUtil.compare(ServerTimeManager.serverTimeNow, _loc5_[_loc6_]) == DateUtil.FIRST_BEFORE) {
                    _loc4_++;
                }
                _loc6_++;
            }
        }
        if (_loc3_ == _loc2_) {
            return true;
        }
        if (_loc4_ == _loc1_) {
            return true;
        }
        return false;
    }

    public function get maxSprayingQueueCount():int {
        var _loc2_:int = 0;
        var _loc4_:int = 0;
        var _loc1_:int = StaticConstructionData.INVENTORY_DESTROYER_DEFAULT_COUNT;
        var _loc3_:ArrayCustom = UserManager.user.gameData.constructionData.additionalInventoryDestroyerExpireDateTimes;
        if (_loc3_) {
            _loc4_ = 0;
            while (_loc4_ < _loc3_.length) {
                if (DateUtil.compare(ServerTimeManager.serverTimeNow, _loc3_[_loc4_]) == DateUtil.FIRST_BEFORE) {
                    _loc2_++;
                }
                _loc4_++;
            }
        }
        return _loc1_ + _loc2_;
    }

    public function checkPossibilityOfUpgrade():Boolean {
        var _loc2_:GeoSceneObject = null;
        var _loc1_:Boolean = false;
        var _loc3_:Dictionary = UserManager.user.gameData.inventoryData.inventoryItemsById;
        for each(_loc2_ in _loc3_) {
            if (_loc2_.constructionInfo.constructionFinishTime && !_loc2_.constructionInfo.isDestruction) {
                _loc1_ = true;
                break;
            }
        }
        return _loc1_;
    }

    public function get upgradingItem():GeoSceneObject {
        var _loc2_:GeoSceneObject = null;
        var _loc1_:Dictionary = UserManager.user.gameData.inventoryData.inventoryItemsById;
        for each(_loc2_ in _loc1_) {
            if (_loc2_.constructionInfo.constructionFinishTime && !_loc2_.constructionInfo.isDestruction) {
                return _loc2_;
            }
        }
        return null;
    }

    public function get powderingItems():Array {
        var _loc3_:GeoSceneObject = null;
        var _loc1_:Dictionary = UserManager.user.gameData.inventoryData.inventoryItemsById;
        var _loc2_:Array = new Array();
        for each(_loc3_ in _loc1_) {
            if (_loc3_.constructionInfo.constructionFinishTime && _loc3_.constructionInfo.isDestruction) {
                _loc2_.push(_loc3_);
            }
        }
        return _loc2_;
    }

    public function unsealInventoryItem(param1:Number, param2:Number, param3:Function = null):void {
        var itemId:Number = param1;
        var keyId:Number = param2;
        var onResult:Function = param3;
        new UnsealInventoryItemCmd(itemId, keyId).ifResult(function ():void {
            var _loc2_:* = undefined;
            events.dispatchEvent(new Event(STATUS_CHANGED, true, false));
            var _loc1_:* = UserManager.user.gameData.inventoryData.inventoryItemsById[itemId];
            if (_loc1_ != null) {
                _loc2_ = new EventWithTargetObject(CHEST_OPEN);
                _loc2_.targetObject = _loc1_;
                events.dispatchEvent(_loc2_);
            }
            if (onResult != null) {
                onResult();
            }
        }).execute();
    }

    public function removeInventoryItem(param1:Number, param2:Function = null):void {
        var itemId:Number = param1;
        var onResult:Function = param2;
        new RemoveInventoryItemCmd(itemId).ifResult(function ():void {
            events.dispatchEvent(new Event(STATUS_CHANGED, true, false));
            if (onResult != null) {
                onResult();
            }
        }).execute();
    }

    public function buySlotsInventoryItem(param1:Vector.<UserInventorySlot>, param2:Function = null):void {
        var slotsInfo:Vector.<UserInventorySlot> = param1;
        var onResult:Function = param2;
        new BuyInventoryStorageSlotCmd(slotsInfo).ifResult(function ():void {
            events.dispatchEvent(new Event(STATUS_CHANGED, true, false));
            if (onResult != null) {
                onResult();
            }
        }).execute();
    }

    public function saveInventory(param1:Function = null):void {
        var inventorySlotId:int = 0;
        var inventoryItem:GeoSceneObject = null;
        var onResult:Function = param1;
        var sendDTO:Object = new Object();
        var inventorySlots:Vector.<InventorySlotInfo> = StaticDataManager.InventoryData.inventorySlotInfos_inventory;
        var inventoryData:UserInventoryData = UserManager.user.gameData.inventoryData;
        var i:int = 0;
        while (i < inventorySlots.length) {
            inventorySlotId = inventorySlots[i].id;
            inventoryItem = inventoryData.inventoryItemsBySlotId[inventorySlotId];
            if (inventoryItem) {
                sendDTO[inventoryItem.id] = inventoryItem.inventoryItemInfo.slotId;
            }
            i++;
        }
        new ReorderInventoryCmd(sendDTO).ifResult(function ():void {
            haveChangesInInventory = false;
            if (onResult != null) {
                onResult();
            }
        }).execute();
    }

    public function getInventoryItemBonus(param1:GeoSceneObject, param2:int = -1):TroopsGroupBonus {
        var _loc3_:Number = param1.inventoryItemInfo.baseAttackBonus;
        var _loc4_:Number = param1.inventoryItemInfo.baseDefenseBonus;
        var _loc5_:GeoSceneObjectType = param1.type as GeoSceneObjectType;
        var _loc6_:int = param2 == -1 ? int(param1.constructionInfo.level) : int(param2);
        var _loc7_:int = 0;
        while (_loc7_ <= _loc6_) {
            _loc3_ = _loc3_ + _loc5_.inventoryItemInfo.levelInfos[_loc7_].attackBonus;
            _loc4_ = _loc4_ + _loc5_.inventoryItemInfo.levelInfos[_loc7_].defenseBonus;
            _loc7_++;
        }
        return new TroopsGroupBonus(_loc3_, _loc4_);
    }

    public function getItemDestructionSecondsWithBonuses(param1:SaleableLevelInfo):Number {
        var _loc2_:Number = NaN;
        if (param1 != null) {
            _loc2_ = UserManager.user.gameData.constructionData.getItemsPowderingTimeSeconds(param1.destructionSeconds);
        }
        else {
            _loc2_ = 0;
        }
        return _loc2_;
    }

    public function moveItemToSlot(param1:GeoSceneObject, param2:int):void {
        var _loc3_:UserInventoryData = UserManager.user.gameData.inventoryData;
        var _loc4_:GeoSceneObject = _loc3_.inventoryItemsBySlotId[param2];
        if (_loc4_) {
            this.swapItem(param1, _loc4_);
        }
        else {
            this.moveItemToEmptySlot(param1, param2);
        }
    }

    private function moveItemToEmptySlot(param1:GeoSceneObject, param2:int):void {
        var _loc3_:UserInventoryData = UserManager.user.gameData.inventoryData;
        delete _loc3_.inventoryItemsBySlotId[param1.inventoryItemInfo.slotId];
        param1.inventoryItemInfo.slotId = param2;
        _loc3_.inventoryItemsBySlotId[param1.inventoryItemInfo.slotId] = param1;
    }

    private function swapItem(param1:GeoSceneObject, param2:GeoSceneObject):void {
        var _loc3_:Dictionary = UserManager.user.gameData.inventoryData.inventoryItemsBySlotId;
        var _loc4_:GeoSceneObject = _loc3_[param1.inventoryItemInfo.slotId];
        _loc3_[param1.inventoryItemInfo.slotId] = param2;
        _loc3_[param2.inventoryItemInfo.slotId] = _loc4_;
        var _loc5_:int = param1.inventoryItemInfo.slotId;
        param1.inventoryItemInfo.slotId = param2.inventoryItemInfo.slotId;
        param2.inventoryItemInfo.slotId = _loc5_;
    }

    public function set subscriberCount(param1:int):void {
        if (param1 < 0) {
            return;
        }
        this._subscriberCount = param1;
        if (tickItemsToSpraying.length > 0) {
            startTimerToSpraying();
        }
        if (tickItemsToRemoveItems.length > 0) {
            startTimerToRemoveItems();
        }
    }

    public function get subscriberCount():int {
        return this._subscriberCount;
    }

    public function removeSubscriber():void {
        this.subscriberCount--;
    }

    public function addSubscriber():void {
        this.subscriberCount++;
    }

    public function addItemForTimerToSpraying(param1:ITimerTickToPowderOrUpgrade):void {
        if (tickItemsToSpraying.lastIndexOf(param1) == -1) {
            tickItemsToSpraying.push(param1);
        }
        if (this.subscriberCount > 0) {
            startTimerToSpraying();
        }
    }

    private function timerTickToSpraying_eventHandler(param1:Event):void {
        var _loc3_:Date = null;
        var _loc2_:int = tickItemsToSpraying.length - 1;
        while (_loc2_ >= 0) {
            _loc3_ = tickItemsToSpraying[_loc2_].constructionFinishTimeToPowderOrUpgrade();
            if (_loc3_ && _loc3_.time > ServerTimeManager.serverTimeNow.time + 1000) {
                if (this.subscriberCount) {
                    tickItemsToSpraying[_loc2_].tickTimerToPowderOrUpgrade();
                }
            }
            else {
                tickItemsToSpraying[_loc2_].stopTimerToPowderOrUpgrade();
                tickItemsToSpraying.splice(_loc2_, 1);
                if (tickItemsToSpraying.length == 0) {
                    stopTimerToSpraying();
                }
            }
            _loc2_--;
        }
    }

    public function addItemForTimerToRemoveItems(param1:ITimerTickToRemoveItems):void {
        tickItemsToRemoveItems.push(param1);
        if (this.subscriberCount > 0) {
            startTimerToRemoveItems();
        }
    }

    private function timerTickToRemoveItems_eventHandler(param1:Event):void {
        var _loc3_:Date = null;
        var _loc4_:Date = null;
        var _loc2_:int = tickItemsToRemoveItems.length - 1;
        while (_loc2_ >= 0) {
            _loc3_ = tickItemsToRemoveItems[_loc2_].constructionFinishTimeToRemoveItems();
            _loc4_ = ServerTimeManager.serverTimeNow;
            if (_loc3_ && _loc3_.time > _loc4_.time + 1000) {
                tickItemsToRemoveItems[_loc2_].tickTimerToRemoveItems();
            }
            else {
                tickItemsToRemoveItems[_loc2_].stopTimerToRemoveItems();
                tickItemsToRemoveItems.splice(_loc2_, 1);
                if (tickItemsToRemoveItems.length == 0) {
                    stopTimerToRemoveItems();
                }
            }
            _loc2_--;
        }
    }
}
}
