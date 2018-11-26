package model.data.formContexts {
import model.data.Resources;

public class RequirementItemData {


    public var itemId:int;

    public var missingResources:Resources;

    public var missingItemUrl:String;

    public var missingItemGoldMoneyPrice:int;

    public var isResources:Boolean;

    public var isItem:Boolean;

    public function RequirementItemData() {
        super();
    }
}
}
