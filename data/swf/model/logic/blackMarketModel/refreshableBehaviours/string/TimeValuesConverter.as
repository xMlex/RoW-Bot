package model.logic.blackMarketModel.refreshableBehaviours.string {
import common.DateUtil;
import common.TimeSpan;
import common.localization.LocaleUtil;

import model.logic.blackMarketModel.interfaces.temporary.ISeveralValuesConverter;

public class TimeValuesConverter implements ISeveralValuesConverter {


    public function TimeValuesConverter() {
        super();
    }

    public function convertValue(param1:int, param2:int):String {
        var _loc3_:int = param1 * param2;
        return LocaleUtil.buildString("forms-formApplySeveralItems_boostTime", DateUtil.normalizeTimeBoostView(TimeSpan.fromSeconds(_loc3_)));
    }
}
}
