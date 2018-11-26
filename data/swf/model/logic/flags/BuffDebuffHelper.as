package model.logic.flags {
import flash.events.Event;
import flash.events.EventDispatcher;

import model.data.alliances.AllianceGameData;
import model.data.alliances.AllianceNote;
import model.data.locations.allianceCity.flags.AllianceTacticsEffect;
import model.data.locations.allianceCity.flags.TacticsEffectsBonuses;
import model.data.locations.allianceCity.flags.enumeration.AllianceEffectApplyingType;
import model.data.users.alliances.UserAllianceData;
import model.logic.AllianceManager;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;
import model.logic.TimerManager;
import model.logic.UserManager;

public class BuffDebuffHelper {

    public static const CLASS_NAME:String = "BuffDebuffHelper";

    public static const REWARD_TIME_IS_OVER:String = CLASS_NAME + "RewardTimeIsOver";

    public static const REWARD_CHANGED:String = CLASS_NAME + "RewardChanged";

    private static var _instance:BuffDebuffHelper;

    private static var _events:EventDispatcher;


    private var _currentEffectBonus:TacticsEffectsBonuses;

    public function BuffDebuffHelper() {
        super();
        if (_instance) {
            throw new Error("BuffDebuffHelper single tone initialization error.");
        }
    }

    public static function get instance():BuffDebuffHelper {
        if (!_instance) {
            initialize();
        }
        return _instance;
    }

    private static function initialize():void {
        _instance = new BuffDebuffHelper();
        _instance.subscribe();
        _instance.refreshTacticsData();
    }

    private static function dispose():void {
        _instance.unsubscribe();
        TimerManager.removeTickListener(_instance.onTimerTick);
        _instance = null;
        _events = null;
    }

    public static function get events():EventDispatcher {
        if (_events == null) {
            _events = new EventDispatcher();
        }
        return _events;
    }

    public function get currentEffectBonus():TacticsEffectsBonuses {
        return this._currentEffectBonus;
    }

    public function get hasEffectsBonus():Boolean {
        if (this._currentEffectBonus && this._currentEffectBonus.expirationDate.time > ServerTimeManager.serverTimeNow.time) {
            return true;
        }
        return false;
    }

    public function get hasActiveEffects():Boolean {
        return AllianceManager.currentAlliance != null && AllianceManager.currentAlliance.gameData.tacticsData != null && AllianceManager.currentAlliance.gameData.tacticsData.hasActiveEffects;
    }

    public function getMyFirstEndingActiveEffectByType():AllianceTacticsEffect {
        if (AllianceManager.currentAlliance != null && AllianceManager.currentAlliance.gameData != null && AllianceManager.currentAlliance.gameData.tacticsData != null && AllianceManager.currentAlliance.gameData.tacticsData.activeEffects != null) {
            return BuffDebuffCalculate.getFirstEndingActiveEffectByType(AllianceManager.currentAlliance.gameData.tacticsData.activeEffects);
        }
        return null;
    }

    private function subscribe():void {
        if (AllianceManager.currentAlliance) {
            AllianceManager.currentAlliance.gameData.addEventHandler(AllianceGameData.TACTICS_DATA_CHANGED, this.onTacticsDataChanged);
        }
        if (UserManager.user.gameData.allianceData) {
            UserManager.user.gameData.allianceData.addEventHandler(UserAllianceData.ALLIANCE_DATA_CHANGED, this.onAllinceDataChanged);
        }
    }

    private function unsubscribe():void {
        if (AllianceManager.currentAlliance) {
            AllianceManager.currentAlliance.gameData.removeEventHandler(AllianceGameData.TACTICS_DATA_CHANGED, this.onTacticsDataChanged);
        }
        if (UserManager.user.gameData.allianceData) {
            UserManager.user.gameData.allianceData.removeEventHandler(UserAllianceData.ALLIANCE_DATA_CHANGED, this.onAllinceDataChanged);
        }
    }

    private function onTacticsDataChanged(param1:Event):void {
        this.refreshTacticsData();
    }

    private function onAllinceDataChanged(param1:Event):void {
        if (!AllianceManager.currentAlliance || !AllianceManager.currentAllianceCity) {
            dispose();
        }
    }

    private function refreshTacticsData():void {
        var _loc1_:TacticsEffectsBonuses = null;
        if (AllianceManager.currentAlliance && AllianceManager.currentAlliance.gameData.tacticsData && AllianceManager.currentAlliance.gameData.tacticsData.effectsBonuses && AllianceManager.currentAlliance.gameData.tacticsData.effectsBonuses.length > 0) {
            _loc1_ = AllianceManager.currentAlliance.gameData.tacticsData.effectsBonuses[0];
            if (_loc1_) {
                this._currentEffectBonus = _loc1_;
                events.dispatchEvent(new Event(REWARD_CHANGED));
                TimerManager.addTickListener(this.onTimerTick);
            }
        }
    }

    private function onTimerTick():void {
        if (!this.hasEffectsBonus) {
            this._currentEffectBonus = null;
            TimerManager.removeTickListener(this.onTimerTick);
            events.dispatchEvent(new Event(REWARD_TIME_IS_OVER));
        }
    }

    public function canApplyEffectOnAlliance(param1:AllianceNote):Boolean {
        if (param1.id == AllianceManager.currentAlliance.id) {
            return this.canApplyEffectOnMyAlliance();
        }
        return this.canApplyEffectOnOtherAlliance(param1);
    }

    public function canApplyEffectOnOtherAlliance(param1:AllianceNote):Boolean {
        if (!this.canApplyEffect) {
            return false;
        }
        if (this.currentEffectBonus.debuffsCount == 0) {
            return false;
        }
        var _loc2_:int = param1.getMaxEffectCount(false);
        var _loc3_:int = BuffDebuffCalculate.getApplyEffectCount(param1.activeTacticsEffects, AllianceEffectApplyingType.DEBUFF);
        return _loc3_ < _loc2_;
    }

    public function canApplyEffectOnMyAlliance():Boolean {
        if (!this.canApplyEffect) {
            return false;
        }
        if (this.currentEffectBonus.buffsCount == 0) {
            return false;
        }
        var _loc1_:int = 0;
        if (AllianceManager.currentAlliance.gameData.tacticsData && AllianceManager.currentAlliance.gameData.tacticsData.hasActiveEffects) {
            _loc1_ = BuffDebuffCalculate.getApplyEffectCount(AllianceManager.currentAlliance.gameData.tacticsData.activeEffects, AllianceEffectApplyingType.BUFF);
        }
        return _loc1_ < StaticDataManager.allianceData.tacticsData.allianceBuffsTotal;
    }

    public function get canApplyEffect():Boolean {
        return this.hasPermissionToApplyEffects && this.hasEffectsBonus;
    }

    private function get hasPermissionToApplyEffects():Boolean {
        return AllianceManager.currentMember && AllianceManager.currentMember.canMakeDiplomaticDecidions;
    }
}
}
