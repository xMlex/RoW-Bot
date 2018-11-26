package model.data.users.troops {
import common.ArrayCustom;

import configs.Global;

import flash.utils.Dictionary;

import model.data.alliances.city.AllianceCityBattleFlagResult;
import model.data.alliances.city.AllianceCityBattleInfo;
import model.data.effects.LightEffectItem;
import model.data.locations.LocationNote;
import model.data.locations.allianceCity.flags.AllianceCityFlag;
import model.data.mines.MineTypeId;
import model.data.raids.RaidResult;
import model.data.ratings.RatingResult;
import model.data.tournaments.TournamentStatistics;
import model.data.units.MapObjectTypeId;
import model.data.units.TroopsTierBattleInfo;
import model.data.units.resurrection.enums.TargetObjectTypeId;
import model.logic.LocationNoteManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.CollectibleThemedItem;
import model.logic.dtoSerializer.DtoDeserializer;

public class BattleResult {


    public var time:Date;

    public var sectorUserId:Number;

    public var sectorTypeId:int;

    public var attackerAllianceId:Number;

    public var attackerUserId:Number;

    public var attackerUserAllianceRankId:Number;

    public var defenderUserId:Number;

    public var defenderAllianceId:Number;

    public var percentage:Number;

    public var attackerTroopsOrder:int;

    public var attackerWon:Boolean;

    public var isSectorProtection:Boolean;

    public var attackerLossesPowerByUser:Dictionary;

    public var defenderLossesPowerByUser:Dictionary;

    public var refUserId:Number;

    public var troopsInitial:Troops;

    public var troopsLosses:Troops;

    public var experience:Number;

    public var newExperience:Number;

    public var bonusNewExperience:Number;

    public var wisdomPoints:Number;

    public var bonusNewWisdomPoints:Number;

    public var pvpPoints:Number;

    public var collectibleThemedItemsBonus:Array;

    public var friendlyTroopsInitial:Troops;

    public var friendlyTroopsLosses:Troops;

    public var opponentTroopsInitial:Troops;

    public var opponentTroopsLosses:Troops;

    public var robberyResult:RobberyResult;

    public var intelligenceResult:IntelligenceResult;

    public var raidResult:RaidResult;

    public var antigenGained:Number;

    public var ratingResult:RatingResult;

    public var supporters:ArrayCustom;

    public var statisticsByTournament:Array;

    public var attackerEffectsByUserId:Dictionary;

    public var defenderEffectsByUserId:Dictionary;

    public var blackMarketItemsByUserId:Array;

    public var allianceCityInfo:AllianceCityBattleInfo;

    public var allianceCityFlagResult:AllianceCityBattleFlagResult;

    public var attackerTroopsTiersInfosByUser:Object;

    public var defenderTroopsTiersInfosByUser:Object;

    private var _sectorMapObjectTypeId:int;

    public function BattleResult() {
        this._sectorMapObjectTypeId = TargetObjectTypeId.UNDEFINED;
        super();
    }

    public static function fromDto(param1:*):BattleResult {
        var _loc3_:* = undefined;
        var _loc4_:* = undefined;
        var _loc5_:* = undefined;
        var _loc6_:* = undefined;
        var _loc7_:* = undefined;
        var _loc8_:* = undefined;
        var _loc9_:* = undefined;
        var _loc2_:BattleResult = new BattleResult();
        _loc2_.time = new Date(param1.t);
        _loc2_.sectorUserId = param1.s;
        _loc2_.sectorTypeId = param1.h;
        _loc2_.attackerUserAllianceRankId = param1.q == null ? Number(Number.NaN) : Number(param1.q);
        _loc2_.attackerUserId = param1.a;
        _loc2_.defenderUserId = param1.d;
        _loc2_.attackerAllianceId = param1.m == null ? Number(Number.NaN) : Number(param1.m);
        _loc2_.defenderAllianceId = param1.z == null ? Number(Number.NaN) : Number(param1.z);
        _loc2_.percentage = param1.pr;
        _loc2_.attackerTroopsOrder = param1.o;
        _loc2_.attackerWon = param1.w;
        _loc2_.isSectorProtection = param1.sp;
        _loc2_.refUserId = param1.r;
        _loc2_.troopsInitial = param1.i == null ? null : Troops.fromDto(param1.i);
        _loc2_.troopsLosses = param1.l == null ? null : Troops.fromDto(param1.l);
        _loc2_.experience = param1.e;
        _loc2_.newExperience = param1.u;
        _loc2_.bonusNewExperience = param1.be;
        _loc2_.wisdomPoints = param1.wp;
        _loc2_.bonusNewWisdomPoints = param1.bw;
        _loc2_.pvpPoints = param1.pv;
        _loc2_.collectibleThemedItemsBonus = DtoDeserializer.toArray(param1.ti, CollectibleThemedItem.fromDto);
        _loc2_.ratingResult = RatingResult.fromDto(param1);
        _loc2_.friendlyTroopsInitial = param1.f == null ? null : Troops.fromDto(param1.f);
        _loc2_.friendlyTroopsLosses = param1.y == null ? null : Troops.fromDto(param1.y);
        _loc2_.opponentTroopsInitial = param1.n == null ? null : Troops.fromDto(param1.n);
        _loc2_.opponentTroopsLosses = param1.p == null ? null : Troops.fromDto(param1.p);
        _loc2_.robberyResult = param1.b == null ? null : RobberyResult.fromDto(param1.b);
        _loc2_.intelligenceResult = param1.g == null ? null : IntelligenceResult.fromDto(param1.g);
        _loc2_.raidResult = param1.c == null ? null : RaidResult.fromDto(param1.c);
        _loc2_.antigenGained = param1.x == null ? Number(NaN) : Number(param1.x);
        _loc2_.supporters = param1.j == null ? null : BattleSupporter.fromDtos(param1.j);
        _loc2_.statisticsByTournament = param1.ts == null ? null : TournamentStatistics.fromDtos(param1.ts);
        _loc2_.attackerLossesPowerByUser = new Dictionary();
        for (_loc3_ in param1.ap) {
            _loc2_.attackerLossesPowerByUser[_loc3_] = param1.ap[_loc3_];
        }
        _loc2_.defenderLossesPowerByUser = new Dictionary();
        for (_loc4_ in param1.dp) {
            _loc2_.defenderLossesPowerByUser[_loc4_] = param1.dp[_loc4_];
        }
        if (param1.af) {
            _loc2_.attackerEffectsByUserId = new Dictionary();
            for (_loc5_ in param1.af) {
                _loc2_.attackerEffectsByUserId[_loc5_] = LightEffectItem.fromDtos(param1.af[_loc5_]);
            }
        }
        if (param1.df) {
            _loc2_.defenderEffectsByUserId = new Dictionary();
            for (_loc6_ in param1.df) {
                _loc2_.defenderEffectsByUserId[_loc6_] = LightEffectItem.fromDtos(param1.df[_loc6_]);
            }
        }
        if (param1.bm) {
            _loc2_.blackMarketItemsByUserId = new Array();
            for (_loc7_ in param1.bm) {
                _loc2_.blackMarketItemsByUserId[_loc7_] = param1.bm[_loc7_];
            }
        }
        if (param1.at) {
            _loc2_.attackerTroopsTiersInfosByUser = {};
            for (_loc8_ in param1.at) {
                _loc2_.attackerTroopsTiersInfosByUser[_loc8_] = TroopsTierBattleInfo.fromDtos(param1.at[_loc8_]);
            }
        }
        if (param1.dt) {
            _loc2_.defenderTroopsTiersInfosByUser = {};
            for (_loc9_ in param1.dt) {
                _loc2_.defenderTroopsTiersInfosByUser[_loc9_] = TroopsTierBattleInfo.fromDtos(param1.dt[_loc9_]);
            }
        }
        _loc2_.allianceCityInfo = AllianceCityBattleInfo.fromDto(param1.ci);
        _loc2_.allianceCityFlagResult = AllianceCityBattleFlagResult.fromDto(param1.fr);
        return _loc2_;
    }

    public function get totalExperience():Number {
        var _loc1_:Number = !!Global.NEW_EXPERIENCE_ENABLED ? Number(this.newExperience) : Number(this.experience);
        return _loc1_;
    }

    public function get sectorMapObjectTypeId():int {
        if (this._sectorMapObjectTypeId == TargetObjectTypeId.UNDEFINED) {
            if (this.sectorTypeId == MapObjectTypeId.RAID_LOCATION) {
                this._sectorMapObjectTypeId = TargetObjectTypeId.RAID_LOCATION;
            }
            else if (this.sectorUserId > 0) {
                this._sectorMapObjectTypeId = TargetObjectTypeId.SECTOR;
            }
            else if (this.isTowerBattle) {
                this._sectorMapObjectTypeId = TargetObjectTypeId.TOWER;
            }
            else if (this.isAllianceCityBattle) {
                this._sectorMapObjectTypeId = TargetObjectTypeId.ALLIANCE_CITY;
            }
            else if (this.isDynamicMine) {
                this._sectorMapObjectTypeId = TargetObjectTypeId.DYNAMIC_MINES;
            }
            else if (this.isMine) {
                this._sectorMapObjectTypeId = TargetObjectTypeId.MINE;
            }
        }
        return this._sectorMapObjectTypeId;
    }

    public function get myUserSupporter():Boolean {
        if (this.refUserId != UserManager.user.id) {
            return false;
        }
        return this.userIsSupporter(this.refUserId);
    }

    public function userIsSupporter(param1:int):Boolean {
        var _loc2_:BattleSupporter = null;
        if (this.supporters == null) {
            return false;
        }
        for each(_loc2_ in this.supporters) {
            if (_loc2_.userId == param1) {
                return true;
            }
        }
        return false;
    }

    public function get myUserLosses():Troops {
        var _loc3_:BattleSupporter = null;
        var _loc1_:Troops = new Troops();
        var _loc2_:Number = UserManager.user.id;
        if (_loc2_ == this.attackerUserId && this.attackerLosses) {
            _loc1_.addTroops(this.attackerLosses);
        }
        else if (_loc2_ == this.defenderUserId && this.defenderTroops) {
            _loc1_.addTroops(this.defenderLosses);
        }
        else if (_loc2_ == this.refUserId && this.defenderLosses != null) {
            _loc1_.addTroops(this.defenderLosses);
        }
        else if (this.supporters) {
            for each(_loc3_ in this.supporters) {
                if (_loc3_.userId == _loc2_) {
                    _loc1_.addTroops(_loc3_.troopsLosses);
                }
            }
        }
        return _loc1_;
    }

    public function getTroopsInitial():Troops {
        return this.friendlyTroopsInitial != null ? this.friendlyTroopsInitial : this.troopsInitial;
    }

    public function getTroopsLosses():Troops {
        return this.friendlyTroopsLosses != null ? this.friendlyTroopsLosses : this.troopsLosses;
    }

    public function get attackerTroops():Troops {
        return this.attackerUserId != this.refUserId ? !!this.myUserSupporter ? this.getTroopsInitial() : this.opponentTroopsInitial : this.getTroopsInitial();
    }

    public function get defenderTroops():Troops {
        return this.attackerUserId == this.refUserId ? this.opponentTroopsInitial : !!this.myUserSupporter ? this.opponentTroopsInitial : this.getTroopsInitial();
    }

    public function get attackerLosses():Troops {
        return this.attackerUserId != this.refUserId ? !!this.myUserSupporter ? this.getTroopsLosses() : this.opponentTroopsLosses : this.getTroopsLosses();
    }

    public function get defenderLosses():Troops {
        return this.attackerUserId == this.refUserId ? this.opponentTroopsLosses : !!this.myUserSupporter ? this.opponentTroopsLosses : this.getTroopsLosses();
    }

    public function get attackerTierInfos():Object {
        return this.attackerTroopsTiersInfosByUser;
    }

    public function get defenderTierInfos():Object {
        return this.defenderTroopsTiersInfosByUser;
    }

    public function getTierInfoByUser(param1:int):Array {
        if (this.attackerTroopsTiersInfosByUser != null && this.attackerTroopsTiersInfosByUser[param1] != undefined) {
            return this.attackerTroopsTiersInfosByUser[param1];
        }
        if (this.defenderTroopsTiersInfosByUser != null && this.defenderTroopsTiersInfosByUser[param1] != undefined) {
            return this.defenderTroopsTiersInfosByUser[param1];
        }
        return null;
    }

    public function isImportantResult():Boolean {
        var _loc1_:Number = UserManager.user.id;
        var _loc2_:* = this.attackerUserId == _loc1_;
        var _loc3_:* = this.defenderUserId == _loc1_;
        if (!_loc2_ && !_loc3_) {
            return false;
        }
        var _loc4_:Number = 0;
        if (this.troopsLosses && this.troopsInitial) {
            _loc4_ = this.troopsLosses.getLength() / this.troopsInitial.getLength() * 100;
        }
        return _loc4_ >= 5;
    }

    public function get isTowerBattle():Boolean {
        if (this.sectorTypeId == MapObjectTypeId.RAID_LOCATION || this.sectorUserId > 0) {
            return false;
        }
        var _loc1_:LocationNote = LocationNoteManager.getById(-this.sectorUserId, true);
        return _loc1_ != null && _loc1_.towerInfo != null;
    }

    public function get isAllianceCityBattle():Boolean {
        if (this.sectorTypeId == MapObjectTypeId.RAID_LOCATION || this.sectorUserId > 0) {
            return false;
        }
        var _loc1_:LocationNote = LocationNoteManager.getById(-this.sectorUserId, true);
        return _loc1_ != null && _loc1_.allianceCityInfo != null;
    }

    public function get isMine():Boolean {
        if (this.sectorTypeId != MapObjectTypeId.USER_OR_LOCATION || this.sectorUserId > 0) {
            return false;
        }
        var _loc1_:LocationNote = LocationNoteManager.getById(-this.sectorUserId, true);
        return _loc1_ != null && _loc1_.mineInfo != null;
    }

    public function get isDynamicMine():Boolean {
        if (this.sectorTypeId != MapObjectTypeId.USER_OR_LOCATION || this.sectorUserId > 0) {
            return false;
        }
        var _loc1_:LocationNote = LocationNoteManager.getById(-this.sectorUserId, true);
        return _loc1_ != null && _loc1_.mineInfo != null && _loc1_.mineInfo.typeId > MineTypeId.DynamicMinesStartingId;
    }

    public function get flagsPoints():int {
        var _loc3_:AllianceCityFlag = null;
        if (!this.allianceCityFlagResult) {
            return 0;
        }
        var _loc1_:int = 0;
        var _loc2_:Vector.<AllianceCityFlag> = this.allianceCityFlagResult.flagsSnatched;
        for each(_loc3_ in _loc2_) {
            _loc1_ = _loc1_ + _loc3_.points;
        }
        return _loc1_;
    }

    public function get flagsCountByTypeInfo():Dictionary {
        var _loc5_:AllianceCityFlag = null;
        var _loc6_:int = 0;
        if (!this.allianceCityFlagResult) {
            return null;
        }
        var _loc1_:Vector.<AllianceCityFlag> = this.allianceCityFlagResult.flagsSnatched;
        var _loc2_:Dictionary = new Dictionary();
        var _loc3_:int = Global.serverSettings.allianceCityFlag.getFlagTypeByLeague(1);
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            _loc2_[_loc4_ + 1] = 0;
            _loc4_++;
        }
        for each(_loc5_ in _loc1_) {
            _loc6_ = Global.serverSettings.allianceCityFlag.getFlagTypeByLeague(_loc5_.league);
            _loc2_[_loc6_]++;
        }
        return _loc2_;
    }

    public function get allianceCityFlag():AllianceCityFlag {
        var _loc2_:Number = NaN;
        var _loc3_:AllianceCityFlag = null;
        var _loc4_:AllianceCityFlag = null;
        var _loc1_:AllianceCityFlag = null;
        if (this.allianceCityFlagResult) {
            _loc2_ = UserManager.user.id;
            if (_loc2_ == this.attackerUserId) {
                for each(_loc3_ in this.allianceCityFlagResult.flagsSnatched) {
                    if (_loc3_.ownerAllianceId == this.allianceCityFlagResult.attackerAllianceId) {
                        _loc1_ = _loc3_;
                        break;
                    }
                }
            }
            else {
                for each(_loc4_ in this.allianceCityFlagResult.flagsSnatched) {
                    if (_loc4_.ownerCityId == -this.defenderUserId) {
                        _loc1_ = _loc4_;
                        break;
                    }
                }
            }
        }
        return _loc1_;
    }

    public function isUserWon(param1:Number):Boolean {
        return this.attackerWon && this.isUserAttacker(param1) || !this.attackerWon && this.isUserDefender(param1);
    }

    public function isUserAttacker(param1:Number):Boolean {
        return this.attackerUserId == param1;
    }

    public function isUserDefender(param1:Number):Boolean {
        return this.defenderUserId == param1;
    }

    public function getBattleTierInfo(param1:Object):Array {
        if (param1 == null) {
            return null;
        }
        if (param1[this.refUserId] != undefined) {
            return param1[this.refUserId];
        }
        return this.getMaxTroopsTierInfo(param1);
    }

    private function getMaxTroopsTierInfo(param1:Object):Array {
        var _loc4_:* = null;
        var _loc5_:* = null;
        var _loc6_:Array = null;
        var _loc7_:int = 0;
        var _loc8_:int = 0;
        var _loc9_:TroopsTierBattleInfo = null;
        var _loc2_:Object = {};
        var _loc3_:Array = [];
        for (_loc4_ in param1) {
            _loc6_ = param1[_loc4_];
            for each(_loc9_ in _loc6_) {
                _loc7_ = _loc9_.tierId;
                _loc8_ = _loc9_.level;
                if (_loc2_[_loc7_] == undefined) {
                    _loc2_[_loc7_] = _loc8_;
                }
                else {
                    _loc2_[_loc7_] = Math.max(_loc8_, _loc2_[_loc7_]);
                }
            }
        }
        for (_loc5_ in _loc2_) {
            _loc3_.push(TroopsTierBattleInfo.createSimple(int(_loc5_), _loc2_[_loc5_]));
        }
        return _loc3_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "t": this.time.time,
            "s": this.sectorUserId,
            "a": this.attackerUserId,
            "d": this.defenderUserId,
            "q": (!!isNaN(this.attackerUserAllianceRankId) ? null : this.attackerUserAllianceRankId),
            "m": (!!isNaN(this.attackerAllianceId) ? null : this.attackerAllianceId),
            "z": (!!isNaN(this.defenderAllianceId) ? null : this.defenderAllianceId),
            "h": this.sectorTypeId,
            "o": this.attackerTroopsOrder,
            "w": this.attackerWon,
            "r": this.refUserId,
            "i": (this.troopsInitial == null ? null : this.troopsInitial.toDto()),
            "l": (this.troopsLosses == null ? null : this.troopsLosses.toDto()),
            "e": this.experience,
            "f": (this.friendlyTroopsInitial == null ? null : this.friendlyTroopsInitial.toDto()),
            "y": (this.friendlyTroopsLosses == null ? null : this.friendlyTroopsLosses.toDto()),
            "n": (this.opponentTroopsInitial == null ? null : this.opponentTroopsInitial.toDto()),
            "p": (this.opponentTroopsLosses == null ? null : this.opponentTroopsLosses.toDto()),
            "b": (this.robberyResult == null ? null : this.robberyResult.toDto()),
            "g": (this.intelligenceResult == null ? null : this.intelligenceResult.toDto()),
            "x": (!!isNaN(this.antigenGained) ? null : this.antigenGained),
            "j": (this.supporters == null ? null : BattleSupporter.toDtos(this.supporters))
        };
        return _loc1_;
    }
}
}
