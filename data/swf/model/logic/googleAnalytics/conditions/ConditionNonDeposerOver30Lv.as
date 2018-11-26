package model.logic.googleAnalytics.conditions {
public class ConditionNonDeposerOver30Lv extends GAConditionBase {


    public function ConditionNonDeposerOver30Lv() {
        super();
    }

    override public function get check():Boolean {
        return false;
    }
}
}
