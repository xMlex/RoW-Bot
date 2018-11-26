package model.logic.commands.world {
import common.ArrayCustom;
import common.queries.util.query;

import flash.utils.Dictionary;

import model.data.User;
import model.data.effects.EffectItem;
import model.data.effects.EffectSource;
import model.data.effects.EffectTypeId;
import model.data.effects.EffectsManager;
import model.data.map.MapPos;
import model.data.units.MapObjectTypeId;
import model.data.units.Unit;
import model.data.units.payloads.TradingPayload;
import model.data.units.payloads.TroopsPayload;
import model.data.users.UserNote;
import model.data.users.troops.Troops;
import model.data.users.troops.TroopsOrderId;
import model.logic.KnownUsersManager;
import model.logic.ServerTimeManager;
import model.logic.UserManager;
import model.logic.UserNoteManager;
import model.logic.UserStatsManager;
import model.logic.blackMarketItems.BlackMarketItemsNode;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.misc.ResourcesFlowManager;
import model.logic.robberyLimitData.RobberyCounterUtility;
import model.logic.troops.TroopsSendHelper;
import model.logic.units.UnitUtility;

public class UnitSendCmd extends BaseCmd {


    private var requestDto;

    private var _bunkerTroops:Troops;

    public function UnitSendCmd(param1:Number, param2:Number, param3:TradingPayload, param4:TroopsPayload, param5:int = 0, param6:Troops = null, param7:MapPos = null) {
        super();
        this._bunkerTroops = param6;
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "o": param1,
            "t": param2,
            "u": param5,
            "di": (param3 == null ? null : param3.toDto()),
            "ti": (param4 == null ? null : param4.toDto()),
            "bt": (param6 == null ? null : param6.toDto()),
            "k": (param7 == null ? null : param7.toDto()),
            "b": TroopsSendHelper.appliedItemsForBattle
        });
        TroopsSendHelper.appliedItemsForBattle = null;
    }

    private static function updateEffects(param1:Unit):void {
        var userEffects:ArrayCustom = null;
        var effectShields:Array = null;
        var unit:Unit = param1;
        if (unit == null || unit.troopsPayload == null) {
            return;
        }
        if (TroopsOrderId.isAggressive(unit.troopsPayload.order) && unit.TargetTypeId == MapObjectTypeId.USER_OR_LOCATION) {
            userEffects = UserManager.user.gameData.effectData.effectsList;
            effectShields = query(userEffects).where(function (param1:EffectItem):Boolean {
                return param1.activeState != null && param1.effectTypeId == EffectTypeId.UserFullProtection;
            }).toArray();
            EffectsManager.deleteEffects(effectShields);
        }
    }

    private static function updateBlackMarketItems(param1:Array):void {
        var _loc3_:Dictionary = null;
        var _loc4_:BlackMarketItemsNode = null;
        var _loc5_:int = 0;
        var _loc2_:Array = param1;
        if (_loc2_ != null) {
            _loc3_ = UserManager.user.gameData.blackMarketData.boughtItems;
            _loc5_ = 0;
            while (_loc5_ < _loc2_.length) {
                _loc4_ = _loc3_[_loc2_[_loc5_]];
                if (_loc4_ != null) {
                    if (_loc4_.freeCount + _loc4_.paidCount == 1) {
                        delete _loc3_[_loc2_[_loc5_]];
                    }
                    else if (_loc4_.freeCount != 0) {
                        _loc4_.freeCount--;
                    }
                    else {
                        _loc4_.paidCount--;
                    }
                }
                _loc5_++;
            }
        }
        TroopsSendHelper.appliedItemsForBattle = null;
    }

    public static function canSendTroops(param1:User, param2:Number):Boolean {
        if (param1.id == param2) {
            return true;
        }
        var _loc3_:UserNote = UserNoteManager.getById(param2);
        if (_loc3_ == null) {
            return true;
        }
        var _loc4_:Date = ServerTimeManager.serverTimeNow;
        var _loc5_:Boolean = UserManager.isNewPlayerProtection(param1.gameData.account.level, param1.gameData.commonData.registrationTime, _loc4_);
        if (_loc5_) {
            return true;
        }
        return !UserManager.isNewPlayerProtection(_loc3_.level, _loc3_.registrationTime, _loc4_);
    }

    private static function occupiedUser(param1:Number):Boolean {
        var _loc2_:Unit = null;
        for each(_loc2_ in UserManager.user.gameData.worldData.units) {
            if (_loc2_.TargetUserId == param1 && _loc2_.troopsPayload != null && _loc2_.troopsPayload.order == TroopsOrderId.Occupation && _loc2_.StateInTargetSector != null) {
                return true;
            }
        }
        return false;
    }

    private static function removeUnitTroopsFromBunker(param1:User, param2:Troops):void {
        var _loc3_:Unit = UnitUtility.FindInBunkerUnit(param1);
        if (_loc3_ == null) {
            return;
        }
        _loc3_.troopsPayload.troops.removeTroops(param2);
        if (_loc3_.troopsPayload.troops.Empty) {
            UnitUtility.RemoveUnit(param1, _loc3_);
        }
    }

    override public function execute():void {
        new JsonCallCmd("SendUnit", this.requestDto).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            var _loc6_:* = undefined;
            var _loc7_:* = undefined;
            var _loc8_:* = undefined;
            var _loc9_:* = undefined;
            var _loc10_:* = undefined;
            var _loc11_:* = undefined;
            var _loc12_:* = undefined;
            var _loc13_:* = undefined;
            var _loc14_:* = undefined;
            var _loc15_:* = undefined;
            var _loc16_:* = undefined;
            var _loc17_:* = undefined;
            var _loc18_:* = undefined;
            var _loc19_:* = undefined;
            var _loc20_:* = undefined;
            var _loc21_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user;
                _loc3_ = Unit.fromDto(param1.o);
                updateBlackMarketItems(requestDto.o.b);
                _loc4_ = _loc3_ != null;
                if (!_loc4_) {
                    if (_onResult != null) {
                        _onResult();
                    }
                    return;
                }
                updateEffects(_loc3_);
                _loc5_ = _loc3_.OwnerUserId == _loc2_.id;
                _loc6_ = _loc3_.StateMovingForward != null;
                _loc7_ = _loc3_.StateMovingBack != null;
                _loc8_ = _loc3_.troopsPayload != null;
                _loc9_ = _loc8_ && _loc3_.troopsPayload.hasSupport;
                _loc10_ = _loc8_ && _loc3_.troopsPayload.order == TroopsOrderId.Reinforcement;
                _loc11_ = _loc8_ && _loc3_.troopsPayload.order == TroopsOrderId.Robbery;
                _loc12_ = _loc8_ && _loc3_.troopsPayload.order == TroopsOrderId.MissileStrike;
                _loc13_ = _loc3_.TargetTypeId != MapObjectTypeId.RAID_LOCATION;
                _loc14_ = !occupiedUser(_loc3_.TargetUserId);
                _loc15_ = _loc8_ && _loc3_.TargetTypeId == MapObjectTypeId.USER_OR_LOCATION && !_loc3_.TargetIsLocation;
                _loc16_ = _loc8_ && _loc7_ && _loc3_.troopsPayload.order == TroopsOrderId.Bunker;
                _loc17_ = _bunkerTroops != null;
                if (_loc5_) {
                    if (_loc6_) {
                        UnitUtility.LoadUnit(_loc2_, _loc3_, _bunkerTroops);
                        if (_loc9_) {
                            for each(_loc18_ in _loc3_.troopsPayload.supportTroops) {
                                _loc19_ = UnitUtility.FindInSectorUnit(UserManager.user, _loc18_.ownerUserId, _loc2_.id);
                                if (_loc19_ != null && _loc19_.troopsPayload != null) {
                                    if (_loc19_.troopsPayload.troops.Equal(_loc18_.troops)) {
                                        UnitUtility.RemoveUnit(_loc2_, _loc19_);
                                    }
                                    else {
                                        _loc19_.troopsPayload.troops.removeTroops(_loc18_.troops);
                                    }
                                }
                            }
                        }
                        if (_loc11_ && _loc13_ && _loc14_) {
                            RobberyCounterUtility.decRobberyCounter(_loc3_.StateMovingForward.departureTime);
                            UserManager.user.gameData.effectData.decrementEffectUseCount(EffectTypeId.GppRobberedResourcesBonus, EffectSource.GiftPointsProgram);
                        }
                        if (_loc10_ && _loc15_) {
                            UserStatsManager.reinforcementSent(UserManager.user, _loc3_.troopsPayload.troops);
                        }
                    }
                    UnitUtility.AddUnit(_loc2_, _loc3_);
                    if (_loc12_) {
                        UserManager.user.gameData.worldData.DecMissileStrikeCounter(_loc3_.StateMovingForward.departureTime);
                        UserManager.user.gameData.troopsData.missileStorage.removeTroops(_loc3_.troopsPayload.troops);
                    }
                    if (_loc16_) {
                        removeUnitTroopsFromBunker(_loc2_, _loc3_.troopsPayload.troops);
                    }
                    if (_loc17_) {
                        removeUnitTroopsFromBunker(_loc2_, _bunkerTroops);
                    }
                }
                else {
                    _loc20_ = UnitUtility.FindInSectorUnit(_loc2_, _loc3_.OwnerUserId, _loc3_.TargetUserId);
                    if (_loc20_ != null) {
                        UnitUtility.RemoveUnit(_loc2_, _loc20_);
                    }
                    _loc21_ = !_loc3_.troopsPayload.troops.Empty;
                    if (_loc21_) {
                        UnitUtility.AddUnit(_loc2_, _loc3_);
                    }
                }
                KnownUsersManager.unitSent(_loc2_, _loc3_);
                ResourcesFlowManager.unitSent(_loc2_, _loc3_);
                UnitUtility.UnitSent(_loc2_, _loc3_);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
