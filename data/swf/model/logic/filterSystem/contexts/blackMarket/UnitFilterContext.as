package model.logic.filterSystem.contexts.blackMarket {
import model.logic.filterSystem.ArrayChangesChecker;
import model.logic.filterSystem.interfaces.IArrayChangesChecker;
import model.logic.filterSystem.interfaces.IFilterContext;

public class UnitFilterContext implements IFilterContext {

    private static const _name:String = "UnitFilterContext";


    private var _checker:IArrayChangesChecker;

    public var typeIds:Array;

    public function UnitFilterContext() {
        super();
        this._checker = new ArrayChangesChecker();
    }

    public function get name():String {
        return _name;
    }

    public function typeEquals(param1:IFilterContext):Boolean {
        var _loc2_:UnitFilterContext = param1 as UnitFilterContext;
        if (!_loc2_) {
            return false;
        }
        return true;
    }

    public function equals(param1:IFilterContext):Boolean {
        var _loc2_:UnitFilterContext = param1 as UnitFilterContext;
        if (!_loc2_) {
            return false;
        }
        if (this._checker.hasChanges(this.typeIds, _loc2_.typeIds)) {
            return false;
        }
        return true;
    }
}
}
