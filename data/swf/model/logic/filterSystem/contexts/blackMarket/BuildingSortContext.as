package model.logic.filterSystem.contexts.blackMarket {
import model.logic.filterSystem.contexts.ActivatableFilterContext;

public class BuildingSortContext extends ActivatableFilterContext {

    private static const _name:String = "BuildingSortContext";


    public function BuildingSortContext() {
        super();
    }

    override public function get name():String {
        return _name;
    }
}
}
