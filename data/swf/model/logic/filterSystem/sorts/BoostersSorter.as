package model.logic.filterSystem.sorts {
import common.ArrayCustom;

import model.logic.filterSystem.interfaces.IDataFilter;

public class BoostersSorter implements IDataFilter {


    public function BoostersSorter() {
        super();
    }

    public function filter(param1:Array):Array {
        return ArrayCustom.quickSort(param1, "duration");
    }
}
}
