package model.data.users.acceleration {
import common.TimeSpan;

import model.data.User;
import model.data.effects.EffectItem;
import model.data.normalization.NEventUser;

public class NEventPeriodicEffectAction extends NEventUser {


    private var _effectReadyToAct:EffectItem;

    public function NEventPeriodicEffectAction(param1:Date, param2:EffectItem) {
        super(param1);
        this._effectReadyToAct = param2;
    }

    override protected function postProcess(param1:User, param2:Date):void {
        super.postProcess(param1, param2);
        var _loc3_:TimeSpan = this._effectReadyToAct.activeState.periodicEffectActionState.actionInfo.period;
        this._effectReadyToAct.activeState.periodicEffectActionState.nextActionTime = new Date(param2.getTime() + _loc3_.toMilliseconds());
    }
}
}
