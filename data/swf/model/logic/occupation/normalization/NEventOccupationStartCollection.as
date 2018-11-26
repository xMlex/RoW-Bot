package model.logic.occupation.normalization {
import model.data.User;
import model.data.normalization.NEventUser;
import model.logic.occupation.data.OccupationState;
import model.logic.occupation.data.UserOccupationInfo;

public class NEventOccupationStartCollection extends NEventUser {


    private var _info:UserOccupationInfo;

    public function NEventOccupationStartCollection(param1:UserOccupationInfo, param2:Date) {
        super(param2);
        this._info = param1;
    }

    override protected function postProcess(param1:User, param2:Date):void {
        this._info.state = OccupationState.COLLECTING;
        this._info.dirtyNormalized = true;
    }
}
}
