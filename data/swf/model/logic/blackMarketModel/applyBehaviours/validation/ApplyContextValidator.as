package model.logic.blackMarketModel.applyBehaviours.validation {
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;
import model.logic.blackMarketModel.conditions.interfaces.IApplyCondition;
import model.logic.blackMarketModel.interfaces.IApplyContextValidator;
import model.logic.blackMarketModel.interfaces.temporary.IActionResult;
import model.logic.blackMarketModel.services.interfaces.IApplyService;
import model.logic.blackMarketModel.temporaryCore.ActionResult;
import model.logic.blackMarketModel.temporaryCore.AsyncActionObject;

public class ApplyContextValidator extends AsyncActionObject implements IApplyContextValidator {


    private var _currentIndex:int;

    private var _currentContext:ApplyContext;

    private var _applyService:IApplyService;

    private var _applyResult:IActionResult;

    private var _conditions:Vector.<IApplyCondition>;

    public function ApplyContextValidator(param1:IApplyService) {
        super();
        this._applyService = param1;
        this._applyService.setContextValidator(this);
        this._conditions = new Vector.<IApplyCondition>();
    }

    public function addCondition(param1:IApplyCondition):void {
        this._conditions.push(param1);
    }

    override public function invoke():void {
        this._currentIndex = 0;
        this.checkCurrentCondition();
    }

    public function validate(param1:ApplyContext, param2:IActionResult):IActionResult {
        this._currentContext = param1;
        this._applyResult = param2;
        return new ActionResult(this);
    }

    private function checkCurrentCondition():void {
        var _loc1_:IApplyCondition = this._conditions[this._currentIndex];
        _loc1_.registerResult(this.changeCondition);
        _loc1_.registerFault(dispatchFault);
        _loc1_.setContext(this._currentContext);
        _loc1_.invoke();
    }

    private function changeCondition():void {
        this._currentIndex++;
        if (this._currentIndex == this._conditions.length) {
            this._applyResult.onResult(this.onApplyResult).onFault(this.onApplyFault).invokeAction();
            return;
        }
        this.checkCurrentCondition();
    }

    private function onApplyResult(param1:*):void {
        dispatchResult();
    }

    private function onApplyFault(param1:*):void {
        dispatchFault();
    }
}
}
