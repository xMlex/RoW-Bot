package model.logic.inventory {
import common.DateUtil;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.Dictionary;

import model.data.inventory.InventorySlotInfo;
import model.data.inventory.UserInventorySlot;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.info.TroopsGroupId;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;

public class UserInventoryData {

    private static const CLASS_NAME:String = "UserInventoryData";

    public static const DATA_CHANGED:String = CLASS_NAME + "Changed";


    public var inventoryItemsById:Dictionary;

    public var inventorySlotsById:Dictionary;

    public var inventoryItemsBySlotId:Dictionary;

    public var sealedItemDataById:Dictionary;

    public var currentTroopsBonusByGroupId:Dictionary;

    public var dustAmount:Number;

    public var nextInventoryItemId:int;

    public var dirty:Boolean;

    private var events:EventDispatcher;

    public function UserInventoryData(param1:Dictionary = null, param2:Dictionary = null, param3:Dictionary = null, param4:Number = NaN, param5:int = 0) {
        this.currentTroopsBonusByGroupId = new Dictionary();
        this.events = new EventDispatcher();
        super();
        this.inventoryItemsById = param1;
        this.inventorySlotsById = param2;
        this.sealedItemDataById = param3;
        this.dustAmount = param4;
        this.nextInventoryItemId = param5;
    }

    public static function fromDto(param1:*):UserInventoryData {
        var _loc3_:Dictionary = null;
        var _loc4_:Dictionary = null;
        var _loc5_:Dictionary = null;
        var _loc6_:Dictionary = null;
        var _loc7_:* = undefined;
        var _loc8_:* = undefined;
        var _loc9_:* = undefined;
        var _loc10_:GeoSceneObject = null;
        var _loc2_:UserInventoryData = null;
        if (param1) {
            _loc3_ = new Dictionary();
            _loc4_ = new Dictionary();
            _loc5_ = new Dictionary();
            _loc6_ = new Dictionary();
            for (_loc7_ in param1.r) {
                _loc10_ = GeoSceneObject.fromDto(param1.r[_loc7_]);
                _loc3_[_loc10_.id] = _loc10_;
                _loc5_[_loc10_.inventoryItemInfo.slotId] = _loc10_;
            }
            for (_loc8_ in param1.s) {
                _loc6_[_loc8_] = SealedInventoryType.fromDto(param1.s[_loc8_]);
            }
            for (_loc9_ in param1.a) {
                _loc4_[_loc9_] = UserInventorySlot.fromDto(param1.a[_loc9_]);
            }
            _loc2_ = new UserInventoryData(_loc3_, _loc4_, _loc6_, param1.d, param1.n);
            _loc2_.inventoryItemsBySlotId = _loc5_;
        }
        return _loc2_;
    }

    public function updateTroopsBonusData():Dictionary {
        this.currentTroopsBonusByGroupId[TroopsGroupId.INFANTRY] = InventoryManager.instance.getTroopsActiveGroupBonus(TroopsGroupId.INFANTRY);
        this.currentTroopsBonusByGroupId[TroopsGroupId.ARTILLERY] = InventoryManager.instance.getTroopsActiveGroupBonus(TroopsGroupId.ARTILLERY);
        this.currentTroopsBonusByGroupId[TroopsGroupId.ARMOURED] = InventoryManager.instance.getTroopsActiveGroupBonus(TroopsGroupId.ARMOURED);
        this.currentTroopsBonusByGroupId[TroopsGroupId.AEROSPACE] = InventoryManager.instance.getTroopsActiveGroupBonus(TroopsGroupId.AEROSPACE);
        return this.currentTroopsBonusByGroupId;
    }

    public function removeInventoryItem(param1:Number):void {
        delete this.inventoryItemsById[param1];
    }

    public function addDust(param1:Number):void {
        this.dustAmount = this.dustAmount + param1;
    }

    public function updateInventoryItemsBySlotId():Dictionary {
        var _loc1_:* = undefined;
        var _loc2_:GeoSceneObject = null;
        var _loc3_:int = 0;
        this.inventoryItemsBySlotId = new Dictionary();
        for (_loc1_ in this.inventoryItemsById) {
            _loc2_ = this.inventoryItemsById[_loc1_];
            _loc3_ = _loc2_.inventoryItemInfo.slotId;
            this.inventoryItemsBySlotId[_loc3_] = _loc2_;
        }
        return this.inventoryItemsBySlotId;
    }

    public function sortedTemporaryItems():void {
        var _loc4_:GeoSceneObject = null;
        var _loc1_:Vector.<InventorySlotInfo> = StaticDataManager.InventoryData.inventorySlotInfos_temporary;
        var _loc2_:Vector.<GeoSceneObject> = new Vector.<GeoSceneObject>();
        var _loc3_:int = 0;
        while (_loc3_ < _loc1_.length) {
            _loc4_ = this.inventoryItemsBySlotId[_loc1_[_loc3_].id];
            if (_loc4_) {
                if (_loc4_.inventoryItemInfo.issueTime.time + DateUtil.MILLISECONDS_PER_DAY * 2 < ServerTimeManager.serverTimeNow.time + 1000) {
                    _loc4_.inventoryItemInfo.slotId = -1;
                    delete this.inventoryItemsById[_loc4_.id];
                }
                else {
                    _loc2_.push(_loc4_);
                }
            }
            _loc3_++;
        }
        _loc2_ = this.vectorQuickSort(_loc2_);
        _loc3_ = 0;
        while (_loc3_ < _loc2_.length) {
            _loc2_[_loc3_].inventoryItemInfo.slotId = _loc1_[_loc3_].id;
            _loc3_++;
        }
        this.updateInventoryItemsBySlotId();
    }

    private function vectorQuickSort(param1:Vector.<GeoSceneObject>):Vector.<GeoSceneObject> {
        if (param1.length == 0 || param1.length == 1) {
            return param1;
        }
        var _loc2_:Number = param1[Math.round(param1.length / 2)].inventoryItemInfo.issueTime.time;
        var _loc3_:Vector.<GeoSceneObject> = new Vector.<GeoSceneObject>();
        var _loc4_:Vector.<GeoSceneObject> = new Vector.<GeoSceneObject>();
        var _loc5_:Vector.<GeoSceneObject> = new Vector.<GeoSceneObject>();
        var _loc6_:int = 0;
        while (_loc6_ < param1.length) {
            if (param1[_loc6_].inventoryItemInfo.issueTime.time < _loc2_) {
                _loc3_.push(param1[_loc6_]);
            }
            else if (param1[_loc6_].inventoryItemInfo.issueTime.time == _loc2_) {
                _loc4_.push(param1[_loc6_]);
            }
            else {
                _loc5_.push(param1[_loc6_]);
            }
            _loc6_++;
        }
        return this.vectorQuickSort(_loc3_).concat(_loc4_).concat(this.vectorQuickSort(_loc5_));
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            this.events.dispatchEvent(new Event(DATA_CHANGED, true));
        }
    }

    public function addEventListener(param1:String, param2:Function):void {
        this.events.addEventListener(param1, param2);
    }

    public function removeEventListener(param1:String, param2:Function):void {
        this.events.removeEventListener(param1, param2);
    }
}
}
