package model.logic.journal {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.Dictionary;

import model.logic.UserManager;
import model.logic.autoRefresh.AutoRefreshEvent;
import model.logic.autoRefresh.AutoRefreshManager;
import model.logic.journal.events.JUEventAllianceHelpApproveUserRequest;
import model.logic.journal.events.JUEventAllianceHelpConfirmResources;
import model.logic.journal.events.JUEventAllianceHelpRejectUserRequest;
import model.logic.journal.events.JUEventAllianceHelpRemoveRequest;
import model.logic.journal.events.JUEventAllianceHelpRespondAttackTarget;
import model.logic.journal.events.JUEventAllianceHelpRespondBuildingTarget;
import model.logic.journal.events.JUEventAllianceHelpUpdateResponsesGiven;

public class JournalAutoRefreshManager {

    public static const ALLIANCE_HELP_CHANGED:String = "AllianceHelpChanged";

    public static const ALLIANCE_HELP_REQUEST_EXPIRED:String = "AllianceHelpUserRequestExpired";

    public static const ALLIANCE_HELP_REQUEST_RESPONSE:String = "AllianceHelpUserRequestResponse";

    public static const ALLIANCE_HELP_REQUEST_MAX_RESOURCES_RESPONSE:String = "AllianceHelpMaxResourcesRequestResponse";

    public static const ALLIANCE_HELP_REQUEST_MAX_RESPONSES:String = "AllianceHelpMaxRequestResponses";

    public static const ALLIANCE_HELP_REQUEST_TOWER_ATTACK_REJECTED:String = "AllianceHelpTowerRequestRejected";

    public static const ALLIANCE_HELP_REQUEST_WAS_REJECTED:String = "AllianceHelpRequestRejected";

    public static var fromDtoHandlers:Dictionary = new Dictionary();

    public static var lastClientRecordId:Number = 0;

    private static var _events:EventDispatcher = new EventDispatcher();


    public function JournalAutoRefreshManager() {
        super();
    }

    public static function initialize(param1:Number):void {
        registerJournalEvents();
        lastClientRecordId = param1;
        AutoRefreshManager.events.addEventListener(AutoRefreshManager.EVENT_REFRESH_START, onAutoRefreshStart);
        AutoRefreshManager.events.addEventListener(AutoRefreshManager.EVENT_REFRESH_COMPLETED, onAutoRefreshCompleted);
    }

    public static function registerJournalEvents():void {
        fromDtoHandlers[JournalEventIds.AllianceHelpApproveUserRequest] = JUEventAllianceHelpApproveUserRequest.fromDto;
        fromDtoHandlers[JournalEventIds.AllianceHelpRejectUserRequest] = JUEventAllianceHelpRejectUserRequest.fromDto;
        fromDtoHandlers[JournalEventIds.AllianceHelpRespondAttackTarget] = JUEventAllianceHelpRespondAttackTarget.fromDto;
        fromDtoHandlers[JournalEventIds.AllianceHelpRespondBuildingTarget] = JUEventAllianceHelpRespondBuildingTarget.fromDto;
        fromDtoHandlers[JournalEventIds.AllianceHelpConfirmResources] = JUEventAllianceHelpConfirmResources.fromDto;
        fromDtoHandlers[JournalEventIds.AllianceHelpUpdateResponsesGiven] = JUEventAllianceHelpUpdateResponsesGiven.fromDto;
        fromDtoHandlers[JournalEventIds.AllianceHelpRemoveUserRequest] = JUEventAllianceHelpRemoveRequest.fromDto;
    }

    private static function onAutoRefreshStart(param1:AutoRefreshEvent):void {
        param1.dto.journal = {"i": lastClientRecordId};
    }

    private static function onAutoRefreshCompleted(param1:AutoRefreshEvent):void {
        var _loc3_:* = undefined;
        var _loc4_:IJournalRecord = null;
        var _loc5_:Function = null;
        var _loc6_:IJEventUser = null;
        var _loc2_:* = param1.dto;
        if (_loc2_.journal == null || _loc2_.journal.r == null) {
            return;
        }
        for each(_loc3_ in _loc2_.journal.r) {
            _loc4_ = JournalRecord.fromDto(_loc3_);
            if (!(_loc4_.clientRecordId < lastClientRecordId || _loc4_.revision > 0 && _loc4_.revision < UserManager.user.gameData.revision)) {
                _loc5_ = fromDtoHandlers[_loc4_.eventTypeId] as Function;
                _loc6_ = _loc5_(_loc4_.eventData);
                lastClientRecordId = _loc4_.clientRecordId;
                _loc6_.apply();
            }
        }
        events.dispatchEvent(new Event(ALLIANCE_HELP_CHANGED));
    }

    public static function get events():EventDispatcher {
        if (_events == null) {
            _events = new EventDispatcher();
        }
        return _events;
    }
}
}
