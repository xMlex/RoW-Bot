package model.logic.blackMarketModel.applyBehaviours {
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;
import model.logic.blackMarketModel.interfaces.IApplyBehaviour;

public class ApplyBehaviourBase implements IApplyBehaviour {


    private var _resultHandler:Function;

    private var _faultHandler:Function;

    public function ApplyBehaviourBase() {
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

    public function prepareApply(param1:int, param2:ApplyContext):void {
        throw new Error("ApplyBehaviourBase.prepareApply не переопределён!");
    }

    public function invoke():void {
        throw new Error("ApplyBehaviourBase.invoke не переопределён!");
    }

    public final function registerResult(param1:Function):void {
        this._resultHandler = param1;
    }

    public final function registerFault(param1:Function):void {
        this._faultHandler = param1;
    }
}
}
