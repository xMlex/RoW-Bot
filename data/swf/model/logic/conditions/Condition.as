package model.logic.conditions {
public class Condition {


    protected var resultHandler:Function;

    protected var faultHandler:Function;

    protected var conditionContext:ConditionContext;

    public function Condition() {
        super();
    }

    public function context(param1:ConditionContext):Condition {
        this.conditionContext = param1;
        return this;
    }

    public function ifTrue(param1:Function):Condition {
        this.resultHandler = param1;
        return this;
    }

    public function ifFalse(param1:Function):Condition {
        this.faultHandler = param1;
        return this;
    }

    public function check():Boolean {
        return false;
    }

    public function checkAsync():void {
        if (this.check()) {
            if (this.resultHandler != null) {
                this.resultHandler();
            }
        }
        else if (this.faultHandler != null) {
            this.faultHandler();
        }
    }
}
}
