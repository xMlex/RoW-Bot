package model.logic.inventory {
import flash.events.Event;

import model.data.User;
import model.data.effects.EffectTypeId;
import model.data.normalization.NEventUser;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.GeoSceneObjectType;
import model.logic.quests.completions.QuestCompletionPeriodic;
import model.logic.quests.periodicQuests.ComplexSource;
import model.logic.quests.periodicQuests.enums.PeriodicQuestPrototypeId;

public class NEventInventoryItemFinished extends NEventUser {


    private var _inventoryItem:GeoSceneObject;

    public function NEventInventoryItemFinished(param1:GeoSceneObject, param2:Date) {
        super(param2);
        this._inventoryItem = param1;
    }

    override protected function postProcess(param1:User, param2:Date):void {
        var _loc4_:Number = NaN;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        var _loc7_:int = 0;
        super.postProcess(param1, param2);
        var _loc3_:GeoSceneObjectType = this._inventoryItem.type as GeoSceneObjectType;
        if (this._inventoryItem.constructionInfo.isDestruction) {
            if (_loc3_) {
                _loc4_ = _loc3_.inventoryItemInfo.levelInfos[this._inventoryItem.constructionInfo.level].powderDustAmount;
                param1.gameData.inventoryData.dustAmount = param1.gameData.inventoryData.dustAmount + param1.gameData.constructionData.getItemsDustCount(_loc4_);
            }
            this._inventoryItem.inventoryItemInfo.slotId = -1;
            this._inventoryItem.constructionInfo.constructionFinishTime = null;
            param1.gameData.inventoryData.removeInventoryItem(this._inventoryItem.id);
            param1.gameData.inventoryData.updateInventoryItemsBySlotId();
            param1.gameData.inventoryData.dirty = true;
            QuestCompletionPeriodic.tryComplete(new ComplexSource().setPowderedInventoryItems(1), [PeriodicQuestPrototypeId.PowderItemHero]);
            InventoryManager.events.dispatchEvent(new Event(InventoryManager.ITEM_IS_POWDERED));
        }
        else {
            this._inventoryItem.constructionInfo.level++;
            this._inventoryItem.constructionInfo.constructionFinishTime = null;
            if (this._inventoryItem.constructionInfo.constructionBonusPowerByEffectTypeId != null && this._inventoryItem.constructionInfo.constructionBonusPowerByEffectTypeId[EffectTypeId.GppInventoryItemUpgradeBonus] != undefined) {
                _loc5_ = this._inventoryItem.constructionInfo.constructionBonusPowerByEffectTypeId[EffectTypeId.GppInventoryItemUpgradeBonus];
                _loc6_ = GeoSceneObjectType(this._inventoryItem.type).saleableInfo.levelsCount - 1;
                _loc7_ = _loc6_ - this._inventoryItem.constructionInfo.level;
                this._inventoryItem.constructionInfo.level = this._inventoryItem.constructionInfo.level + Math.min(_loc5_, _loc7_);
                delete this._inventoryItem.constructionInfo.constructionBonusPowerByEffectTypeId[EffectTypeId.GppInventoryItemUpgradeBonus];
            }
            param1.gameData.inventoryData.updateInventoryItemsBySlotId();
            QuestCompletionPeriodic.tryComplete(ComplexSource.fromInventoryItem(_loc3_.inventoryItemInfo.requiredTier, this._inventoryItem.constructionInfo.level), [PeriodicQuestPrototypeId.UpgradeInventoryItem]);
            InventoryManager.events.dispatchEvent(new Event(InventoryManager.ITEM_IS_UPGRADED));
        }
        param1.gameData.inventoryData.dirty = true;
    }
}
}
