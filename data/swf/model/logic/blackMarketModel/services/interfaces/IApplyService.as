package model.logic.blackMarketModel.services.interfaces {
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;
import model.logic.blackMarketModel.interfaces.IApplyContextValidator;
import model.logic.blackMarketModel.interfaces.temporary.IActionResult;

public interface IApplyService {


    function setContextValidator(param1:IApplyContextValidator):void;

    function tryApply():IActionResult;

    function apply(param1:ApplyContext):IActionResult;
}
}
