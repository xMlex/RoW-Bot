package model.logic.blackMarketModel.conditions {
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;
import model.logic.blackMarketModel.conditions.async.AsyncConditionInvoker;
import model.logic.blackMarketModel.conditions.interfaces.ICondition;
import model.logic.blackMarketModel.interfaces.IApplyContextValidator;
import model.logic.blackMarketModel.interfaces.temporary.IActionResult;
import model.logic.blackMarketModel.services.interfaces.IApplyService;
import model.logic.blackMarketModel.temporaryCore.ActionResult;

public class ApplyServiceConditionDecorator implements IApplyService {


    private var _innerService:IApplyService;

    private var _conditions:Vector.<ICondition>;

    public function ApplyServiceConditionDecorator(param1:IApplyService) {
        super();
        this._innerService = param1;
        this._conditions = new Vector.<ICondition>();
    }

    public function addCondition(param1:ICondition):void {
        this._conditions.push(param1);
    }

    public function apply(param1:ApplyContext):IActionResult {
        return this._innerService.apply(param1);
    }

    public function tryApply():IActionResult {
        return new ActionResult(new AsyncConditionInvoker(this._conditions));
    }

    public function setContextValidator(param1:IApplyContextValidator):void {
        this._innerService.setContextValidator(param1);
    }
}
}
