package model.logic.inventory {
import common.localization.LocaleUtil;
import common.queries.util.query;

import configs.Global;

import flash.utils.Dictionary;

import model.data.inventory.InventoryItemRareness;
import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.logic.UserManager;

public class SealedInventoryItemData {


    private var _sealedInventoryType:SealedInventoryType;

    private var _url:String;

    private var _name:String;

    private var _keyId:int;

    private var _keyIds:Array;

    public function SealedInventoryItemData(param1:SealedInventoryType) {
        this._keyIds = [];
        super();
        this.initializeByType(param1);
    }

    public function get url():String {
        return this._url;
    }

    public function get name():String {
        return this._name;
    }

    public function get keyId():int {
        return this._keyId;
    }

    public function get keyIds():Array {
        return this._keyIds;
    }

    private function initializeByType(param1:SealedInventoryType):void {
        this._sealedInventoryType = param1;
        if (this._sealedInventoryType != null) {
            if (this._sealedInventoryType.affectedGroupIds.length == 4) {
                this._name = LocaleUtil.getText("forms-formHero_inventoryItemSealed_typeDragons");
                this._url = "ui/hero/inventory/items/sealed/chest_dragons.png";
                switch (this._sealedInventoryType.inventoryItemRareness) {
                    case InventoryItemRareness.UNCOMMON:
                        this._keyId = BlackMarketItemsTypeId.InventoryKeyUncommonTier4;
                        this._keyIds.push(this._keyId, BlackMarketItemsTypeId.InventoryKeyUncommonAllTiers);
                        break;
                    case InventoryItemRareness.RARE:
                        this._keyId = BlackMarketItemsTypeId.InventoryKeyRareTier4;
                        this._keyIds.push(this._keyId, BlackMarketItemsTypeId.InventoryKeyRareAllTiers);
                        break;
                    case InventoryItemRareness.EPIC:
                        this._keyId = BlackMarketItemsTypeId.InventoryKeyEpicTier4;
                        this._keyIds.push(this._keyId, BlackMarketItemsTypeId.InventoryKeyEpicAllTiers);
                }
            }
            else if (this._sealedInventoryType.affectedGroupIds.length == 3) {
                this._name = LocaleUtil.getText("forms-formHero_inventoryItemSealed_typeElves");
                this._url = "ui/hero/inventory/items/sealed/chest_elves.png";
                switch (this._sealedInventoryType.inventoryItemRareness) {
                    case InventoryItemRareness.UNCOMMON:
                        this._keyId = BlackMarketItemsTypeId.InventoryKeyUncommonTier3;
                        this._keyIds.push(this._keyId, BlackMarketItemsTypeId.InventoryKeyUncommonAllTiers);
                        break;
                    case InventoryItemRareness.RARE:
                        this._keyId = BlackMarketItemsTypeId.InventoryKeyRareTier3;
                        this._keyIds.push(this._keyId, BlackMarketItemsTypeId.InventoryKeyRareAllTiers);
                        break;
                    case InventoryItemRareness.EPIC:
                        this._keyId = BlackMarketItemsTypeId.InventoryKeyEpicTier3;
                        this._keyIds.push(this._keyId, BlackMarketItemsTypeId.InventoryKeyEpicAllTiers);
                }
            }
            else if (this._sealedInventoryType.affectedGroupIds.length == 2) {
                this._name = LocaleUtil.getText("forms-formHero_inventoryItemSealed_typeOrks");
                this._url = "ui/hero/inventory/items/sealed/chest_orcs.png";
                switch (this._sealedInventoryType.inventoryItemRareness) {
                    case InventoryItemRareness.UNCOMMON:
                        this._keyId = BlackMarketItemsTypeId.InventoryKeyUncommonTier2;
                        this._keyIds.push(this._keyId, BlackMarketItemsTypeId.InventoryKeyUncommonAllTiers);
                        break;
                    case InventoryItemRareness.RARE:
                        this._keyId = BlackMarketItemsTypeId.InventoryKeyRareTier2;
                        this._keyIds.push(this._keyId, BlackMarketItemsTypeId.InventoryKeyRareAllTiers);
                        break;
                    case InventoryItemRareness.EPIC:
                        this._keyId = BlackMarketItemsTypeId.InventoryKeyEpicTier2;
                        this._keyIds.push(this._keyId, BlackMarketItemsTypeId.InventoryKeyEpicAllTiers);
                }
            }
            else if (this._sealedInventoryType.affectedGroupIds.length == 1) {
                this._name = LocaleUtil.getText("forms-formHero_inventoryItemSealed_typeNords");
                this._url = "ui/hero/inventory/items/sealed/chest_nords.png";
                switch (this._sealedInventoryType.inventoryItemRareness) {
                    case InventoryItemRareness.UNCOMMON:
                        this._keyId = BlackMarketItemsTypeId.InventoryKeyUncommonTier1;
                        this._keyIds.push(this._keyId, BlackMarketItemsTypeId.InventoryKeyUncommonAllTiers);
                        break;
                    case InventoryItemRareness.RARE:
                        this._keyId = BlackMarketItemsTypeId.InventoryKeyRareTier1;
                        this._keyIds.push(this._keyId, BlackMarketItemsTypeId.InventoryKeyRareAllTiers);
                        break;
                    case InventoryItemRareness.EPIC:
                        this._keyId = BlackMarketItemsTypeId.InventoryKeyEpicTier1;
                        this._keyIds.push(this._keyId, BlackMarketItemsTypeId.InventoryKeyEpicAllTiers);
                }
            }
            this._keyIds.push(BlackMarketItemsTypeId.InventoryKeyUniversal);
        }
    }

    public function get availableKeyId():int {
        var boughtItems:Dictionary = null;
        var result:int = 0;
        var keyId:int = -1;
        boughtItems = UserManager.user.gameData.blackMarketData.boughtItems;
        if (Global.UNIVERSAL_KEYS_ENABLED) {
            result = query(this.keyIds).orderBy().firstOrDefault(function (param1:int):Boolean {
                return boughtItems[param1] != null && (boughtItems[param1].paidCount > 0 || boughtItems[param1].freeCount > 0);
            });
            if (result > 0) {
                keyId = result;
            }
        }
        return boughtItems[this._keyId] != null && (boughtItems[this._keyId].paidCount > 0 || boughtItems[this._keyId].freeCount > 0) ? int(this._keyId) : int(keyId);
    }
}
}
