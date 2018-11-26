package model.logic.blackMarketModel.services {
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;
import model.logic.blackMarketModel.conditions.async.AsyncConditionInvokerStub;
import model.logic.blackMarketModel.interfaces.IApplyBehaviour;
import model.logic.blackMarketModel.interfaces.IApplyContextValidator;
import model.logic.blackMarketModel.interfaces.temporary.IActionResult;
import model.logic.blackMarketModel.services.interfaces.IApplyService;
import model.logic.blackMarketModel.temporaryCore.ActionResult;

public class ItemApplyService implements IApplyService {


    private var _itemId:int;

    private var _applyBehaviour:IApplyBehaviour;

    private var _applyResult:IActionResult;

    private var _stubResult:IActionResult;

    public var contextValidator:IApplyContextValidator;

    public function ItemApplyService(param1:int, param2:IApplyBehaviour) {
        super();
        this._itemId = param1;
        this._applyBehaviour = param2;
        this._applyResult = new ActionResult(this._applyBehaviour);
        this._stubResult = new ActionResult(new AsyncConditionInvokerStub());
    }

    public function apply(param1:ApplyContext):IActionResult {
        this._applyBehaviour.prepareApply(this._itemId, param1);
        if (this.contextValidator) {
            return this.contextValidator.validate(param1, this._applyResult);
        }
        return this._applyResult;
    }

    public function tryApply():IActionResult {
        return this._stubResult;
    }

    public function setContextValidator(param1:IApplyContextValidator):void {
        this.contextValidator = param1;
    }
}
}
