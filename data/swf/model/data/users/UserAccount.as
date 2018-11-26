package model.data.users {
import common.ArrayCustom;

import configs.Global;

import gameObjects.observableObject.ObservableObject;

import model.data.Resources;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.quests.commands.RefreshPeriodicQuestsCmd;

public class UserAccount extends ObservableObject {

    public static const EVENT_EXPERIENCE_CHANGED:String = "UserAccountEVENT_EXPERIENCE_CHANGED";

    public static const EVENT_LEVEL_CHANGED:String = "UserAccountEVENT_LEVEL_CHANGED";


    public var resources:Resources;

    public var minedResources:Resources;

    public var resourcesPerHour:Resources;

    public var resourcesLimit:Resources;

    public var resourcesConsumedByTroops:Resources;

    public var resourcesConsumedByBuildings:Resources;

    public var miningPerHour:Resources;

    public var _level:int;

    public var _experience:Number;

    public var levelUpPoints:int;

    private var _forbidMessages:Boolean;

    private var _forbidMessagesDateTo:Date;

    public function UserAccount() {
        this.resourcesPerHour = new Resources();
        this.resourcesLimit = new Resources();
        this.resourcesConsumedByTroops = new Resources();
        this.resourcesConsumedByBuildings = new Resources();
        this.miningPerHour = new Resources();
        super();
    }

    public static function fromDto(param1:*):UserAccount {
        var _loc2_:UserAccount = new UserAccount();
        _loc2_.resources = Resources.fromDto(param1.r);
        _loc2_.minedResources = new Resources();
        _loc2_.level = param1.l;
        _loc2_.experience = param1.x;
        _loc2_.forbidMessages = param1.m;
        _loc2_.forbidMessagesDateTo = param1.f != null ? new Date(param1.f) : null;
        _loc2_.levelUpPoints = param1.v != null ? int(param1.v) : 0;
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public function get level():int {
        return this._level;
    }

    public function set level(param1:int):void {
        if (this._level != param1) {
            this._level = param1;
            dispatchEvent(EVENT_EXPERIENCE_CHANGED);
            dispatchEvent(EVENT_LEVEL_CHANGED);
            if (Global.PERIODIC_QUESTS_ENABLED && this._level == Global.MIN_LEVEL_FOR_PERIODIC && UserManager.user != null && (UserManager.user.gameData.questData.periodicData == null || UserManager.user.gameData.questData.periodicData.groups == null)) {
                new RefreshPeriodicQuestsCmd().execute();
            }
        }
    }

    public function get experience():Number {
        return this._experience;
    }

    public function set experience(param1:Number):void {
        if (this._experience != param1) {
            this._experience = param1;
            dispatchEvent(EVENT_EXPERIENCE_CHANGED);
        }
    }

    public function get maxExperienceForThisLevel():int {
        return StaticDataManager.levelData.pointsForLevel[this.level];
    }

    public function get maxExperienceForPrevLevel():int {
        return StaticDataManager.levelData.pointsForLevel[this.level - 1];
    }

    public function get forbidMessages():Boolean {
        return this._forbidMessages;
    }

    public function set forbidMessages(param1:Boolean):void {
        if (this._forbidMessages != param1) {
            this._forbidMessages = param1;
        }
    }

    public function get forbidMessagesDateTo():Date {
        return this._forbidMessagesDateTo;
    }

    public function set forbidMessagesDateTo(param1:Date):void {
        if (this._forbidMessagesDateTo != param1) {
            this._forbidMessagesDateTo = param1;
        }
    }

    public function maxExperienceForLevel(param1:int):int {
        var _loc2_:Array = StaticDataManager.levelData.pointsForLevel;
        return _loc2_[param1];
    }

    public function isEnough(param1:Resources):Boolean {
        return this.resources.canSubstract(param1);
    }

    public function update(param1:UserAccount):void {
        this.resources = param1.resources;
        this.levelUpPoints = param1.levelUpPoints;
        this.experience = param1.experience;
        this.level = param1.level;
        this.forbidMessages = param1.forbidMessages;
        this.forbidMessagesDateTo = param1.forbidMessagesDateTo;
    }
}
}
