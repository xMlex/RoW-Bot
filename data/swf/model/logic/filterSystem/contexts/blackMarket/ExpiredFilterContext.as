package model.logic.filterSystem.contexts.blackMarket {
import model.logic.filterSystem.interfaces.IFilterContext;

public class ExpiredFilterContext implements IFilterContext {

    private static const NAME:String = "ExpiredFilterContext";


    public var isExpired:Boolean;

    public function ExpiredFilterContext() {
        super();
    }

    public function get name():String {
        return NAME;
    }

    public function typeEquals(param1:IFilterContext):Boolean {
        var _loc2_:ExpiredFilterContext = param1 as ExpiredFilterContext;
        if (_loc2_ == null) {
            return false;
        }
        return true;
    }

    public function equals(param1:IFilterContext):Boolean {
        var _loc2_:ExpiredFilterContext = param1 as ExpiredFilterContext;
        if (_loc2_ == null) {
            return false;
        }
        return this.isExpired == _loc2_.isExpired;
    }
}
}
