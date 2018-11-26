package model.logic.filterSystem.sorts {
import common.queries.util.query;

import model.logic.filterSystem.interfaces.IDataFilter;

public class ByEndTimeSorter implements IDataFilter {


    public function ByEndTimeSorter() {
        super();
    }

    public function filter(param1:Array):Array {
        var data:Array = param1;
        var activeData:Array = query(data).where(function (param1:*):Boolean {
            return !isNaN(param1.dynamicDate.value.time);
        }).orderBy(function (param1:*):* {
            return param1.dynamicDate.value.time;
        }).toArray();
        var restData:Array = query(data).where(function (param1:*):Boolean {
            return isNaN(param1.dynamicDate.value.time);
        }).toArray();
        if (activeData == null) {
            return restData;
        }
        return activeData.concat(restData);
    }
}
}
