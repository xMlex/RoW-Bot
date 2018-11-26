package model.logic.filterSystem.contexts.blackMarket {
import model.logic.filterSystem.interfaces.IFilterContext;

public class ResourceSortContext implements IFilterContext {

    private static const _name:String = "ResourceSortContext";


    public var resourceType:int;

    public function ResourceSortContext() {
        super();
    }

    public function get name():String {
        return _name;
    }

    public function typeEquals(param1:IFilterContext):Boolean {
        var _loc2_:ResourceSortContext = param1 as ResourceSortContext;
        if (!_loc2_) {
            return false;
        }
        return true;
    }

    public function equals(param1:IFilterContext):Boolean {
        var _loc2_:ResourceSortContext = param1 as ResourceSortContext;
        if (!_loc2_) {
            return false;
        }
        if (this.resourceType != _loc2_.resourceType) {
            return false;
        }
        return true;
    }
}
}
