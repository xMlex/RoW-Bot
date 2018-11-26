package model.logic.journal.events {
import flash.events.Event;

import model.data.units.Unit;
import model.logic.AllianceManager;
import model.logic.UserManager;
import model.logic.journal.JEventUser;
import model.logic.journal.JournalAutoRefreshManager;
import model.modules.allianceHelp.AllianceHelpRequestState;
import model.modules.allianceHelp.data.alliance.AllianceHelpData;
import model.modules.allianceHelp.data.alliance.AllianceHelpRequest;
import model.modules.allianceHelp.data.user.UserAllianceHelpData;
import model.modules.allianceHelp.data.user.UserAllianceHelpRequest;

public class JUEventAllianceHelpConfirmResources extends JEventUser {


    public var requestId:Number;

    public var allianceId:Number;

    public var unit:Unit;

    public function JUEventAllianceHelpConfirmResources() {
        super();
    }

    public static function fromDto(param1:*):JUEventAllianceHelpConfirmResources {
        var _loc2_:JUEventAllianceHelpConfirmResources = new JUEventAllianceHelpConfirmResources();
        _loc2_.requestId = param1.r;
        _loc2_.allianceId = param1.a;
        _loc2_.unit = param1.n == null ? null : Unit.fromDto(param1.n);
        return _loc2_;
    }

    override public function apply():void {
        var _loc5_:UserAllianceHelpRequest = null;
        var _loc6_:AllianceHelpData = null;
        var _loc7_:AllianceHelpRequest = null;
        var _loc1_:UserAllianceHelpData = UserManager.user.gameData.allianceData.allianceHelpData;
        if (_loc1_ == null || _loc1_.requests == null) {
            return;
        }
        JournalAutoRefreshManager.events.dispatchEvent(new Event(JournalAutoRefreshManager.ALLIANCE_HELP_REQUEST_RESPONSE));
        var _loc2_:Boolean = false;
        var _loc3_:int = -1;
        var _loc4_:int = 0;
        while (_loc4_ < _loc1_.requests.length) {
            _loc5_ = _loc1_.requests[_loc4_] as UserAllianceHelpRequest;
            if (_loc5_.id != this.requestId) {
                _loc4_++;
                continue;
            }
            _loc5_.responsesCount++;
            _loc5_.resourcesInfo.resourcesConfirmed.add(this.unit.tradingPayload.resources);
            _loc5_.resourcesInfo.resourcesConfirmed.leadToPositive();
            if (_loc5_.resourcesInfo.resourcesConfirmed.greaterOrEquals(_loc5_.resourcesInfo.resourcesRequested)) {
                _loc5_.state = AllianceHelpRequestState.COMPLETED;
                _loc2_ = true;
                _loc1_.requests.splice(_loc4_, 1);
                JournalAutoRefreshManager.events.dispatchEvent(new Event(JournalAutoRefreshManager.ALLIANCE_HELP_REQUEST_MAX_RESOURCES_RESPONSE));
            }
            break;
        }
        if (_loc2_) {
            _loc6_ = AllianceManager.currentAlliance.gameData.helpData;
            if (_loc6_ != null && _loc6_.requests != null) {
                _loc4_ = 0;
                while (_loc4_ < _loc6_.requests.length) {
                    _loc7_ = _loc6_.requests[_loc4_] as AllianceHelpRequest;
                    if (_loc7_.id != this.requestId) {
                        _loc4_++;
                        continue;
                    }
                    _loc6_.requests.splice(_loc4_, 1);
                    break;
                }
            }
        }
    }
}
}
