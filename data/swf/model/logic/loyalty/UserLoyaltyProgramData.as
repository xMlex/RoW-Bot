package model.logic.loyalty {
import common.ArrayCustom;

import flash.events.Event;
import flash.utils.Dictionary;

import gameObjects.observableObject.ObservableObject;

import model.data.Resources;
import model.data.User;
import model.data.units.Unit;
import model.data.users.acceleration.ResourceMiningBoost;
import model.data.users.misc.UserBlackMarketData;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.units.UnitUtility;

public class UserLoyaltyProgramData extends ObservableObject {

    private static const CLASS_NAME:String = "UserLoyaltyProgramData";

    public static const DATA_CHANGED:String = CLASS_NAME + "Changed";


    public var daysWithPrize:ArrayCustom;

    public var currentDay:int;

    public var viewedLoyalityData:Boolean;

    public var dirty:Boolean;

    public function UserLoyaltyProgramData() {
        this.daysWithPrize = new ArrayCustom();
        super();
    }

    public static function fromDto(param1:*):UserLoyaltyProgramData {
        var _loc2_:UserLoyaltyProgramData = new UserLoyaltyProgramData();
        _loc2_.daysWithPrize = new ArrayCustom(param1.p);
        _loc2_.currentDay = param1.d;
        _loc2_.viewedLoyalityData = param1.v;
        return _loc2_;
    }

    public static function updateUserFromDto(param1:*, param2:Array = null):void {
        var _loc3_:User = null;
        var _loc4_:Unit = null;
        var _loc5_:Dictionary = null;
        var _loc6_:* = undefined;
        if (param1) {
            _loc3_ = UserManager.user;
            if (param1.r != null) {
                _loc3_.gameData.account.resources.add(Resources.fromDto(param1.r));
            }
            if (param1.u != null) {
                _loc4_ = UnitUtility.FindInBunkerUnit(_loc3_);
                if (_loc4_ != null) {
                    _loc4_.fromClone(Unit.fromDto(param1.u));
                }
                else {
                    _loc3_.gameData.worldData.units.addItem(Unit.fromDto(param1.u));
                }
                _loc3_.gameData.worldData.dirtyUnitListChanged = true;
            }
            if (param1.e != null) {
                _loc3_.gameData.account._experience = _loc3_.gameData.account._experience + param1.e;
            }
            if (param1.s != null) {
                _loc3_.gameData.skillData.skillPoints = _loc3_.gameData.skillData.skillPoints + param1.s;
                _loc3_.gameData.skillData.dirty = true;
            }
            if (param1.b != null) {
                if (_loc3_.gameData.blackMarketData == null) {
                    _loc3_.gameData.blackMarketData = new UserBlackMarketData();
                }
                _loc5_ = new Dictionary();
                for (_loc6_ in param1.b) {
                    _loc5_[_loc6_] = param1.b[_loc6_];
                }
                _loc3_.gameData.blackMarketData.boughtItemsForRefresh = _loc5_;
                _loc3_.gameData.blackMarketData.dirty = true;
            }
            if (param1.m != null) {
                _loc3_.gameData.constructionData.resourceMiningBoosts = ResourceMiningBoost.fromDtos(param1.m);
            }
        }
        UserManager.user.gameData.dispatchEvents();
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            events.dispatchEvent(new Event(DATA_CHANGED));
        }
    }

    public function markAllDaysAsComplete():void {
        var _loc1_:int = 0;
        while (_loc1_ < this.daysWithPrize.length) {
            this.daysWithPrize[_loc1_] = 0;
            _loc1_++;
        }
    }

    public function get hasDaysWithPrize():Boolean {
        var _loc1_:int = 0;
        while (_loc1_ < this.daysWithPrize.length) {
            if (this.daysWithPrize[_loc1_] == 1) {
                return true;
            }
            _loc1_++;
        }
        return false;
    }

    public function isPrizeDay(param1:int):Boolean {
        return this.daysWithPrize[param1 - 1] == 1;
    }

    public function get isCurrentDayLast():Boolean {
        return this.currentDay == StaticDataManager.loyaltyProgramData.lastDay;
    }
}
}
