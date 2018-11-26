package model.data {
import cache.CacheVisualBattle;

import common.ArrayCustom;
import common.Random;
import common.Randomizer;

import flash.utils.Dictionary;
import flash.utils.getTimer;
import flash.utils.setTimeout;

import model.data.scenes.types.info.TroopsTypeId;
import model.data.visualBattle.UnitVO;
import model.logic.UserManager;
import model.logic.specific.Forces;
import model.logic.utils.UnitTypeValidator;
import model.ui.UnitUI;

public class VisualBattleDataProvider {

    private static var _instance:VisualBattleDataProvider;


    private var _myUnitsSelected:Vector.<UnitVO>;

    private var _enemyUnitsSelected:Vector.<UnitVO>;

    private var _battleData:VisualBattleData;

    private var _myForces:Forces;

    private var _enemyForces:Forces;

    private var _myUnitsKilledAllDic:Dictionary;

    private var _enemyUnitsKilledAllDic:Dictionary;

    private var _isMyUserAttackedFirst:Boolean;

    private var _isSoundsOn:Boolean = true;

    private var _updateloadingProgressFn:Function;

    private var _cacheVisualBattle:CacheVisualBattle;

    private var _allMyLosses:Number = 0;

    private var _allEnemyLosses:Number = 0;

    private var _allMyUnits:Number = 0;

    private var _allEnemyUnits:Number = 0;

    public function VisualBattleDataProvider() {
        this._myUnitsKilledAllDic = new Dictionary();
        this._enemyUnitsKilledAllDic = new Dictionary();
        this._cacheVisualBattle = new CacheVisualBattle();
        super();
        if (_instance) {
            throw new Error("VisualBattleDataProvider singleton instance access error. Use static instance getter");
        }
    }

    public static function get instance():VisualBattleDataProvider {
        if (!_instance) {
            _instance = new VisualBattleDataProvider();
        }
        return _instance;
    }

    public function get isSoundsOn():Boolean {
        return !!VisualBattleConfig.isMiniGame ? Boolean(this._isSoundsOn) : Boolean(UserManager.user.gameData.userGameSettings.soundsEnabled);
    }

    public function set isSoundsOn(param1:Boolean):void {
        this._isSoundsOn = param1;
    }

    public function set updateloadingProgressFn(param1:Function):void {
        this._updateloadingProgressFn = param1;
    }

    public function get enemyUnitsKilledAllDic():Dictionary {
        return this._enemyUnitsKilledAllDic;
    }

    public function get myForces():Forces {
        return this._myForces;
    }

    public function get enemyForces():Forces {
        return this._enemyForces;
    }

    public function get isMyUserAttackedFirst():Boolean {
        return this._isMyUserAttackedFirst;
    }

    public function get allEnemyLosses():Number {
        return this._allEnemyLosses;
    }

    public function get allEnemyUnits():Number {
        return this._allEnemyUnits;
    }

    public function get allMyLosses():Number {
        return this._allMyLosses;
    }

    public function get allMyUnits():Number {
        return this._allMyUnits;
    }

    public function get isEnemyWon():Boolean {
        return this._battleData.isEnemyWon;
    }

    public function get allMyUnitsVO():Vector.<UnitVO> {
        return this._battleData.myUnitsVO;
    }

    public function get allEnemyUnitsVO():Vector.<UnitVO> {
        return this._battleData.enemyUnitsVO;
    }

    public function get cache():Object {
        return this._cacheVisualBattle.cache;
    }

    public function set cache(param1:Object):void {
        this._cacheVisualBattle.cache = param1;
    }

    public function get isPreCacheInitialized():Boolean {
        return !this._cacheVisualBattle.isEmptyCache();
    }

    public function addToCache(param1:int):void {
        this._cacheVisualBattle.add(param1);
    }

    public function initializeNew(param1:VisualBattleData):void {
        this._battleData = param1;
        if (this._battleData == null) {
            return;
        }
        this.initForces();
        this.selectUnitsToScene();
        this.addUnits();
        this.initUnitsInfo();
    }

    private function initForces():void {
        this._myForces = new Forces();
        this._myForces.updateLoadingProgressFn = this._updateloadingProgressFn;
        this._enemyForces = new Forces();
        this._enemyForces.updateLoadingProgressFn = this._updateloadingProgressFn;
        this._enemyForces.isEnemyUnits = true;
    }

    public function get enemyHeroURL():String {
        return this._battleData.enemyHero.heroUrl;
    }

    public function get myHeroURL():String {
        return this._battleData.myHero.heroUrl;
    }

    public function reset():void {
        this._myForces = null;
        this._enemyForces = null;
    }

    private function fillData():void {
        var _loc3_:UnitVO = null;
        var _loc4_:UnitVO = null;
        var _loc1_:Number = 0;
        var _loc2_:Number = 0;
        for each(_loc3_ in this._battleData.myUnitsVO) {
            _loc1_ = _loc1_ + _loc3_.count;
            _loc2_ = _loc2_ + _loc3_.losses;
        }
        this._myForces.totalUnits = _loc1_;
        this._myForces.totalLosses = _loc2_;
        _loc1_ = 0;
        _loc2_ = 0;
        for each(_loc4_ in this._battleData.enemyUnitsVO) {
            _loc1_ = _loc1_ + _loc4_.count;
            _loc2_ = _loc2_ + _loc4_.losses;
        }
        this._enemyForces.totalUnits = _loc1_;
        this._enemyForces.totalLosses = _loc2_;
    }

    private function shuffleVector(param1:Vector.<UnitVO>, param2:Number):void {
        var _loc5_:* = undefined;
        var _loc6_:int = 0;
        var _loc3_:Random = new Random(param2, param1.length);
        var _loc4_:int = 0;
        while (_loc4_ < param1.length) {
            _loc5_ = param1[_loc4_];
            _loc6_ = _loc3_.Next();
            param1[_loc4_] = param1[_loc6_];
            param1[_loc6_] = _loc5_;
            _loc4_++;
        }
        this.dragonsToTheEndOfArray(param1);
    }

    private function dragonsToTheEndOfArray(param1:Vector.<UnitVO>):void {
        var _loc4_:UnitVO = null;
        var _loc2_:Vector.<UnitVO> = new Vector.<UnitVO>();
        var _loc3_:int = param1.length - 1;
        while (_loc3_ >= 0) {
            if (this.isDragonType(param1[_loc3_].type)) {
                _loc2_.push(param1[_loc3_]);
                param1.splice(_loc3_, 1);
            }
            _loc3_--;
        }
        for each(_loc4_ in _loc2_) {
            param1.push(_loc4_);
        }
    }

    private function isDragonType(param1:int):Boolean {
        return param1 == TroopsTypeId.AirUnit1 || param1 == TroopsTypeId.AirUnit2 || param1 == TroopsTypeId.AirUnit3 || param1 == TroopsTypeId.AirUnit4;
    }

    private function addUnits():void {
        var _loc1_:UnitVO = null;
        var _loc2_:UnitVO = null;
        var _loc3_:ArrayCustom = null;
        var _loc4_:int = 0;
        var _loc5_:UnitUI = null;
        var _loc6_:UnitUI = null;
        this.fillData();
        this.shuffleVector(this._myUnitsSelected, getTimer());
        this.shuffleVector(this._enemyUnitsSelected, getTimer());
        for each(_loc1_ in this._myUnitsSelected) {
            this._myUnitsKilledAllDic[_loc1_.type] = _loc1_.count == _loc1_.losses;
            _loc5_ = new UnitUI(_loc1_.type);
            _loc5_.unitVO = _loc1_;
            this._myForces.add(_loc5_);
        }
        for each(_loc2_ in this._enemyUnitsSelected) {
            this._enemyUnitsKilledAllDic[_loc2_.type] = _loc2_.count == _loc2_.losses;
            _loc6_ = new UnitUI(_loc2_.type);
            _loc6_.unitVO = _loc2_;
            _loc6_.isEnemyView = true;
            this._enemyForces.add(_loc6_);
        }
        _loc3_ = UnitTypeValidator.getAllUnits();
        for each(_loc4_ in _loc3_) {
        }
        this.updateCache(this._myUnitsSelected, this._enemyUnitsSelected);
        this.startLoadingUnits();
    }

    private function checkFatalityStateLoading():void {
        var _loc1_:UnitUI = null;
        var _loc2_:UnitUI = null;
        if (this.isFatalityBattle) {
            if (this.isEnemyWon) {
                for each(_loc1_ in this._enemyForces.units) {
                    _loc1_.needFatalityState = true;
                }
            }
            else {
                for each(_loc2_ in this._myForces.units) {
                    _loc2_.needFatalityState = true;
                }
            }
        }
        else if (this.isExtendedFatality) {
            this.buildFatalityState();
        }
    }

    private function buildFatalityState():void {
        var _loc2_:int = 0;
        var _loc1_:int = !!this.isEnemyWon ? int(this._enemyForces.numberOfUnits) : int(this._myForces.numberOfUnits);
        if (_loc1_ == 1) {
            _loc2_ = VisualBattleConfig.TILE_ROWS / 2;
        }
        else {
            _loc2_ = (VisualBattleConfig.TILE_ROWS - _loc1_) / 2;
        }
        var _loc3_:int = TileGrid.CENTER_ROWS - _loc2_;
        if (this.isEnemyWon) {
            this._enemyForces.units[_loc3_].needFatalityState = true;
        }
        else {
            this._myForces.units[_loc3_].needFatalityState = true;
        }
    }

    private function updateCache(param1:Vector.<UnitVO>, param2:Vector.<UnitVO>):void {
        var _loc3_:Vector.<int> = new Vector.<int>();
        var _loc4_:int = 0;
        while (_loc4_ < param1.length) {
            _loc3_.push(param1[_loc4_].type);
            _loc4_++;
        }
        var _loc5_:int = 0;
        while (_loc5_ < param2.length) {
            _loc3_.push(param2[_loc5_].type);
            _loc5_++;
        }
        this._cacheVisualBattle.updateCache(_loc3_);
    }

    private function startLoadingUnits():void {
        this.checkFatalityStateLoading();
        var _loc1_:int = 0;
        this.successivelyLoading(this._myForces.units, _loc1_);
        this.successivelyLoading(this._enemyForces.units, _loc1_);
    }

    private function successivelyLoading(param1:Vector.<UnitUI>, param2:int):void {
        if (param2 > param1.length - 1) {
            return;
        }
        param1[param2].load();
        if (this._cacheVisualBattle.isCached(param1[param2].typeId)) {
            this.successivelyLoading(param1, param2 + 1);
        }
        else {
            setTimeout(this.successivelyLoading, VisualBattleConfig.DELAY_LOADING_MILISECONDS, param1, param2 + 1);
        }
    }

    public function getUnitVoById(param1:int, param2:Boolean = false):UnitVO {
        var _loc4_:UnitVO = null;
        var _loc3_:Vector.<UnitVO> = !!param2 ? this._battleData.enemyUnitsVO : this._battleData.myUnitsVO;
        for each(_loc4_ in _loc3_) {
            if (param1 == _loc4_.type) {
                return _loc4_;
            }
        }
        return null;
    }

    private function selectUnitsToScene():void {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        this._enemyUnitsSelected = new Vector.<UnitVO>(0);
        this._myUnitsSelected = new Vector.<UnitVO>(0);
        if (this._battleData.enemyUnitsVO.length > VisualBattleConfig.MAX_UNIT_COUNT) {
            _loc1_ = 0;
            while (_loc1_ < VisualBattleConfig.MAX_UNIT_COUNT) {
                if (this._battleData.enemyUnitsVO[_loc1_]) {
                    this._enemyUnitsSelected.push(this._battleData.enemyUnitsVO[_loc1_]);
                }
                _loc1_++;
            }
        }
        else {
            this._enemyUnitsSelected = this._battleData.enemyUnitsVO;
        }
        if (this._battleData.myUnitsVO.length > VisualBattleConfig.MAX_UNIT_COUNT) {
            _loc2_ = 0;
            while (_loc2_ < VisualBattleConfig.MAX_UNIT_COUNT) {
                this._myUnitsSelected.push(this._battleData.myUnitsVO[_loc2_]);
                _loc2_++;
            }
        }
        else {
            this._myUnitsSelected = this._battleData.myUnitsVO;
        }
    }

    public function clearCache():void {
        this._cacheVisualBattle.clear();
    }

    private function initUnitsInfo():void {
        var _loc1_:UnitVO = null;
        this._allMyUnits = 0;
        this._allMyLosses = 0;
        this._allEnemyLosses = 0;
        this._allEnemyUnits = 0;
        var _loc2_:int = 0;
        while (_loc2_ < this._battleData.myUnitsVO.length) {
            _loc1_ = this._battleData.myUnitsVO[_loc2_];
            this._allMyLosses = this._allMyLosses + _loc1_.losses;
            this._allMyUnits = this._allMyUnits + _loc1_.count;
            _loc2_++;
        }
        var _loc3_:int = 0;
        while (_loc3_ < this._battleData.enemyUnitsVO.length) {
            _loc1_ = this._battleData.enemyUnitsVO[_loc3_];
            this._allEnemyLosses = this._allEnemyLosses + _loc1_.losses;
            this._allEnemyUnits = this._allEnemyUnits + _loc1_.count;
            _loc3_++;
        }
    }

    public function get isFatalityBattle():Boolean {
        if (this.isEnemyWon) {
            return this._enemyForces.numberOfUnits <= 1 && this._myForces.numberOfUnits > 2;
        }
        return this._myForces.numberOfUnits <= 1 && this._enemyForces.numberOfUnits > 2;
    }

    public function get isExtendedFatality():Boolean {
        return new Randomizer(this._battleData.messageId, 1, 10).Next() == 5;
    }

    public function get myUnitsKilledAllDic():Dictionary {
        return this._myUnitsKilledAllDic;
    }
}
}
