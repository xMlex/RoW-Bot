package model.logic.conditions {
public class ConditionQueueAnd extends ConditionQueue {


    public function ConditionQueueAnd() {
        super();
    }

    override protected function checkCondition(param1:Condition):void {
        param1.ifTrue(checkNextCondition);
        param1.ifFalse(callFaults);
        param1.checkAsync();
    }

    override protected function checkFinished():void {
        callResults();
    }
}
}
