package model.logic.chats {
import common.ArrayCustom;
import common.GameType;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.Dictionary;

import model.data.alliances.AllianceMemberRankId;
import model.data.alliances.chat.AllianceChatRoomData;
import model.data.alliances.chat.AllianceChatRoomId;
import model.data.alliances.membership.AllianceMember;
import model.data.users.alliances.UserAllianceData;
import model.data.users.misc.UserChatSettingsTypeId;
import model.logic.AllianceManager;
import model.logic.ServerTimeManager;
import model.logic.UserManager;
import model.logic.autoRefresh.AutoRefreshEvent;
import model.logic.autoRefresh.AutoRefreshManager;
import model.logic.chats.notification.INotificationHelper;
import model.logic.chats.notification.MainNotificationType;
import model.logic.chats.notification.NotificationHandlerFactory;
import model.logic.commands.chat.GetBanInfoCmd;
import model.logic.commands.user.UserRefreshCmd;

public class ChatManager {

    public static const CLASS_NAME:String = "Chat";

    public static const CLASS_NAME_VIP:String = "VipChat";

    public static const EVENT_UPDATED:String = CLASS_NAME + "Updated";

    public static const EVENT_UPDATED_VIP:String = CLASS_NAME_VIP + "Updated";

    public static const RUSSIAN:String = "ru-RU";

    public static const ENGLISH:String = "en-US";

    public static const GERMAN:String = "de-DE";

    public static const SPANISH:String = "es-ES";

    public static const FRENCH:String = "fr-FR";

    public static const ITALIAN:String = "it-IT";

    public static const UKRAINIAN:String = "uk-UA";

    public static const REGIONAL_ROOM_PREFIX:String = "r.";

    public static var _usersPerRadioRoom:int;

    private static var _maxMessagesPerRoom:int;

    private static var _sessionId:Number = 0;

    private static var _knownMessageId:Number = 0;

    private static var rooms:ArrayCustom = new ArrayCustom();

    private static var updatedRoomIds:Array = new Array();

    public static var administrativeBanRoomsInfo:Dictionary = new Dictionary();

    private static var _events:EventDispatcher = new EventDispatcher();


    public function ChatManager() {
        super();
    }

    public static function getRoom(param1:String):ChatRoom {
        var _loc2_:ChatRoom = null;
        for each(_loc2_ in ChatManager.rooms) {
            if (_loc2_.id == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public static function isUpdatedRoom(param1:String):Boolean {
        return updatedRoomIds.indexOf(param1) >= 0;
    }

    public static function getRadioRoomId():String {
        return "m." + (int(UserManager.user.id / _usersPerRadioRoom) + 1);
    }

    public static function getUserUpdateRoomId():String {
        return "u." + UserManager.user.id;
    }

    public static function getAllianceCityRoomId():String {
        var _loc1_:UserAllianceData = UserManager.user.gameData.allianceData;
        return _loc1_ == null || isNaN(_loc1_.allianceId) || _loc1_.rankId == AllianceMemberRankId.INVITED ? null : "an." + _loc1_.allianceId;
    }

    public static function getVipRoomId():String {
        return "v." + UserManager.user.id;
    }

    public static function getAllianceRoomId():String {
        var _loc1_:UserAllianceData = UserManager.user.gameData.allianceData;
        return _loc1_ == null || isNaN(_loc1_.allianceId) || _loc1_.rankId == AllianceMemberRankId.INVITED ? null : "a." + _loc1_.allianceId;
    }

    public static function getMainAllianceRoomPrefix():String {
        var _loc1_:UserAllianceData = UserManager.user.gameData.allianceData;
        return _loc1_ == null || isNaN(_loc1_.allianceId) || _loc1_.rankId == AllianceMemberRankId.INVITED ? null : "z.Main." + _loc1_.allianceId;
    }

    public static function getTrustedAllianceRoomPrefix():String {
        var _loc1_:UserAllianceData = UserManager.user.gameData.allianceData;
        return _loc1_ == null || isNaN(_loc1_.allianceId) || _loc1_.rankId == AllianceMemberRankId.INVITED ? null : "z.Trusted." + _loc1_.allianceId;
    }

    public static function getAllRegionalRoomPrefix():Array {
        var _loc1_:Array = [];
        _loc1_.push(REGIONAL_ROOM_PREFIX + RUSSIAN + "." + (int(UserManager.user.id / _usersPerRadioRoom) + 1));
        _loc1_.push(REGIONAL_ROOM_PREFIX + ENGLISH + "." + (int(UserManager.user.id / _usersPerRadioRoom) + 1));
        _loc1_.push(REGIONAL_ROOM_PREFIX + GERMAN + "." + (int(UserManager.user.id / _usersPerRadioRoom) + 1));
        _loc1_.push(REGIONAL_ROOM_PREFIX + SPANISH + "." + (int(UserManager.user.id / _usersPerRadioRoom) + 1));
        _loc1_.push(REGIONAL_ROOM_PREFIX + FRENCH + "." + (int(UserManager.user.id / _usersPerRadioRoom) + 1));
        _loc1_.push(REGIONAL_ROOM_PREFIX + ITALIAN + "." + (int(UserManager.user.id / _usersPerRadioRoom) + 1));
        _loc1_.push(REGIONAL_ROOM_PREFIX + UKRAINIAN + "." + (int(UserManager.user.id / _usersPerRadioRoom) + 1));
        return _loc1_;
    }

    public static function getRegionalRoomPrefix():String {
        var _loc1_:String = UserManager.user.gameData.userChatSettings.selectedRegionalChat;
        _loc1_ = _loc1_.replace("_", "-");
        return "r." + _loc1_ + "." + (int(UserManager.user.id / _usersPerRadioRoom) + 1);
    }

    public static function isCreateMainAllianceRoom():Boolean {
        var _loc3_:AllianceChatRoomData = null;
        var _loc1_:Boolean = false;
        var _loc2_:UserAllianceData = UserManager.user.gameData.allianceData;
        if (_loc2_) {
            _loc3_ = _loc2_.rooms[AllianceChatRoomId.Main];
            if (_loc3_ && _loc3_.allowedRanksDictionary[_loc2_.rankId] == true) {
                _loc1_ = true;
            }
        }
        return _loc1_;
    }

    public static function isCreateTrustedAllianceRoom():Boolean {
        var _loc3_:AllianceChatRoomData = null;
        var _loc1_:Boolean = false;
        var _loc2_:UserAllianceData = UserManager.user.gameData.allianceData;
        if (_loc2_) {
            _loc3_ = _loc2_.rooms[AllianceChatRoomId.Trusted];
            if (_loc3_ && _loc3_.allowedRanksDictionary[_loc2_.rankId] != null) {
                _loc1_ = true;
            }
        }
        return _loc1_;
    }

    public static function haveUserBan(param1:int, param2:int):Date {
        var _loc5_:AllianceChatRoomData = null;
        var _loc6_:int = 0;
        var _loc3_:Date = null;
        var _loc4_:UserAllianceData = UserManager.user.gameData.allianceData;
        if (_loc4_) {
            _loc5_ = _loc4_.rooms[param2];
            if (_loc5_ && _loc5_.bannedMembers) {
                _loc6_ = 0;
                while (_loc6_ < _loc5_.bannedMembers.length) {
                    if (_loc5_.bannedMembers[_loc6_].userId == param1) {
                        if (_loc5_.bannedMembers[_loc6_].bannedUntil.time > ServerTimeManager.serverTimeNow.time) {
                            _loc3_ = _loc5_.bannedMembers[_loc6_].bannedUntil;
                        }
                    }
                    _loc6_++;
                }
            }
        }
        return _loc3_;
    }

    public static function getAdminRoomId():String {
        return "n";
    }

    public static function get allianceNewMessagesCount():int {
        var _loc1_:String = getAllianceRoomId();
        if (_loc1_ == null) {
            return 0;
        }
        var _loc2_:ChatRoom = getRoom(_loc1_);
        return _loc2_ == null ? 0 : int(_loc2_.newMessages);
    }

    public static function get radioRoomNewMessagesCount():int {
        var _loc1_:String = getRadioRoomId();
        var _loc2_:ChatRoom = getRoom(_loc1_);
        return _loc2_ == null ? 0 : int(_loc2_.newMessages);
    }

    public static function get vipRoomNewMessagesCount():int {
        var _loc1_:String = getVipRoomId();
        var _loc2_:ChatRoom = getRoom(_loc1_);
        return _loc2_ == null ? 0 : int(_loc2_.newMessages);
    }

    public static function get regionalNewMessagesCount():int {
        var _loc1_:String = getRegionalRoomPrefix();
        if (_loc1_ == null) {
            return 0;
        }
        var _loc2_:ChatRoom = getRoom(_loc1_);
        return _loc2_ == null ? 0 : int(_loc2_.newMessages);
    }

    public static function get allianceMainNewMessagesCount():int {
        var _loc1_:String = getMainAllianceRoomPrefix();
        if (_loc1_ == null) {
            return 0;
        }
        var _loc2_:ChatRoom = getRoom(_loc1_);
        return _loc2_ == null ? 0 : int(_loc2_.newMessages);
    }

    public static function get allianceTrustedNewMessagesCount():int {
        var _loc1_:String = getTrustedAllianceRoomPrefix();
        if (_loc1_ == null) {
            return 0;
        }
        var _loc2_:ChatRoom = getRoom(_loc1_);
        return _loc2_ == null ? 0 : int(_loc2_.newMessages);
    }

    public static function updateSettings(param1:Dictionary, param2:Dictionary = null):void {
        var _loc5_:* = undefined;
        var _loc6_:* = undefined;
        var _loc3_:Dictionary = UserManager.user.gameData.userChatSettings.chatSettings;
        var _loc4_:Boolean = false;
        for (_loc5_ in param1) {
            if (_loc3_[_loc5_] != param1[_loc5_]) {
                _loc3_[_loc5_] = param1[_loc5_];
                _loc4_ = true;
            }
            if (param2) {
                _loc6_ = UserChatSettingsTypeId.radioToAlliance(_loc5_);
                if (_loc3_[_loc6_] != param2[_loc5_]) {
                    _loc3_[_loc6_] = param2[_loc5_];
                    _loc4_ = true;
                }
            }
        }
        if (_loc4_) {
            UserManager.user.gameData.settingsChatDirty = true;
            new UserRefreshCmd().execute();
        }
    }

    public static function get events():EventDispatcher {
        if (_events == null) {
            _events = new EventDispatcher();
        }
        return _events;
    }

    public static function initialize(param1:int, param2:int):void {
        _usersPerRadioRoom = param1;
        _maxMessagesPerRoom = param2;
        AutoRefreshManager.events.addEventListener(AutoRefreshManager.EVENT_REFRESH_START, onAutoRefreshStart);
        AutoRefreshManager.events.addEventListener(AutoRefreshManager.EVENT_REFRESH_COMPLETED, onAutoRefreshCompleted);
    }

    private static function onAutoRefreshStart(param1:AutoRefreshEvent):void {
        var _loc8_:Array = null;
        var _loc9_:String = null;
        var _loc10_:String = null;
        var _loc11_:Boolean = false;
        var _loc12_:Boolean = false;
        var _loc2_:String = getRadioRoomId();
        var _loc3_:String = getAllianceRoomId();
        var _loc4_:String = getAllianceCityRoomId();
        var _loc5_:String = getAdminRoomId();
        var _loc6_:String = getVipRoomId();
        var _loc7_:String = getUserUpdateRoomId();
        if (!GameType.isNords) {
            param1.dto.chat = {
                "s": _sessionId,
                "i": _knownMessageId,
                "r": (_loc3_ == null ? [_loc2_, _loc5_, _loc6_, _loc7_] : [_loc2_, _loc3_, _loc5_, _loc6_, _loc7_, _loc4_])
            };
        }
        else {
            _loc8_ = getAllRegionalRoomPrefix();
            _loc9_ = getMainAllianceRoomPrefix();
            _loc10_ = getTrustedAllianceRoomPrefix();
            _loc11_ = isCreateMainAllianceRoom();
            _loc12_ = isCreateTrustedAllianceRoom();
            param1.dto.chat = {
                "s": _sessionId,
                "i": _knownMessageId,
                "r": (_loc3_ == null ? [_loc2_, _loc5_].concat(_loc8_) : [_loc2_, _loc3_, _loc4_, _loc9_, _loc10_, _loc5_].concat(_loc8_))
            };
        }
    }

    private static function onAutoRefreshCompleted(param1:AutoRefreshEvent):void {
        var _loc3_:ArrayCustom = null;
        var _loc4_:ChatRoom = null;
        var _loc5_:ChatMessage = null;
        var _loc6_:int = 0;
        var _loc7_:ChatRoom = null;
        var _loc8_:ChatRoom = null;
        var _loc9_:Boolean = false;
        var _loc10_:Number = NaN;
        var _loc11_:Boolean = false;
        var _loc12_:Array = null;
        var _loc13_:int = 0;
        var _loc14_:String = null;
        var _loc15_:ChatRoom = null;
        var _loc16_:ChatMessage = null;
        var _loc2_:* = param1.dto;
        if (_loc2_.chat == null) {
            return;
        }
        if (_sessionId != _loc2_.chat.s) {
            rooms.removeAll();
        }
        _sessionId = _loc2_.chat.s;
        _knownMessageId = _loc2_.chat.i;
        updatedRoomIds = new Array();
        if (_loc2_.chat.r != null) {
            _loc3_ = ChatRoom.fromDtos(_loc2_.chat.r);
            for each(_loc4_ in _loc3_) {
                updatedRoomIds.push(_loc4_.id);
                if (_loc4_.id == getAdminRoomId()) {
                    if (!GameType.isNords) {
                        addAdminMessages(getRadioRoomId(), _loc4_);
                        addAdminMessages(getAllianceRoomId(), _loc4_);
                    }
                    else {
                        addAdminMessages(getRadioRoomId(), _loc4_);
                        addAdminMessages(getAllianceRoomId(), _loc4_);
                        addAdminMessages(getMainAllianceRoomPrefix(), _loc4_);
                        addAdminMessages(getTrustedAllianceRoomPrefix(), _loc4_);
                        _loc12_ = getAllRegionalRoomPrefix();
                        _loc13_ = 0;
                        while (_loc13_ < _loc12_.length) {
                            addAdminMessages(_loc12_[_loc13_], _loc4_);
                            _loc13_++;
                        }
                    }
                }
                if (_loc4_.id == getAllianceCityRoomId()) {
                    sendUpdateNotification(MainNotificationType.ALLIANCE_CITY, _loc4_.messages);
                    _loc14_ = getAllianceRoomId();
                    for each(_loc15_ in rooms) {
                        if (_loc15_.id == _loc14_) {
                            _loc15_.messages.addAll(ChatMessageHelper.convertNotificationsToMessages(_loc4_.messages));
                            break;
                        }
                    }
                }
                _loc6_ = 0;
                while (_loc6_ < _loc4_.messages.length) {
                    _loc16_ = _loc4_.messages[_loc6_];
                    if (UserManager.user.gameData.messageData.isInBlackList(_loc16_.userId)) {
                        _loc4_.messages.removeItemAt(_loc6_);
                        _loc6_--;
                    }
                    _loc6_++;
                }
                _loc7_ = null;
                for each(_loc8_ in rooms) {
                    if (_loc8_.id == _loc4_.id) {
                        _loc7_ = _loc8_;
                        break;
                    }
                }
                if (_loc7_ != null && _loc9_ == false && _loc4_.roomData != null) {
                    _loc7_.roomData = _loc4_.roomData;
                    _loc7_.roomDataMessageId = _loc4_.roomDataMessageId;
                }
                _loc9_ = false;
                if (_loc7_ != null) {
                    _loc7_.messages.addAll(_loc4_.messages);
                    deleteOldMessage(_loc7_);
                }
                else {
                    rooms.addItem(_loc4_);
                    _loc7_ = _loc4_;
                    _loc9_ = true;
                    deleteOldMessage(_loc7_);
                }
                if (_loc7_ != null && _loc9_ == false && _loc4_.roomData != null) {
                    _loc7_.roomData = _loc4_.roomData;
                    _loc7_.roomDataMessageId = _loc4_.roomDataMessageId;
                }
                if (!_loc9_) {
                    if (!GameType.isNords) {
                        for each(_loc5_ in _loc4_.messages) {
                            if (_loc5_.userId != UserManager.user.id) {
                                _loc7_.newMessages++;
                            }
                        }
                    }
                    else {
                        for each(_loc5_ in _loc4_.messages) {
                            if (_loc5_.userId != UserManager.user.id && _loc7_.newMessages < _maxMessagesPerRoom) {
                                _loc7_.newMessages++;
                            }
                        }
                    }
                }
                _loc10_ = UserManager.user.gameData.vipSupportData.lastVipChatMessageId;
                _loc11_ = UserManager.user.gameData.vipSupportData.joinedProgram;
                if (_loc9_ && _loc10_ && _loc11_ && _loc7_.messages.length > 0 && _loc10_ != _loc7_.messages[_loc7_.messages.length - 1].id) {
                    if (!GameType.isNords) {
                        for each(_loc5_ in _loc7_.messages) {
                            if (_loc5_.userId != UserManager.user.id && _loc5_.id > _loc10_) {
                                _loc7_.newMessages++;
                            }
                        }
                    }
                    else {
                        for each(_loc5_ in _loc7_.messages && _loc7_.newMessages < _maxMessagesPerRoom) {
                            if (_loc5_.userId != UserManager.user.id && _loc5_.id > _loc10_) {
                                _loc7_.newMessages++;
                            }
                        }
                    }
                }
            }
            events.dispatchEvent(new Event(EVENT_UPDATED));
        }
    }

    private static function sendUpdateNotification(param1:int, param2:ArrayCustom):void {
        var _loc3_:ChatMessage = null;
        var _loc4_:INotificationHelper = null;
        for each(_loc3_ in param2) {
            _loc4_ = NotificationHandlerFactory.getHandler(param1);
            _loc4_.findHandler(_loc3_);
            _loc4_.execute();
        }
    }

    private static function deleteOldMessage(param1:ChatRoom):void {
        var _loc2_:int = 0;
        if (GameType.isNords && param1.messages) {
            _loc2_ = param1.messages.length - 1;
            while (_loc2_ >= 0) {
                if (param1.messages[_loc2_].clearRoom == true) {
                    break;
                }
                _loc2_--;
            }
            while (_loc2_ >= 0) {
                if (!param1.messages[_loc2_].administrativeMessage) {
                    param1.messages.splice(_loc2_, 1);
                }
                _loc2_--;
            }
        }
        else if (!GameType.isNords) {
            shrinkMessages(param1);
        }
    }

    private static function shrinkMessages(param1:ChatRoom):void {
        var _loc2_:int = param1.messages.length - 1;
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        while (_loc2_ >= 0) {
            if (param1.messages[_loc2_].administrativeMessage) {
                _loc4_++;
            }
            else {
                _loc3_++;
            }
            _loc2_--;
        }
        var _loc5_:int = _loc4_ - _maxMessagesPerRoom;
        var _loc6_:int = _loc3_ - _maxMessagesPerRoom;
        while (_loc6_ > 0 || _loc5_ > 0) {
            _loc2_++;
            if (param1.messages[_loc2_].administrativeMessage && _loc5_ > 0) {
                param1.messages.removeItemAt(_loc2_);
                _loc5_--;
                _loc2_--;
            }
            else if (!param1.messages[_loc2_].administrativeMessage && _loc6_ > 0) {
                param1.messages.removeItemAt(_loc2_);
                _loc6_--;
                _loc2_--;
            }
        }
    }

    private static function addAdminMessages(param1:String, param2:ChatRoom):void {
        var _loc4_:ChatMessage = null;
        if (!param1) {
            return;
        }
        var _loc3_:ChatRoom = getRoom(param1);
        if (!_loc3_) {
            _loc3_ = new ChatRoom();
            _loc3_.id = param1;
            _loc3_.messages = new ArrayCustom();
            ChatManager.rooms.addItem(_loc3_);
        }
        if (_loc3_.messages.length) {
            addApplySort(_loc3_.messages, param2.messages, param1);
        }
        else {
            for each(_loc4_ in param2.messages) {
                if (isShow(_loc4_.administrativeMessage.messageType, param1)) {
                    _loc3_.messages.addItem(_loc4_);
                }
            }
        }
        shrinkMessages(_loc3_);
    }

    private static function addApplySort(param1:ArrayCustom, param2:ArrayCustom, param3:String):void {
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:ChatMessage = null;
        var _loc8_:ChatMessage = null;
        var _loc9_:int = 0;
        var _loc7_:Boolean = true;
        _loc5_ = param2.length - 1;
        while (_loc5_ >= 0) {
            _loc6_ = param2[_loc5_] as ChatMessage;
            if (isShow(_loc6_.administrativeMessage.messageType, param3)) {
                _loc4_ = param1.length - 1;
                _loc7_ = true;
                _loc9_ = _loc4_;
                while (_loc9_ >= 0) {
                    _loc8_ = param1[_loc9_] as ChatMessage;
                    _loc4_ = _loc9_;
                    if (_loc6_.time >= _loc8_.time) {
                        _loc7_ = false;
                        break;
                    }
                    _loc9_--;
                }
                param1.addItemAt(_loc6_, _loc4_ + (!!_loc7_ ? 0 : 1));
            }
            _loc5_--;
        }
    }

    private static function isShow(param1:int, param2:String):Boolean {
        var _loc3_:Boolean = false;
        var _loc4_:Dictionary = null;
        if (GameType.isNords) {
            switch (param1) {
                case ChatMessageType.RESOURCE_MINES_ADDED:
                case ChatMessageType.ARTIFACT_MINES_ADDED:
                    _loc3_ = true;
                    break;
                case ChatMessageType.TOWERS_ADDED:
                    _loc3_ = true;
                    break;
                case ChatMessageType.LOYALTY_SPECIAL_DAY_ACHIEVED:
                    _loc3_ = true;
                    break;
                case ChatMessageType.USER_MESSAGE:
                    _loc3_ = true;
            }
        }
        else {
            _loc4_ = UserManager.user.gameData.userChatSettings.chatSettings;
            switch (param1) {
                case ChatMessageType.ENEMY_REQUEST_ACCEPTED:
                case ChatMessageType.WAR_REQUEST_ACCEPT:
                case ChatMessageType.WAR_REQUEST_DECLINED:
                case ChatMessageType.WAR_CANCELED:
                case ChatMessageType.CHALLENGE_REQUEST_ACCEPT:
                case ChatMessageType.CHALLENGE_REQUEST_DECLINED:
                case ChatMessageType.CHALLENGE_FINISHED:
                    if (param2 == getRadioRoomId()) {
                        _loc3_ = _loc4_[UserChatSettingsTypeId.RADIO_DIPLOMATIC_RELATION];
                    }
                    else {
                        _loc3_ = _loc4_[UserChatSettingsTypeId.ALLIANCE_DIPLOMATIC_RELATION];
                    }
                    break;
                case ChatMessageType.TOWER_OCCUPIED:
                case ChatMessageType.TOWER_UPGRADED:
                    if (param2 == getRadioRoomId()) {
                        _loc3_ = _loc4_[UserChatSettingsTypeId.RADIO_TOWER_ACTION];
                    }
                    else {
                        _loc3_ = _loc4_[UserChatSettingsTypeId.ALLIANCE_TOWER_ACTION];
                    }
                    break;
                case ChatMessageType.ALLIANCE_ACHIEVEMENT_RECEIVED:
                    if (param2 == getRadioRoomId()) {
                        _loc3_ = _loc4_[UserChatSettingsTypeId.RADIO_ACHIEVEMENTS];
                    }
                    else {
                        _loc3_ = _loc4_[UserChatSettingsTypeId.ALLIANCE_ACHIEVEMENTS];
                    }
                    break;
                case ChatMessageType.RESOURCE_MINES_ADDED:
                case ChatMessageType.ARTIFACT_MINES_ADDED:
                    if (param2 == getRadioRoomId()) {
                        _loc3_ = _loc4_[UserChatSettingsTypeId.RADIO_MINES_ADDED];
                    }
                    else {
                        _loc3_ = _loc4_[UserChatSettingsTypeId.ALLIANCE_MINES_ADDED];
                    }
                    break;
                case ChatMessageType.TOWERS_ADDED:
                    if (param2 == getRadioRoomId()) {
                        _loc3_ = _loc4_[UserChatSettingsTypeId.RADIO_TOWER_ADDED];
                    }
                    else {
                        _loc3_ = _loc4_[UserChatSettingsTypeId.ALLIANCE_TOWER_ADDED];
                    }
                    break;
                case ChatMessageType.WEEKLY_RATING_UPDATED:
                    if (param2 == getRadioRoomId()) {
                        _loc3_ = _loc4_[UserChatSettingsTypeId.RADIO_WEEKLY_RATING];
                    }
                    else {
                        _loc3_ = _loc4_[UserChatSettingsTypeId.ALLIANCE_WEEKLY_RATING];
                    }
                    break;
                case ChatMessageType.PVP_RATING_WINNER:
                    _loc3_ = true;
                    break;
                case ChatMessageType.LOYALTY_SPECIAL_DAY_ACHIEVED:
                    _loc3_ = true;
                    break;
                case ChatMessageType.USER_MESSAGE:
                    _loc3_ = true;
                    break;
                case ChatMessageType.ALLIANCE_TOURNAMENT_EFFECT_APPLIED:
                case ChatMessageType.ALLIANCE_TOURNAMENT_EFFECT_SENT:
                    _loc3_ = true;
            }
        }
        return _loc3_;
    }

    public static function getRoomsPrefix():Array {
        var _loc9_:Array = null;
        var _loc1_:String = getRadioRoomId();
        var _loc2_:String = getAllianceRoomId();
        var _loc3_:String = getVipRoomId();
        var _loc4_:Array = getAllRegionalRoomPrefix();
        var _loc5_:String = getMainAllianceRoomPrefix();
        var _loc6_:String = getTrustedAllianceRoomPrefix();
        var _loc7_:Boolean = isCreateMainAllianceRoom();
        var _loc8_:Boolean = isCreateTrustedAllianceRoom();
        _loc9_ = _loc2_ == null ? [_loc1_].concat(_loc4_) : [_loc1_, _loc2_, _loc5_, _loc6_].concat(_loc4_);
        return _loc9_;
    }

    public static function haveUserAdministrativeBan(param1:String):BanRoomInfo {
        var _loc2_:BanRoomInfo = null;
        if (administrativeBanRoomsInfo[param1] && administrativeBanRoomsInfo[param1].userBanned) {
            if (!administrativeBanRoomsInfo[param1].bannedUntil || administrativeBanRoomsInfo[param1].bannedUntil.time > ServerTimeManager.serverTimeNow.time) {
                _loc2_ = administrativeBanRoomsInfo[param1];
            }
        }
        return _loc2_;
    }

    public static function howManyUsersAreChatting(param1:int):int {
        var _loc4_:AllianceChatRoomData = null;
        var _loc5_:AllianceMember = null;
        var _loc2_:UserAllianceData = UserManager.user.gameData.allianceData;
        if (!_loc2_ || !AllianceManager.currentAlliance) {
            return 0;
        }
        var _loc3_:int = 0;
        if (_loc2_.rooms) {
            _loc4_ = _loc2_.rooms[param1];
            if (_loc4_) {
                for each(_loc5_ in AllianceManager.currentAlliance.gameData.membershipData.members) {
                    if (_loc4_.allowedRanksDictionary[_loc5_.rankId] == true) {
                        _loc3_++;
                    }
                }
            }
        }
        return _loc3_;
    }

    public static function GetBanRoomInfo(param1:Function = null):void {
        var onResult:Function = param1;
        var roomIds:Array = getRoomsPrefix();
        new GetBanInfoCmd(roomIds).ifResult(function ():void {
            if (onResult != null) {
                onResult();
            }
        }).execute();
    }
}
}
