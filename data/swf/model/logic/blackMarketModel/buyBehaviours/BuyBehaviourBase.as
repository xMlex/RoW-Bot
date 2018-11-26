package model.logic.blackMarketModel.buyBehaviours {
import model.logic.blackMarketModel.buyBehaviours.contexts.BuyContext;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;

public class BuyBehaviourBase implements IBuyBehaviour {


    private var _resultHandler:Function;

    private var _faultHandler:Function;

    public function BuyBehaviourBase() {
        super();
    }

    protected function dispatchResult(param1:* = null):void {
        if (this._resultHandler != null) {
            this._resultHandler(param1);
        }
    }

    protected function dispatchFault(param1:* = null):void {
        if (this._faultHandler != null) {
            this._faultHandler(param1);
        }
    }

    public function prepareBuy(param1:int, param2:BuyContext):void {
        throw new Error("BuyBehaviourBase.prepareBuy не переопределён!");
    }

    public function invoke():void {
        throw new Error("BuyBehaviourBase.invoke не переопределён!");
    }

    public final function registerResult(param1:Function):void {
        this._resultHandler = param1;
    }

    public final function registerFault(param1:Function):void {
        this._faultHandler = param1;
    }
}
}
