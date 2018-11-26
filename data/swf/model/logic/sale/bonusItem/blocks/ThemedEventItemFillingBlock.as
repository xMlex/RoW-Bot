package model.logic.sale.bonusItem.blocks {
import common.StringUtil;
import common.localization.LocaleUtil;

import model.data.wisdomSkills.LocalTexts;
import model.logic.UserManager;
import model.logic.quests.data.Quest;
import model.logic.quests.data.QuestState;
import model.logic.sale.bonusItem.IAppliableFilling;
import model.logic.sale.bonusItem.dynamicFilling.IFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.IThemeEventItemFillingElement;

public class ThemedEventItemFillingBlock implements IAppliableFilling {


    private var _weight:int;

    public function ThemedEventItemFillingBlock(param1:int) {
        super();
        this._weight = param1;
    }

    public function get type():int {
        return FillingBlocksTypeEnum.THEMED_ITEM;
    }

    public function apply(param1:IFillingElement):void {
        var _loc2_:IThemeEventItemFillingElement = param1 as IThemeEventItemFillingElement;
        if (_loc2_ == null) {
            return;
        }
        var _loc3_:QuestState = UserManager.user.gameData.questData.activeThemedEvent;
        if (_loc3_ == null) {
            return;
        }
        var _loc4_:Quest = UserManager.user.gameData.questData.getQuestById(_loc3_.questId);
        var _loc5_:LocalTexts = _loc4_.collectibleThemedItemsEvent.itemRares[this._weight];
        var _loc6_:String = _loc5_.code;
        _loc2_.fillThemedItemTypeName(_loc6_);
        _loc2_.fillThemedItemType(this._weight);
        _loc2_.fillThemedItemWeight(LocaleUtil.getText("forms-formGlobalCollectableThemedItemsEvent_points") + StringUtil.WHITESPACE + this._weight);
    }
}
}
