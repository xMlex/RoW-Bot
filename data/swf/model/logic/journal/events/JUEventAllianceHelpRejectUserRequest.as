package model.logic.journal.events {
import model.logic.UserManager;
import model.logic.journal.IJEventUser;
import model.logic.journal.JEventUser;
import model.modules.allianceHelp.data.user.UserAllianceHelpData;
import model.modules.allianceHelp.data.user.UserAllianceHelpRequest;

public class JUEventAllianceHelpRejectUserRequest extends JEventUser {


    public var personalRequestId:Number;

    public var code:int;

    public function JUEventAllianceHelpRejectUserRequest() {
        super();
    }

    public static function fromDto(param1:*):IJEventUser {
        var _loc2_:JUEventAllianceHelpRejectUserRequest = new JUEventAllianceHelpRejectUserRequest();
        _loc2_.personalRequestId = param1.p;
        _loc2_.code = param1.c;
        return _loc2_;
    }

    override public function apply():void {
        var _loc3_:UserAllianceHelpRequest = null;
        var _loc1_:UserAllianceHelpData = UserManager.user.gameData.allianceData.allianceHelpData;
        if (_loc1_.requests == null || _loc1_.requests.length == 0) {
            return;
        }
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_.requests.length) {
            _loc3_ = _loc1_.requests[_loc2_] as UserAllianceHelpRequest;
            if (_loc3_.personalRequestId == this.personalRequestId) {
                _loc1_.requests.splice(_loc2_, 1);
                break;
            }
            _loc2_++;
        }
    }
}
}
