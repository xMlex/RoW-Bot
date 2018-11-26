package model.logic.sale.bonusItem.blocks {
import common.StringUtil;

import model.logic.sale.bonusItem.IAppliableFilling;
import model.logic.sale.bonusItem.dynamicFilling.IFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.IPercentFillingElement;

public class PercentFillingBlock implements IAppliableFilling {


    private var _percent:int;

    public function PercentFillingBlock(param1:int) {
        super();
        this._percent = param1;
    }

    public function get type():int {
        return FillingBlocksTypeEnum.PERCENT;
    }

    public function apply(param1:IFillingElement):void {
        var _loc2_:IPercentFillingElement = param1 as IPercentFillingElement;
        if (_loc2_ == null) {
            return;
        }
        var _loc3_:String = this._percent > 0 ? StringUtil.PLUS : StringUtil.EMPTY;
        _loc2_.fillPercent(_loc3_ + this._percent + StringUtil.WHITESPACE + StringUtil.PERCENT);
    }
}
}
