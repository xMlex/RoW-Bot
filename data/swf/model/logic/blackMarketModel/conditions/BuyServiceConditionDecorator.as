package model.logic.blackMarketModel.conditions {
import model.logic.blackMarketModel.buyBehaviours.contexts.BuyContext;
import model.logic.blackMarketModel.conditions.async.AsyncConditionInvoker;
import model.logic.blackMarketModel.conditions.interfaces.ICondition;
import model.logic.blackMarketModel.interfaces.temporary.IActionResult;
import model.logic.blackMarketModel.services.interfaces.IBuyService;
import model.logic.blackMarketModel.temporaryCore.ActionResult;
import model.logic.blackMarketModel.temporaryCore.StubActionResult;

public class BuyServiceConditionDecorator implements IBuyService {


    private var _innerService:IBuyService;

    private var _conditions:Vector.<ICondition>;

    private var _actionResult:IActionResult;

    public function BuyServiceConditionDecorator(param1:IBuyService) {
        super();
        this._innerService = param1;
        this._conditions = new Vector.<ICondition>();
        this._actionResult = new StubActionResult();
    }

    public function addCondition(param1:ICondition):void {
        this._conditions.push(param1);
    }

    public function buy(param1:BuyContext):IActionResult {
        return this._innerService.buy(param1);
    }

    public function tryBuy():IActionResult {
        return new ActionResult(new AsyncConditionInvoker(this._conditions));
    }
}
}
