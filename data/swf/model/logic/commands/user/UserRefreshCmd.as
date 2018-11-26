package model.logic.commands.user {
import common.ArrayCustom;
import common.GameType;

import configs.Global;

import flash.utils.Dictionary;
import flash.utils.getTimer;

import model.data.Resources;
import model.data.UserGameData;
import model.data.discountOffers.OfferCountPair;
import model.data.normalization.Normalizer;
import model.data.users.UserNote;
import model.data.users.achievements.Achievement;
import model.data.users.achievements.AchievementKindId;
import model.data.users.messages.GlobalMessage;
import model.data.users.messages.GroupMessages;
import model.data.users.messages.Message;
import model.data.users.misc.FavouriteTower;
import model.data.users.misc.FavouriteUser;
import model.data.users.misc.UserTreasureData;
import model.logic.AchievementManager;
import model.logic.AllianceNoteManager;
import model.logic.GlobalMessageManager;
import model.logic.MessageManager;
import model.logic.ServerTimeManager;
import model.logic.UserManager;
import model.logic.UserNormalizationManager;
import model.logic.UserNoteManager;
import model.logic.UserStatsManager;
import model.logic.clickers.LocalStorageBuildingClicker;
import model.logic.commands.BaseCmd;
import model.logic.commands.alliances.AllianceGetNotesCmd;
import model.logic.commands.locations.LocationGetNotesCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.discountOffers.UserDiscountOfferManager;
import model.logic.journal.JournalAutoRefreshManager;
import model.logic.quests.completions.QuestCompletionGiftBoxes;
import model.logic.quests.data.Quest;
import model.logic.quests.data.QuestState;
import model.logic.quests.periodicQuests.enums.StatePeriodicQuestId;
import model.logic.quests.periodicQuests.userData.UserPeriodicQuestData;
import model.logic.quests.periodicQuests.userData.UserPeriodicQuestGroupData;
import model.logic.quests.periodicQuests.userData.UserPeriodicQuestStateData;

public class UserRefreshCmd extends BaseCmd {

    public static var RefreshUserNoteTimeoutMs:Number = 60000;

    private static var _lastRefreshKnownUserNotesAtTimerMs:Number = getTimer();

    private static var updateTime:Date;

    public static var countActiveCommands:int = 0;

    private static var favouriteUsers:ArrayCustom = new ArrayCustom();

    private static var favouriteTowers:ArrayCustom = new ArrayCustom();

    private static var achievementsToRead:ArrayCustom = new ArrayCustom();

    private static var boxesToOpen:ArrayCustom = new ArrayCustom();

    public static var questsToRead:ArrayCustom = new ArrayCustom();


    private var _dto;

    public function UserRefreshCmd(param1:Boolean = false) {
        super();
        this._dto = makeRequestDto(null, param1);
    }

    public static function makeRequestDto(param1:* = null, param2:Boolean = false):* {
        var _loc6_:Array = null;
        var _loc7_:Dictionary = null;
        var _loc8_:UserPeriodicQuestData = null;
        var _loc9_:Array = null;
        var _loc10_:* = undefined;
        var _loc11_:Boolean = false;
        var _loc12_:QuestState = null;
        var _loc13_:UserPeriodicQuestGroupData = null;
        var _loc14_:UserPeriodicQuestStateData = null;
        var _loc3_:UserGameData = UserManager.user.gameData;
        var _loc4_:* = {
            "r": _loc3_.revision,
            "t": ServerTimeManager.serverTimeNow.time,
            "u": ServerTimeManager.sessionStartTimeMs,
            "g": ServerTimeManager.sessionInGameTimeMs
        };
        if (updateTime) {
            _loc4_.an = updateTime.time;
        }
        if (UserManager.user.gameData.questData != null) {
            _loc6_ = UserManager.user.gameData.questData.openedStates;
            _loc7_ = UserManager.user.gameData.questData.questById;
            if (_loc6_ != null && _loc7_ != null) {
                _loc9_ = [];
                if (!param2) {
                    for (_loc10_ in _loc7_) {
                        _loc11_ = false;
                        for each(_loc12_ in _loc6_) {
                            if (_loc12_.questId == _loc10_) {
                                _loc11_ = true;
                                break;
                            }
                        }
                        if (_loc11_) {
                            _loc9_.push(_loc10_);
                        }
                    }
                }
            }
            _loc8_ = UserManager.user.gameData.questData.periodicData;
            if (_loc8_ != null && !param2) {
                for each(_loc13_ in _loc8_.groups) {
                    for each(_loc14_ in _loc13_.periodicQuestsData) {
                        if (_loc14_.questStateId == StatePeriodicQuestId.CLOSED) {
                            _loc9_.push(_loc14_.questId);
                        }
                    }
                }
            }
            _loc4_.q = _loc9_;
        }
        if (param1 != null) {
            _loc4_.o = param1;
        }
        var _loc5_:Number = getTimer();
        if (_loc5_ - _lastRefreshKnownUserNotesAtTimerMs > RefreshUserNoteTimeoutMs) {
            _lastRefreshKnownUserNotesAtTimerMs = _loc5_;
            _loc4_.n = {"n": 1};
        }
        MessageManager.populateWithMessageIds(_loc4_);
        if (Global.EXTERNAL_MASSAGES_ENABLED) {
            _loc4_.km = UserManager.user.gameData.messageData.addedByClientCount > 0 ? UserManager.user.gameData.messageData.nextMessageId - UserManager.user.gameData.messageData.addedByClientCount - 1 : UserManager.user.gameData.messageData.nextMessageId - 1;
        }
        GlobalMessageManager.populateWithMessageIds(_loc4_);
        LocalStorageBuildingClicker.populateWithClickedBuildingIds(_loc4_);
        if (achievementsToRead.length > 0) {
            _loc4_.a = [].concat(achievementsToRead);
            achievementsToRead.removeAll();
        }
        if (boxesToOpen.length > 0) {
            _loc4_.b = boxesToOpen;
        }
        if (favouriteUsers.length > 0) {
            _loc4_.k = [].concat(favouriteUsers);
            favouriteUsers.removeAll();
        }
        if (favouriteTowers.length > 0) {
            _loc4_.i = [].concat(favouriteTowers);
            favouriteTowers.removeAll();
        }
        if (questsToRead.length > 0) {
            _loc4_.p = [].concat(questsToRead);
            questsToRead.removeAll();
        }
        if (_loc3_.settingsDirty) {
            _loc4_.s = _loc3_.userGameSettings.toDto();
            _loc3_.settingsDirty = false;
        }
        if (_loc3_.settingsChatDirty) {
            _loc4_.w = _loc3_.userChatSettings.toDto();
            _loc3_.settingsChatDirty = false;
        }
        if (GameType.isNords) {
            _loc4_.w = _loc3_.userChatSettings.toDtoSpecial();
        }
        if (_loc3_.settingsVipDirty) {
            _loc4_.p = _loc3_.vipData.autocompleteDailyQuests;
            _loc3_.settingsVipDirty = false;
        }
        if (_loc3_.settingsMessagesDirty) {
            _loc4_.v = _loc3_.messageData.denyLowLevelUserSendMessage;
            _loc3_.settingsMessagesDirty = false;
        }
        if (_loc3_.vipSupportData.dirtyLastMessage) {
            _loc4_.h = _loc3_.vipSupportData.lastVipChatMessageId;
            _loc3_.vipSupportData.dirtyLastMessage = false;
        }
        if (_loc3_.dragonData && _loc3_.dragonData.dirtyHitsCount) {
            _loc4_.hm = _loc3_.dragonData.hitsMade;
            _loc3_.dragonData.hitsMade = 0;
            _loc3_.dragonData.dirtyHitsCount = false;
        }
        return _loc4_;
    }

    public static function updateUserByResultDto(param1:*, param2:*):Boolean {
        var unknownUserIds:ArrayCustom = null;
        var i:Number = NaN;
        var i2:Number = NaN;
        var knownAllianceIds:ArrayCustom = null;
        var requestBox:* = undefined;
        var j:int = 0;
        var requestClicker:* = undefined;
        var clickers:Array = null;
        var k:int = 0;
        var userNotes:ArrayCustom = null;
        var revision:Number = NaN;
        var normalizationTime:Date = null;
        var pairs:ArrayCustom = null;
        var found:Boolean = false;
        var dto:* = param1;
        var requestDto:* = param2;
        ServerTimeManager.update(dto.t);
        UserNormalizationManager.RefreshTimeoutMs = dto.e;
        if (dto.f != null) {
            RefreshUserNoteTimeoutMs = dto.f;
        }
        if (dto.an != null) {
            updateTime = new Date(dto.an.u);
        }
        var requestBoxes:Array = requestDto.b == null ? null : requestDto.b;
        if (requestBoxes != null && requestBoxes.length > 0) {
            for each(requestBox in requestBoxes) {
                if (requestBox.i != null) {
                    if (boxesToOpen != null) {
                        j = 0;
                        while (j < boxesToOpen.length) {
                            if (boxesToOpen[j].i != null && boxesToOpen[j].i == requestBox.i) {
                                boxesToOpen.removeItemAt(j);
                                break;
                            }
                            j++;
                        }
                        continue;
                    }
                }
            }
        }
        var requestClickers:Array = requestDto.e == null ? null : requestDto.e;
        if (requestClickers != null && requestClickers.length > 0) {
            for each(requestClicker in requestClickers) {
                if (requestClicker.c != null) {
                    clickers = LocalStorageBuildingClicker.clickedBuildingIds;
                    if (clickers != null) {
                        k = 0;
                        while (k < clickers.length) {
                            if (clickers[k].c != null && clickers[k].c == requestClicker.c) {
                                clickers.splice(k, 1);
                                break;
                            }
                            k++;
                        }
                        continue;
                    }
                }
            }
        }
        if (dto.q != null) {
            UserManager.user.gameData.questData.setQuestById(Quest.fromDtos(dto.q));
        }
        if (dto.r != null) {
            if (dto.r.n != null) {
                _lastRefreshKnownUserNotesAtTimerMs = getTimer();
                userNotes = UserNote.fromDtos(dto.r.n);
                UserNoteManager.update(userNotes);
            }
        }
        if (dto.z != null) {
            GlobalMessageManager.updateServiceMessages(GlobalMessage.fromDtos(dto.z));
        }
        if (dto.v == null || dto.v == 0 || UserManager.user.gameData.revision >= dto.v) {
            return true;
        }
        if (dto.g == null) {
            revision = dto.v;
            UserManager.user.gameData.revision = Math.max(UserManager.user.gameData.revision, revision);
            if (dto.j != null && dto.j > 0) {
                JournalAutoRefreshManager.lastClientRecordId = dto.j;
            }
            if (dto.n != null) {
                normalizationTime = new Date(dto.n);
                Normalizer.normalize2(UserManager.user, normalizationTime);
            }
            if (dto.d != null) {
                pairs = OfferCountPair.fromDtos(dto.d);
                UserDiscountOfferManager.updateUserOfferData(pairs);
            }
            if (dto.s != null) {
                MessageManager.waitWhenMessagesIsReadOnServer = false;
                UserManager.user.gameData.messageData.messagesCountByGroup = GroupMessages.fromDtos(dto.s);
                UserManager.user.gameData.messageData.personalExternalMessagesDirty = true;
                UserManager.user.gameData.messageData.advisersExternalMessagesDirty = true;
                if (!dto.m) {
                    UserManager.user.gameData.messageData.dispatchEvents();
                }
            }
            if (dto.m) {
                MessageManager.waitWhenMessagesIsReadOnServer = false;
                addMessages(dto.m);
            }
            return false;
        }
        var newUserGameData:UserGameData = UserGameData.fromDto(dto.g);
        var prevKnownUserIds:Array = UserGameData.getKnownUserIds(UserManager.user);
        var prevKnownAllianceIds:Array = UserGameData.getKnownAllianceIds(UserManager.user);
        var prevKnownLocationIds:Array = UserGameData.getKnownLocationIds(UserManager.user);
        var prevClosedGlobalMissions:int = UserManager.user.gameData.questData.getClosedGlobalMissions();
        UserManager.update(newUserGameData);
        var closedGlobalMissions:int = UserManager.user.gameData.questData.getClosedGlobalMissions();
        UserNoteManager.updateOne(new UserNote(UserManager.user));
        Normalizer.normalize(UserManager.user);
        if (dto.m != null) {
            addMessages(dto.m);
        }
        if (prevClosedGlobalMissions != closedGlobalMissions) {
            new UserRefreshCmd(true).execute();
        }
        var curKnownUserIds:Array = UserGameData.getKnownUserIds(UserManager.user);
        unknownUserIds = new ArrayCustom();
        for each(i in curKnownUserIds) {
            found = false;
            for each(i2 in prevKnownUserIds) {
                if (i == i2) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                unknownUserIds.addItem(i);
            }
        }
        if (unknownUserIds.length > 0) {
            new UserGetNotesCmd(unknownUserIds).ifResult(function ():void {
                var _loc2_:* = undefined;
                var _loc3_:* = undefined;
                var _loc1_:* = new ArrayCustom();
                for each(_loc2_ in unknownUserIds) {
                    _loc3_ = UserNoteManager.getById(_loc2_);
                    if (!isNaN(_loc3_.allianceId) && !AllianceNoteManager.hasNote(_loc3_.allianceId)) {
                        _loc1_.addItem(_loc3_.allianceId);
                    }
                }
                if (_loc1_.length > 0) {
                    new AllianceGetNotesCmd(_loc1_).execute();
                }
            }).execute();
        }
        var curKnownAllianceIds:Array = UserGameData.getKnownAllianceIds(UserManager.user);
        knownAllianceIds = new ArrayCustom();
        for each(i in curKnownAllianceIds) {
            found = false;
            for each(i2 in prevKnownAllianceIds) {
                if (i == i2) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                knownAllianceIds.addItem(i);
            }
        }
        if (knownAllianceIds.length > 0) {
            new AllianceGetNotesCmd(knownAllianceIds).ifResult(function ():void {
                var _loc2_:* = undefined;
                var _loc3_:* = undefined;
                var _loc1_:* = new ArrayCustom();
                for each(_loc2_ in knownAllianceIds) {
                    _loc3_ = AllianceNoteManager.getById(_loc2_);
                    if (!UserNoteManager.hasNote(_loc3_.ownerUserId)) {
                        _loc1_.addItem(_loc3_.ownerUserId);
                    }
                }
                if (_loc1_.length > 0) {
                    new UserGetNotesCmd(_loc1_).execute();
                }
            }).execute();
        }
        var curKnownLocationIds:Array = UserGameData.getKnownLocationIds(UserManager.user);
        var unknownLocationIds:ArrayCustom = new ArrayCustom();
        for each(i in curKnownLocationIds) {
            found = false;
            for each(i2 in prevKnownLocationIds) {
                if (i == i2) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                unknownLocationIds.addItem(i);
            }
        }
        if (unknownLocationIds.length > 0) {
            new LocationGetNotesCmd(unknownLocationIds).execute();
        }
        return true;
    }

    private static function addMessages(param1:*):void {
        var _loc2_:ArrayCustom = Message.fromDtos(param1);
        MessageManager.onNewMessagesArrived(_loc2_);
    }

    public static function addFavouriteUser(param1:FavouriteUser):void {
        var _loc2_:int = getFavouriteUserIndex(param1.userId);
        if (_loc2_ != -1) {
            favouriteUsers.removeItemAt(_loc2_);
        }
        favouriteUsers.addItem(param1.toDto());
    }

    private static function getFavouriteUserIndex(param1:Number):int {
        var _loc2_:int = 0;
        while (_loc2_ < favouriteUsers.length) {
            if (favouriteUsers[_loc2_].u == param1) {
                return _loc2_;
            }
            _loc2_++;
        }
        return -1;
    }

    public static function addFavouriteTower(param1:FavouriteTower):void {
        var _loc2_:int = getFavouriteTowerIndex(param1.id);
        if (_loc2_ != -1) {
            favouriteTowers.removeItemAt(_loc2_);
        }
        favouriteTowers.addItem(param1.toDto());
    }

    private static function getFavouriteTowerIndex(param1:Number):int {
        var _loc2_:int = 0;
        while (_loc2_ < favouriteTowers.length) {
            if (favouriteTowers[_loc2_].u == param1) {
                return _loc2_;
            }
            _loc2_++;
        }
        return -1;
    }

    public static function readAchievement(param1:Achievement):void {
        param1.isRead = true;
        var _loc2_:* = {};
        _loc2_.i = param1.typeId;
        _loc2_.l = param1.level;
        UserManager.user.gameData.statsData.achievementsDirty = true;
        achievementsToRead.addItem(_loc2_);
    }

    public static function openBox(param1:Number, param2:Resources):void {
        var _loc8_:int = 0;
        var _loc3_:* = param1 == UserManager.user.id;
        var _loc4_:UserTreasureData = UserManager.user.gameData.treasureData;
        var _loc5_:Resources = !!_loc3_ ? _loc4_.userBoxesQuantity : _loc4_.friendsBoxesQuantity;
        if (!_loc5_.canSubstract(param2)) {
            throw new Error("Opened boxes limit reached");
        }
        if (!_loc3_) {
            if (_loc4_.boxesByUsers[param1] != null) {
                _loc4_.boxesByUsers[param1]++;
            }
            else {
                _loc4_.boxesByUsers[param1] = 1;
            }
        }
        else {
            QuestCompletionGiftBoxes.tryComplete();
        }
        _loc5_.substract(param2);
        UserStatsManager.openedTreasureBox(UserManager.user, param2);
        _loc4_.dirty = true;
        var _loc6_:Resources = new Resources();
        if (param2.titanite > 0) {
            _loc6_.titanite = _loc4_.boxesValues.titanite;
        }
        if (param2.uranium > 0) {
            _loc6_.uranium = _loc4_.boxesValues.uranium;
        }
        if (param2.money > 0) {
            _loc6_.money = _loc4_.boxesValues.money;
        }
        UserManager.user.gameData.account.resources.add(_loc6_);
        var _loc7_:* = {};
        _loc7_.i = ++_loc4_.lastBoxId;
        _loc7_.u = param1;
        _loc7_.b = param2.toDto();
        boxesToOpen.addItem(_loc7_);
        if (_loc5_.capacity() == 0) {
            new UserRefreshCmd().execute();
        }
    }

    public static function readQuest(param1:int):void {
        questsToRead.addItem(param1);
    }

    override public function execute():void {
        var countActiveCommandsDecremented:Boolean = false;
        countActiveCommandsDecremented = false;
        countActiveCommands++;
        try {
            new JsonCallCmd("User.Refresh", this._dto, "POST").ifResult(function (param1:*):void {
                if (!updateUserByResultDto(param1, _dto)) {
                    AchievementManager.checkAchievements(UserManager.user, AchievementKindId.RESOURCE);
                }
                MessageManager.waitWhenMessagesIsReadOnServer = false;
                if (_onResult != null) {
                    _onResult();
                }
            }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(function ():void {
                try {
                    if (_onFinally != null) {
                        _onFinally();
                    }
                    return;
                }
                finally {
                    countActiveCommandsDecremented = true;
                    countActiveCommands--;
                }
            }).execute();
            return;
        }
        catch (e:Error) {
            if (!countActiveCommandsDecremented) {
                countActiveCommands--;
            }
            throw e;
        }
    }
}
}
