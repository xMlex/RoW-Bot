package model.logic.lotteries {
import model.logic.filterSystem.interfaces.IArrayChangesChecker;

public class ArrayLengthChangesChecker implements IArrayChangesChecker {


    public function ArrayLengthChangesChecker() {
        super();
    }

    public function hasChanges(param1:Array, param2:Array):Boolean {
        if (param1 == null || param2 == null) {
            return true;
        }
        return param1.length != param2.length;
    }
}
}
