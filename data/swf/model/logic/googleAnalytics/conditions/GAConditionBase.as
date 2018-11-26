package model.logic.googleAnalytics.conditions {
public class GAConditionBase implements IConditionGA {


    public function GAConditionBase(param1:* = null) {
        super();
    }

    public function get check():Boolean {
        return false;
    }
}
}
