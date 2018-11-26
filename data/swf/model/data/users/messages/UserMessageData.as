package model.data.users.messages {
import common.ArrayCustom;

import flash.utils.Dictionary;

import gameObjects.observableObject.ObservableObject;

import model.logic.MessageManager;

public class UserMessageData extends ObservableObject {

    public static const CLASS_NAME:String = "MessageCenter";

    public static const MESSAGES_CHANGED:String = CLASS_NAME + "MessagesChanged";

    public static const EXTERNAL_PERSONAL_MESSAGES_CHANGED:String = CLASS_NAME + "PersonalExternalMessagesChanged";

    public static const EXTERNAL_ADVISERS_MESSAGES_CHANGED:String = CLASS_NAME + "AdvisersExternalMessagesChanged";

    public static const EXTERNAL_ADVISERS_MESSAGES_LOAD_OLD:String = CLASS_NAME + "ExternalAdvisersMessagesUpdateOld";

    public static const BLACK_LIST_CHANGED:String = CLASS_NAME + "black_list_changed";


    public var nextMessageId:Number;

    public var messagesSentToday:int;

    public var messages:ArrayCustom;

    public var battleReportOwnSectorLossesThreshold:int;

    public var battleReportTowerLossesThreshold:int;

    public var battleReportReinforcementLossesThreshold:int;

    public var battleReportMyAllianceCityLossesThreshold:int;

    public var ignoreSuccessIntelligenceDefense:Boolean;

    public var ignoreSuccessSectorDefence:Boolean;

    public var ignoreSuccessTowerGuardDefense:Boolean;

    public var diplomaticAdviserBattleReportsTypes:ArrayCustom;

    public var denyLowLevelUserSendMessage:Boolean;

    public var blackList:ArrayCustom;

    public var messagesCountByGroup:Dictionary;

    public var addedByClientCount:int = 0;

    public var clientMessageData:ClientMessagesDataByTypes;

    public var knownUserConversation:Dictionary;

    public var knownAllianceConversation:Dictionary;

    public var knownBattleReports:Array;

    public var knownDiplomaticMessages:Array;

    public var knownScientistMessages:Array;

    public var knownTradeMessages:Array;

    public var addedByClientMessages:Dictionary;

    public var messagesDirty:Boolean = true;

    public var blackListChanged:Boolean;

    public var personalExternalMessagesDirty:Boolean = true;

    public var advisersExternalMessagesDirty:Boolean = true;

    public var advisersExternalMessagesDirtyLoadOld:Boolean = true;

    public function UserMessageData() {
        this.blackList = new ArrayCustom();
        this.knownUserConversation = new Dictionary();
        this.knownAllianceConversation = new Dictionary();
        this.knownBattleReports = [];
        this.knownDiplomaticMessages = [];
        this.knownScientistMessages = [];
        this.knownTradeMessages = [];
        super();
    }

    public static function fromDto(param1:*):UserMessageData {
        var _loc3_:Number = NaN;
        var _loc4_:int = 0;
        var _loc2_:UserMessageData = new UserMessageData();
        _loc2_.nextMessageId = param1.i;
        _loc2_.messagesSentToday = int(param1.s);
        _loc2_.messages = MessageManager.removeAndReadIfNeed(Message.fromDtos(param1.m));
        _loc2_.battleReportOwnSectorLossesThreshold = param1.l == null ? -1 : int(param1.l);
        _loc2_.battleReportTowerLossesThreshold = param1.tl == null ? -1 : int(param1.tl);
        _loc2_.battleReportReinforcementLossesThreshold = param1.rl == null ? -1 : int(param1.rl);
        _loc2_.battleReportMyAllianceCityLossesThreshold = param1.al == null ? -1 : int(param1.al);
        _loc2_.ignoreSuccessIntelligenceDefense = param1.c;
        _loc2_.ignoreSuccessSectorDefence = param1.f;
        _loc2_.ignoreSuccessTowerGuardDefense = param1.x;
        _loc2_.denyLowLevelUserSendMessage = param1.v;
        if (param1.d) {
            _loc2_.diplomaticAdviserBattleReportsTypes = new ArrayCustom();
            for each(_loc4_ in param1.d) {
                _loc2_.diplomaticAdviserBattleReportsTypes.addItem(_loc4_);
            }
        }
        else {
            _loc2_.diplomaticAdviserBattleReportsTypes = null;
        }
        for each(_loc3_ in param1.b) {
            _loc2_.blackList.addItem(_loc3_);
        }
        if (!MessageManager.waitWhenMessagesIsReadOnServer) {
            _loc2_.messagesCountByGroup = param1.g == null ? new Dictionary() : GroupMessages.fromDtos(param1.g);
        }
        return _loc2_;
    }

    public function hasPersonalChanges(param1:Dictionary):Boolean {
        if (param1 == null) {
            return false;
        }
        if (this.messagesCountByGroup == null || this.messagesCountByGroup[AdviserTypeId.NONE] == null || param1[AdviserTypeId.NONE] == null) {
            return true;
        }
        return this.messagesCountByGroup[AdviserTypeId.NONE].count != param1[AdviserTypeId.NONE].count || this.messagesCountByGroup[AdviserTypeId.NONE].unreadCount != param1[AdviserTypeId.NONE].unreadCount;
    }

    public function hasAdviserChanges(param1:Dictionary):Boolean {
        if (param1 == null) {
            return false;
        }
        var _loc2_:int = 1;
        while (_loc2_ < 5) {
            if (this.messagesCountByGroup == null || this.messagesCountByGroup[_loc2_] == null || param1[_loc2_] == null) {
                return true;
            }
            if (this.messagesCountByGroup[_loc2_].count != param1[_loc2_].count || this.messagesCountByGroup[_loc2_].unreadCount != param1[_loc2_].unreadCount) {
                return true;
            }
            _loc2_++;
        }
        return false;
    }

    public function dispatchEvents():void {
        if (this.messagesDirty) {
            this.messagesDirty = false;
            dispatchEvent(MESSAGES_CHANGED);
        }
        if (this.personalExternalMessagesDirty) {
            this.personalExternalMessagesDirty = false;
            dispatchEvent(EXTERNAL_PERSONAL_MESSAGES_CHANGED);
        }
        if (this.advisersExternalMessagesDirty) {
            this.advisersExternalMessagesDirty = false;
            dispatchEvent(EXTERNAL_ADVISERS_MESSAGES_CHANGED);
        }
        if (this.advisersExternalMessagesDirtyLoadOld) {
            this.advisersExternalMessagesDirtyLoadOld = false;
            dispatchEvent(EXTERNAL_ADVISERS_MESSAGES_LOAD_OLD);
        }
        if (this.blackListChanged) {
            this.blackListChanged = false;
            dispatchEvent(BLACK_LIST_CHANGED);
        }
    }

    public function isInBlackList(param1:Number):Boolean {
        return this.blackList.indexOf(param1) > -1;
    }
}
}
