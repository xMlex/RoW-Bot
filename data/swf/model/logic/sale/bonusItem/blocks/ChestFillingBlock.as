package model.logic.sale.bonusItem.blocks {
import common.StringUtil;
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketChestData;
import model.logic.sale.bonusItem.IAppliableFilling;
import model.logic.sale.bonusItem.dynamicFilling.IFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.IGemFillingElement;

public class ChestFillingBlock implements IAppliableFilling {

    private static const TEXT_LEVEL:String = LocaleUtil.getText("controls-common-requirements-buyRequirementsSmallControl_level");

    private static const KEY_ITEM_CHEST:String = "bonusItem_chestFillingBlock_itemChest";


    private var _chestData:BlackMarketChestData;

    private var _count:int;

    public function ChestFillingBlock(param1:BlackMarketChestData, param2:int) {
        super();
        this._chestData = param1;
        this._count = param2;
    }

    public function get type():int {
        return FillingBlocksTypeEnum.CHEST;
    }

    public function apply(param1:IFillingElement):void {
        var _loc2_:IGemFillingElement = param1 as IGemFillingElement;
        if (_loc2_ == null) {
            return;
        }
        _loc2_.fillGemCount(LocaleUtil.buildString(KEY_ITEM_CHEST, this._chestData.gemCount * this._count));
        if (this._chestData.gemLevelFrom == this._chestData.gemLevelTo) {
            _loc2_.fillGemLevel(TEXT_LEVEL + StringUtil.WHITESPACE + this._chestData.gemLevelFrom);
        }
        else {
            _loc2_.fillGemLevel(TEXT_LEVEL + StringUtil.WHITESPACE + this._chestData.gemLevelFrom + " - " + this._chestData.gemLevelTo);
        }
    }
}
}
