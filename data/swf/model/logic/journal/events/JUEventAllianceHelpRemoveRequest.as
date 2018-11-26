package model.logic.journal.events {
import flash.events.Event;

import model.logic.UserManager;
import model.logic.journal.IJEventUser;
import model.logic.journal.JEventUser;
import model.logic.journal.JournalAutoRefreshManager;
import model.modules.allianceHelp.data.user.UserAllianceHelpData;
import model.modules.allianceHelp.data.user.UserAllianceHelpRequest;

public class JUEventAllianceHelpRemoveRequest extends JEventUser {


    public var requestId:Number;

    public var towerWasCaptured:Boolean;

    public function JUEventAllianceHelpRemoveRequest() {
        super();
    }

    public static function fromDto(param1:*):IJEventUser {
        var _loc2_:JUEventAllianceHelpRemoveRequest = new JUEventAllianceHelpRemoveRequest();
        _loc2_.requestId = param1.r;
        _loc2_.towerWasCaptured = param1.w;
        return _loc2_;
    }

    override public function apply():void {
        var _loc3_:UserAllianceHelpRequest = null;
        var _loc1_:UserAllianceHelpData = UserManager.user.gameData.allianceData.allianceHelpData;
        if (_loc1_ == null || _loc1_.requests == null || _loc1_.requests.length == 0) {
            return;
        }
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_.requests.length) {
            _loc3_ = _loc1_.requests[_loc2_] as UserAllianceHelpRequest;
            if (_loc3_.id == this.requestId) {
                _loc1_.requests.splice(_loc2_, 1);
                if (this.towerWasCaptured) {
                    JournalAutoRefreshManager.events.dispatchEvent(new Event(JournalAutoRefreshManager.ALLIANCE_HELP_REQUEST_TOWER_ATTACK_REJECTED));
                }
                else {
                    JournalAutoRefreshManager.events.dispatchEvent(new Event(JournalAutoRefreshManager.ALLIANCE_HELP_REQUEST_WAS_REJECTED));
                }
                break;
            }
            _loc2_++;
        }
    }
}
}
