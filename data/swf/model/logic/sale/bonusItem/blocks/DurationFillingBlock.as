package model.logic.sale.bonusItem.blocks {
import common.DateUtil;
import common.TimeSpan;

import model.logic.sale.bonusItem.IAppliableFilling;
import model.logic.sale.bonusItem.dynamicFilling.IDurationFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.IFillingElement;

public class DurationFillingBlock implements IAppliableFilling {


    private var _seconds:Number;

    public function DurationFillingBlock(param1:Number) {
        super();
        this._seconds = param1;
    }

    public function get type():int {
        return FillingBlocksTypeEnum.DURATION;
    }

    public function apply(param1:IFillingElement):void {
        var _loc2_:IDurationFillingElement = param1 as IDurationFillingElement;
        if (_loc2_ == null) {
            return;
        }
        _loc2_.fillDuration(DateUtil.normalizeTimeViewWithSpace(TimeSpan.fromSeconds(this._seconds)));
    }
}
}
