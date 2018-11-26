package model.logic.blackMarketModel.services {
import model.logic.blackMarketModel.buyBehaviours.contexts.BuyContext;
import model.logic.blackMarketModel.conditions.async.AsyncConditionInvokerStub;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;
import model.logic.blackMarketModel.interfaces.temporary.IActionResult;
import model.logic.blackMarketModel.services.interfaces.IBuyService;
import model.logic.blackMarketModel.temporaryCore.ActionResult;

public class ItemBuyService implements IBuyService {


    private var _itemId:int;

    private var _buyBehaviour:IBuyBehaviour;

    private var _buyResult:IActionResult;

    private var _stubResult:IActionResult;

    public function ItemBuyService(param1:int, param2:IBuyBehaviour) {
        super();
        this._itemId = param1;
        this._buyBehaviour = param2;
        this._buyResult = new ActionResult(this._buyBehaviour);
        this._stubResult = new ActionResult(new AsyncConditionInvokerStub());
    }

    public function buy(param1:BuyContext):IActionResult {
        this._buyBehaviour.prepareBuy(this._itemId, param1);
        return this._buyResult;
    }

    public function tryBuy():IActionResult {
        return this._stubResult;
    }
}
}
