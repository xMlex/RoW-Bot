package model.logic.journal.events {
import flash.events.Event;

import model.data.users.troops.Troops;
import model.logic.UserManager;
import model.logic.journal.IJEventUser;
import model.logic.journal.JEventUser;
import model.logic.journal.JournalAutoRefreshManager;
import model.modules.allianceHelp.data.obj.AllianceHelpTroopsData;
import model.modules.allianceHelp.data.user.UserAllianceHelpData;
import model.modules.allianceHelp.data.user.UserAllianceHelpRequest;

public class JUEventAllianceHelpRespondAttackTarget extends JEventUser {


    public var requestId:Number;

    public var originUserId:Number;

    public var troops:Troops;

    public var troopsTime:Date;

    public function JUEventAllianceHelpRespondAttackTarget() {
        super();
    }

    public static function fromDto(param1:*):IJEventUser {
        var _loc2_:JUEventAllianceHelpRespondAttackTarget = new JUEventAllianceHelpRespondAttackTarget();
        _loc2_.requestId = param1.r;
        _loc2_.originUserId = param1.o;
        _loc2_.troops = param1.p == null ? null : Troops.fromDto(param1.p);
        _loc2_.troopsTime = param1.d == null ? null : new Date(param1.d);
        return _loc2_;
    }

    override public function apply():void {
        var _loc2_:UserAllianceHelpRequest = null;
        var _loc3_:AllianceHelpTroopsData = null;
        var _loc1_:UserAllianceHelpData = UserManager.user.gameData.allianceData.allianceHelpData;
        for each(_loc2_ in _loc1_.requests) {
            if (_loc2_.id == this.requestId) {
                _loc2_.responsesCount++;
                if (_loc2_.attackInfo.troopsSent == null) {
                    _loc2_.attackInfo.troopsSent = [];
                }
                _loc3_ = new AllianceHelpTroopsData();
                _loc3_.userId = this.originUserId;
                _loc3_.troops = this.troops;
                _loc3_.troopsTime = this.troopsTime;
                _loc2_.attackInfo.troopsSent.push(_loc3_);
                JournalAutoRefreshManager.events.dispatchEvent(new Event(JournalAutoRefreshManager.ALLIANCE_HELP_REQUEST_RESPONSE));
                break;
            }
        }
    }
}
}
