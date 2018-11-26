package model.logic.journal.events {
import flash.events.Event;

import model.data.scenes.objects.GeoSceneObject;
import model.logic.UserManager;
import model.logic.journal.IJEventUser;
import model.logic.journal.JEventUser;
import model.logic.journal.JournalAutoRefreshManager;
import model.modules.allianceHelp.data.user.UserAllianceHelpData;
import model.modules.allianceHelp.data.user.UserAllianceHelpRequest;

public class JUEventAllianceHelpRespondBuildingTarget extends JEventUser {


    public var buildingId:Number;

    public var boostSeconds:Number;

    public var requestId:Number;

    public var originUserId:Number;

    public var maxMembersAbleToRespond:int;

    public function JUEventAllianceHelpRespondBuildingTarget() {
        super();
    }

    public static function fromDto(param1:*):IJEventUser {
        var _loc2_:JUEventAllianceHelpRespondBuildingTarget = new JUEventAllianceHelpRespondBuildingTarget();
        _loc2_.buildingId = param1.b;
        _loc2_.boostSeconds = param1.s;
        _loc2_.requestId = param1.r;
        _loc2_.originUserId = param1.o;
        _loc2_.maxMembersAbleToRespond = param1.m;
        return _loc2_;
    }

    override public function apply():void {
        var _loc2_:GeoSceneObject = null;
        var _loc3_:UserAllianceHelpData = null;
        var _loc4_:int = 0;
        var _loc5_:UserAllianceHelpRequest = null;
        var _loc1_:int = 0;
        while (_loc1_ < UserManager.user.gameData.sector.sectorScene.sceneObjects.length) {
            _loc2_ = UserManager.user.gameData.sector.sectorScene.sceneObjects[_loc1_] as GeoSceneObject;
            if (_loc2_.id == this.buildingId) {
                if (_loc2_.constructionInfo.constructionFinishTime == null || _loc2_.constructionInfo.constructionStartTime == null) {
                    return;
                }
                _loc2_.constructionInfo.constructionFinishTime = new Date(_loc2_.constructionInfo.constructionFinishTime.time - this.boostSeconds * 1000);
                _loc2_.constructionInfo.constructionStartTime = new Date(_loc2_.constructionInfo.constructionStartTime.time - this.boostSeconds * 1000);
                _loc3_ = UserManager.user.gameData.allianceData.allianceHelpData;
                _loc4_ = 0;
                while (_loc4_ < _loc3_.requests.length) {
                    _loc5_ = _loc3_.requests[_loc4_];
                    if (_loc5_.buildingInfo && _loc5_.buildingInfo.buildingId == this.buildingId) {
                        _loc5_.respondedUserIds.push(this.originUserId);
                        _loc5_.responsesCount++;
                        JournalAutoRefreshManager.events.dispatchEvent(new Event(JournalAutoRefreshManager.ALLIANCE_HELP_REQUEST_RESPONSE));
                        _loc5_.validTill = _loc5_.responsesCount < this.maxMembersAbleToRespond ? _loc2_.constructionInfo.constructionFinishTime : time;
                        if (_loc5_.responsesCount >= this.maxMembersAbleToRespond) {
                            _loc3_.requests.splice(_loc4_, 1);
                            JournalAutoRefreshManager.events.dispatchEvent(new Event(JournalAutoRefreshManager.ALLIANCE_HELP_REQUEST_MAX_RESPONSES));
                        }
                        break;
                    }
                    _loc4_++;
                }
                break;
            }
            _loc1_++;
        }
    }
}
}
