package model.data.clanPurchases {
import common.queries.util.query;

import gameObjects.observableObject.ObservableObject;

import model.logic.dtoSerializer.DtoDeserializer;

public class UserClanPurchaseData extends ObservableObject {

    private static const CLASS_NAME:String = "UserClanPurchaseData";

    public static const DATA_CHANGED:String = CLASS_NAME + "_DataChanged";


    public var lastReceivedGachaChestIndex:int;

    public var lastGachaChestItemId:int;

    public var expiredGachaChests:Array;

    private var _dirty:Boolean;

    public function UserClanPurchaseData() {
        super();
    }

    public static function fromDto(param1:*):UserClanPurchaseData {
        var _loc2_:UserClanPurchaseData = new UserClanPurchaseData();
        if (param1 == null) {
            return _loc2_;
        }
        _loc2_.lastReceivedGachaChestIndex = param1.i;
        _loc2_.lastGachaChestItemId = param1.l;
        _loc2_.expiredGachaChests = DtoDeserializer.toArray(param1.e, GachaChestItem.fromDto);
        return _loc2_;
    }

    public function update(param1:UserClanPurchaseData):void {
        if (param1 == null) {
            return;
        }
        this.expiredGachaChests = param1.expiredGachaChests;
        this.lastReceivedGachaChestIndex = param1.lastReceivedGachaChestIndex;
        this.lastGachaChestItemId = param1.lastGachaChestItemId;
        this._dirty = true;
    }

    public function dispatchEvents():void {
        if (this._dirty) {
            this._dirty = false;
            dispatchEvent(DATA_CHANGED);
        }
    }

    public function updateExpiredChests(param1:Array):void {
        if (this.expiredGachaChests == null) {
            this.expiredGachaChests = [];
        }
        this.expiredGachaChests = param1;
        this._dirty = true;
    }

    public function getExpiredChestById(param1:int):GachaChestItem {
        var chestId:int = param1;
        if (this.expiredGachaChests == null) {
            return null;
        }
        var userChestItem:GachaChestItem = query(this.expiredGachaChests).firstOrDefault(function (param1:GachaChestItem):Boolean {
            return param1.id == chestId;
        });
        return userChestItem;
    }

    public function expiredChestCount():int {
        if (this.expiredGachaChests == null) {
            return 0;
        }
        return this.expiredGachaChests.length;
    }

    public function clearExpired():void {
        this.expiredGachaChests = [];
        this._dirty = true;
    }

    public function removeExpiredById(param1:int):void {
        if (this.expiredGachaChests == null) {
            return;
        }
        var _loc2_:int = this.expiredGachaChests.length - 1;
        while (_loc2_ >= 0) {
            if (this.expiredGachaChests[_loc2_].id != param1) {
                _loc2_--;
                continue;
            }
            this.expiredGachaChests.splice(_loc2_, 1);
            this._dirty = true;
            break;
        }
    }

    public function getExpiredChestsByBMItemId(param1:int):Array {
        var bmItemId:int = param1;
        if (this.expiredGachaChests == null) {
            return null;
        }
        var userChestItems:Array = query(this.expiredGachaChests).where(function (param1:GachaChestItem):Boolean {
            return param1.gachaChestId == bmItemId;
        }).toArray();
        return userChestItems;
    }
}
}
