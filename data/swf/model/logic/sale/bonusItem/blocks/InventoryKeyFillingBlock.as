package model.logic.sale.bonusItem.blocks {
import common.StringUtil;
import common.localization.LocaleUtil;

import model.data.inventory.InventoryItemRareness;
import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.sale.bonusItem.IAppliableFilling;
import model.logic.sale.bonusItem.dynamicFilling.IFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.IInventoryKeyFillingElement;

public class InventoryKeyFillingBlock implements IAppliableFilling {


    private var _item:BlackMarketItemRaw;

    public function InventoryKeyFillingBlock(param1:BlackMarketItemRaw) {
        super();
        this._item = param1;
    }

    public function get type():int {
        return FillingBlocksTypeEnum.INVENTORY_KEY;
    }

    public function apply(param1:IFillingElement):void {
        var _loc2_:IInventoryKeyFillingElement = param1 as IInventoryKeyFillingElement;
        if (_loc2_ == null) {
            return;
        }
        var _loc3_:String = StringUtil.EMPTY;
        switch (this._item.inventoryKeyData.rareness) {
            case InventoryItemRareness.UNCOMMON:
                _loc3_ = LocaleUtil.getText("forms-formHero_inventoryControlDescription_Uncommon");
                break;
            case InventoryItemRareness.RARE:
                _loc3_ = LocaleUtil.getText("forms-formHero_inventoryControlDescription_Rare");
                break;
            case InventoryItemRareness.EPIC:
                _loc3_ = LocaleUtil.getText("forms-formHero_inventoryControlDescription_Epic");
                break;
            case InventoryItemRareness.ALL_RARENESS:
                _loc3_ = LocaleUtil.getText("forms-formHero_inventoryControlDescription_AllRareness");
        }
        _loc2_.fillRareness(_loc3_);
        _loc2_.fillClassName(this.getNameClass(this._item.id));
    }

    private function getNameClass(param1:int):String {
        var _loc2_:String = null;
        switch (param1) {
            case BlackMarketItemsTypeId.InventoryKeyUncommonTier1:
            case BlackMarketItemsTypeId.InventoryKeyRareTier1:
            case BlackMarketItemsTypeId.InventoryKeyEpicTier1:
            case BlackMarketItemsTypeId.InventoryChestTier1Uncommon:
            case BlackMarketItemsTypeId.InventoryChestTier1Rare:
            case BlackMarketItemsTypeId.InventoryChestTier1Epic:
                _loc2_ = LocaleUtil.getText("bonusItem_heroItem_class1");
                break;
            case BlackMarketItemsTypeId.InventoryKeyUncommonTier2:
            case BlackMarketItemsTypeId.InventoryKeyRareTier2:
            case BlackMarketItemsTypeId.InventoryKeyEpicTier2:
            case BlackMarketItemsTypeId.InventoryChestTier2Uncommon:
            case BlackMarketItemsTypeId.InventoryChestTier2Rare:
            case BlackMarketItemsTypeId.InventoryChestTier2Epic:
                _loc2_ = LocaleUtil.getText("bonusItem_heroItem_class2");
                break;
            case BlackMarketItemsTypeId.InventoryKeyUncommonTier3:
            case BlackMarketItemsTypeId.InventoryKeyRareTier3:
            case BlackMarketItemsTypeId.InventoryKeyEpicTier3:
            case BlackMarketItemsTypeId.InventoryChestTier3Uncommon:
            case BlackMarketItemsTypeId.InventoryChestTier3Rare:
            case BlackMarketItemsTypeId.InventoryChestTier3Epic:
                _loc2_ = LocaleUtil.getText("bonusItem_heroItem_class3");
                break;
            case BlackMarketItemsTypeId.InventoryKeyUncommonTier4:
            case BlackMarketItemsTypeId.InventoryKeyRareTier4:
            case BlackMarketItemsTypeId.InventoryKeyEpicTier4:
            case BlackMarketItemsTypeId.InventoryChestTier4Uncommon:
            case BlackMarketItemsTypeId.InventoryChestTier4Rare:
            case BlackMarketItemsTypeId.InventoryChestTier4Epic:
                _loc2_ = LocaleUtil.getText("bonusItem_heroItem_class4");
                break;
            case BlackMarketItemsTypeId.InventoryKeyUncommonAllTiers:
            case BlackMarketItemsTypeId.InventoryKeyRareAllTiers:
            case BlackMarketItemsTypeId.InventoryKeyEpicAllTiers:
                _loc2_ = LocaleUtil.getText("bonusItem_heroKey_master");
        }
        return _loc2_;
    }
}
}
