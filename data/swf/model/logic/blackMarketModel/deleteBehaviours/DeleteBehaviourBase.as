package model.logic.blackMarketModel.deleteBehaviours {
import model.logic.blackMarketModel.deleteBehaviours.contexts.DeleteContext;
import model.logic.blackMarketModel.interfaces.IDeleteBehaviour;

public class DeleteBehaviourBase implements IDeleteBehaviour {


    private var _resultHandler:Function;

    private var _faultHandler:Function;

    public function DeleteBehaviourBase() {
        super();
    }

    public function invoke():void {
        throw new Error("DeleteBehaviourBase.invoke не переопределён!");
    }

    public function prepareDelete(param1:int, param2:DeleteContext):void {
        throw new Error("DeleteBehaviourBase.prepareDelete не переопределён!");
    }

    public final function registerResult(param1:Function):void {
        this._resultHandler = param1;
    }

    public final function registerFault(param1:Function):void {
        this._faultHandler = param1;
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
}
}
