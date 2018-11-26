package model.logic.filterSystem.contexts.blackMarket {
import model.logic.filterSystem.interfaces.IFilterContext;

public class TechFilterContext implements IFilterContext {

    private static const _name:String = "TechFilterContext";


    public var techLevel:int;

    public function TechFilterContext() {
        super();
    }

    public function get name():String {
        return _name;
    }

    public function typeEquals(param1:IFilterContext):Boolean {
        var _loc2_:TechFilterContext = param1 as TechFilterContext;
        if (!_loc2_) {
            return false;
        }
        return true;
    }

    public function equals(param1:IFilterContext):Boolean {
        var _loc2_:TechFilterContext = param1 as TechFilterContext;
        if (!_loc2_) {
            return false;
        }
        if (this.techLevel != _loc2_.techLevel) {
            return false;
        }
        return true;
    }
}
}
