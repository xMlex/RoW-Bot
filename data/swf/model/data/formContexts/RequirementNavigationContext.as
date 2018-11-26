package model.data.formContexts {
public class RequirementNavigationContext {


    public var wishState:String;

    public var wishAction:int;

    public var wishItemId:int;

    public function RequirementNavigationContext(param1:String = "", param2:int = -1, param3:int = -1) {
        super();
        this.wishState = param1;
        this.wishAction = param2;
        this.wishItemId = param3;
    }
}
}
