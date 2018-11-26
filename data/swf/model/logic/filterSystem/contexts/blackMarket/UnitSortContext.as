package model.logic.filterSystem.contexts.blackMarket {
import model.logic.filterSystem.contexts.ActivatableFilterContext;

public class UnitSortContext extends ActivatableFilterContext {

    private static const _name:String = "UnitSortContext";


    public function UnitSortContext() {
        super();
    }

    override public function get name():String {
        return _name;
    }
}
}
