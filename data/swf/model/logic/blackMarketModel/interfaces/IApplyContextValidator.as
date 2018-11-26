package model.logic.blackMarketModel.interfaces {
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;
import model.logic.blackMarketModel.conditions.interfaces.IApplyCondition;
import model.logic.blackMarketModel.interfaces.temporary.IActionResult;

public interface IApplyContextValidator {


    function validate(param1:ApplyContext, param2:IActionResult):IActionResult;

    function addCondition(param1:IApplyCondition):void;
}
}
