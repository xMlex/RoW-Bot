package model.data.giftPoints {
import common.DateUtil;
import common.TimeSpan;
import common.queries.util.query;

import gameObjects.observableObject.ObservableObject;

import model.data.User;
import model.data.effects.EffectSource;
import model.data.normalization.INEvent;
import model.data.normalization.INormalizable;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.giftPointProgram.NEventRefreshGiftPointsProgram;

public class UserGiftPointsProgramData extends ObservableObject implements INormalizable {

    private static const CLASS_NAME:String = "UserGiftPointsProgramData";

    public static const DATA_CHANGED:String = CLASS_NAME + "DataChanged";


    public var giftPoints:int;

    public var programActivationTime:Date;

    public var programDeadline:Date;

    public var depositorGroup:int;

    public var availableBonuses:Array;

    private var _dirty:Boolean;

    private var _oldGiftPoints:int;

    public function UserGiftPointsProgramData() {
        super();
    }

    public static function fromDto(param1:*):UserGiftPointsProgramData {
        var _loc2_:UserGiftPointsProgramData = new UserGiftPointsProgramData();
        if (param1 != null) {
            _loc2_.giftPoints = param1.p;
            _loc2_._oldGiftPoints = _loc2_.giftPoints;
            _loc2_.programActivationTime = new Date(param1.a);
            _loc2_.programDeadline = new Date(param1.z);
            _loc2_.depositorGroup = param1.d;
            _loc2_.availableBonuses = LightGppBonus.fromDtos(param1.b);
        }
        return _loc2_;
    }

    public function get addedPoints():int {
        return this.giftPoints - this._oldGiftPoints;
    }

    public function get isActive():Boolean {
        return this.programDeadline != null && this.programDeadline.time > ServerTimeManager.serverTimeNow.time;
    }

    public function get hasUnactivatedBonus():Boolean {
        return this.isActive && query(this.availableBonuses).any(function (param1:LightGppBonus):Boolean {
            return !param1.isActive;
        });
    }

    public function get leftTime():TimeSpan {
        return DateUtil.getCountdownUntil(ServerTimeManager.serverTimeNow, this.programDeadline);
    }

    public function get canAddPoints():Boolean {
        if (StaticDataManager.giftPointsProgramData == null || StaticDataManager.giftPointsProgramData.maxBonus == null) {
            return false;
        }
        return this._oldGiftPoints < StaticDataManager.giftPointsProgramData.maxBonus.costInGiftPoints;
    }

    public function dispatchEvents():void {
        if (this._dirty) {
            this._dirty = false;
            dispatchEvent(DATA_CHANGED);
        }
    }

    public function getLightGPPBonus(param1:int):LightGppBonus {
        var bonusId:int = param1;
        return query(this.availableBonuses).firstOrDefault(function (param1:LightGppBonus):Boolean {
            return param1.id == bonusId;
        });
    }

    public function update(param1:UserGiftPointsProgramData):void {
        if (param1 == null) {
            return;
        }
        if (this.giftPoints != param1.giftPoints) {
            this._oldGiftPoints = this.giftPoints;
        }
        this.giftPoints = param1.giftPoints;
        this.programActivationTime = param1.programActivationTime;
        this.programDeadline = param1.programDeadline;
        this.depositorGroup = param1.depositorGroup;
        this.availableBonuses = param1.availableBonuses;
        this._dirty = true;
    }

    public function refreshAvailableBonuses():void {
        var _loc1_:LightGppBonus = null;
        var _loc2_:int = 0;
        for each(_loc1_ in this.availableBonuses) {
            _loc1_.isActive = false;
            for each(_loc2_ in _loc1_.bonusItemsIds) {
                if (UserManager.user.gameData.effectData.isActiveEffectBySource(_loc2_, EffectSource.GiftPointsProgram, _loc1_.id)) {
                    _loc1_.isActive = true;
                    break;
                }
            }
        }
        this._dirty = true;
        this.dispatchEvents();
    }

    public function getNextEvent(param1:User, param2:Date):INEvent {
        var _loc3_:UserGiftPointsProgramData = param1.gameData.giftPointsProgramData;
        if (_loc3_.programDeadline == null) {
            return null;
        }
        if (_loc3_.programDeadline <= param2) {
            return new NEventRefreshGiftPointsProgram(param2);
        }
        return null;
    }

    public function refreshOldPoints():void {
        this._oldGiftPoints = this.giftPoints;
        this.checkOnMaxLevel();
    }

    private function checkOnMaxLevel():void {
        if (StaticDataManager.giftPointsProgramData == null || StaticDataManager.giftPointsProgramData.maxBonus == null) {
            return;
        }
        if (this._oldGiftPoints == StaticDataManager.giftPointsProgramData.maxBonus.costInGiftPoints) {
            this._dirty = true;
        }
    }
}
}
