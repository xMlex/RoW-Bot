package model.logic.filterSystem.contexts {
import model.logic.filterSystem.interfaces.IFilterContext;

public class ActivatableFilterContext implements IFilterContext {


    public var doFilter:Boolean;

    public function ActivatableFilterContext() {
        super();
    }

    public function get name():String {
        throw new Error("ActivatableSortContext.name не был переопределён!");
    }

    public function typeEquals(param1:IFilterContext):Boolean {
        var _loc2_:ActivatableFilterContext = param1 as ActivatableFilterContext;
        if (!_loc2_) {
            return false;
        }
        return true;
    }

    public function equals(param1:IFilterContext):Boolean {
        var _loc2_:ActivatableFilterContext = param1 as ActivatableFilterContext;
        if (!_loc2_) {
            return false;
        }
        if (this.doFilter != _loc2_.doFilter) {
            return false;
        }
        return false;
    }
}
}
