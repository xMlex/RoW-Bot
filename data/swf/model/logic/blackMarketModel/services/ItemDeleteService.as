package model.logic.blackMarketModel.services {
import model.logic.blackMarketModel.conditions.async.AsyncConditionInvokerStub;
import model.logic.blackMarketModel.deleteBehaviours.contexts.DeleteContext;
import model.logic.blackMarketModel.interfaces.IDeleteBehaviour;
import model.logic.blackMarketModel.interfaces.temporary.IActionResult;
import model.logic.blackMarketModel.services.interfaces.IDeleteService;
import model.logic.blackMarketModel.temporaryCore.ActionResult;

public class ItemDeleteService implements IDeleteService {


    private var _itemId:int;

    private var _deleteBehaviour:IDeleteBehaviour;

    private var _deleteResult:IActionResult;

    private var _stubResult:IActionResult;

    public function ItemDeleteService(param1:int, param2:IDeleteBehaviour) {
        super();
        this._itemId = param1;
        this._deleteBehaviour = param2;
        this._deleteResult = new ActionResult(this._deleteBehaviour);
        this._stubResult = new ActionResult(new AsyncConditionInvokerStub());
    }

    public function deleteItem(param1:DeleteContext):IActionResult {
        this._deleteBehaviour.prepareDelete(this._itemId, param1);
        return this._deleteResult;
    }

    public function tryDeleteItem():IActionResult {
        return this._stubResult;
    }
}
}
