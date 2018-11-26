package model.logic.sale.bonusItem.blocks {
import common.StringUtil;
import common.localization.LocaleUtil;

import model.logic.blackMarketItems.BlackMarketGemRemovalData;
import model.logic.sale.bonusItem.IAppliableFilling;
import model.logic.sale.bonusItem.dynamicFilling.IFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.IGemFillingElement;

public class GemRemovalFillingBlock implements IAppliableFilling {

    private static const TEXT_LEVEL:String = LocaleUtil.getText("controls-common-requirements-buyRequirementsSmallControl_level");


    private var _gemRemovalData:BlackMarketGemRemovalData;

    public function GemRemovalFillingBlock(param1:BlackMarketGemRemovalData) {
        super();
        this._gemRemovalData = param1;
    }

    public function get type():int {
        return FillingBlocksTypeEnum.GEM_REMOVAL;
    }

    public function apply(param1:IFillingElement):void {
        var _loc2_:IGemFillingElement = param1 as IGemFillingElement;
        if (_loc2_ == null) {
            return;
        }
        if (this._gemRemovalData.gemLevelFrom == this._gemRemovalData.gemLevelTo) {
            _loc2_.fillGemLevel(TEXT_LEVEL + this._gemRemovalData.gemLevelFrom);
        }
        else {
            _loc2_.fillGemLevel(TEXT_LEVEL + StringUtil.WHITESPACE + this._gemRemovalData.gemLevelFrom + " - " + this._gemRemovalData.gemLevelTo);
        }
    }
}
}
