package model.logic.commands.sector {
import common.ArrayCustom;
import common.GameType;

import configs.Global;

import model.data.Resources;
import model.data.User;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.TroopsGroupId;
import model.data.users.drawings.DrawingPart;
import model.data.users.misc.UserBlackMarketData;
import model.data.users.technologies.TechnologyCenter;
import model.data.users.troops.Troops;
import model.logic.BlackMarketTroopsType;
import model.logic.StaticBlackMarketData;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.UserStatsManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.quests.completions.QuestCompletionPeriodic;
import model.logic.quests.periodicQuests.ComplexSource;
import model.logic.quests.periodicQuests.enums.PeriodicQuestPrototypeId;
import model.logic.ratings.TournamentBonusManager;
import model.logic.troops.TroopsManager;
import model.logic.units.UnitUtility;

public class BuyBlackMarketOfferCmd extends BaseCmd {


    private var requestDto;

    private var _sotId:int;

    private var _number:int;

    private var _building:GeoSceneObject;

    public function BuyBlackMarketOfferCmd(param1:int, param2:int = -1, param3:GeoSceneObject = null, param4:int = -1, param5:int = -1) {
        super();
        this._sotId = param1;
        this._number = param2;
        this._building = param3;
        this.requestDto = UserRefreshCmd.makeRequestDto({"i": this._sotId});
        if (param2 != -1) {
            this.requestDto.o.n = this._number;
        }
        if (param4 != -1 && param5 != -1) {
            this.requestDto.o.x = param4;
            this.requestDto.o.y = param5;
            this.requestDto.o.m = param3.isMirrored;
        }
        if (GameType.isSparta && param3) {
            this.requestDto.o.s = param3.slotId;
        }
    }

    public static function getPrice(param1:int):Resources {
        var _loc3_:StaticBlackMarketData = null;
        var _loc4_:BlackMarketTroopsType = null;
        var _loc2_:GeoSceneObjectType = StaticDataManager.getObjectType(param1);
        if (Global.SELL_NEAREST_NEEDED_DRAWINGS_ENABLED && _loc2_ && _loc2_.drawingInfo && _loc2_.drawingInfo.pricePerPart) {
            return _loc2_.drawingInfo.pricePerPart;
        }
        if (_loc2_.drawingInfo != null) {
            _loc3_ = StaticDataManager.blackMarketData;
            if (_loc3_.priceByTechnologyId[param1 - 100] != null) {
                return Resources.fromGoldMoney(_loc3_.priceByTechnologyId[param1 - 100]);
            }
        }
        if (_loc2_.troopsInfo != null) {
            for each(_loc4_ in StaticDataManager.blackMarketData.troopTypes) {
                if (param1 == _loc4_.troopsTypeId) {
                    return _loc4_.price.roundAll();
                }
            }
        }
        if (_loc2_.buildingInfo != null) {
            return Resources.fromGoldMoney(_loc2_.saleableInfo.getLevelInfo(1).price.goldMoney);
        }
        return null;
    }

    public static function getAvailableTechnologies():ArrayCustom {
        if (Global.SELL_NEAREST_NEEDED_DRAWINGS_ENABLED) {
            return where(nearestAvailableTechnjlogies, function (param1:GeoSceneObjectType):Boolean {
                return getPrice(param1.id + 100).blackCrystals == 0;
            });
        }
        return allAvailableTechnologies;
    }

    public static function getBlackCrystalAllTechnologies():ArrayCustom {
        var tech:GeoSceneObject = null;
        var requiresDrawings:Boolean = false;
        var user:User = UserManager.user;
        var result:ArrayCustom = new ArrayCustom();
        var i:int = 0;
        while (i < user.gameData.technologyCenter.technologies.length) {
            tech = user.gameData.technologyCenter.technologies[i] as GeoSceneObject;
            requiresDrawings = TechnologyCenter.technologyRequiresDrawings(tech.objectType);
            if (requiresDrawings && tech.getLevel() == 0 && !tech.buildingInProgress) {
                result.addItem(tech.objectType);
            }
            i++;
        }
        return where(result, function (param1:GeoSceneObjectType):Boolean {
            if (getPrice(param1.id + 100)) {
                return getPrice(param1.id + 100).blackCrystals > 0;
            }
            return false;
        });
    }

    public static function getBlackCrystalAvailableTechnologies():ArrayCustom {
        if (Global.SELL_NEAREST_NEEDED_DRAWINGS_ENABLED) {
            return where(nearestAvailableTechnjlogies, function (param1:GeoSceneObjectType):Boolean {
                return getPrice(param1.id + 100).blackCrystals > 0;
            });
        }
        return allAvailableTechnologies;
    }

    private static function get nearestAvailableTechnjlogies():ArrayCustom {
        var _loc5_:GeoSceneObjectType = null;
        var _loc1_:User = UserManager.user;
        var _loc2_:ArrayCustom = new ArrayCustom();
        var _loc3_:StaticBlackMarketData = StaticDataManager.blackMarketData;
        var _loc4_:ArrayCustom = _loc1_.gameData.technologyCenter.GetNearestUnlearnedTechnologiesWithDrawings();
        for each(_loc5_ in _loc4_) {
            if (_loc3_.closedDrawingsTechnologyIds) {
                if (_loc3_.closedDrawingsTechnologyIds.indexOf(_loc5_.id) == -1) {
                    _loc2_.addItem(_loc5_);
                }
            }
            else {
                _loc2_.addItem(_loc5_);
            }
        }
        return _loc2_;
    }

    private static function get allAvailableTechnologies():ArrayCustom {
        var _loc4_:GeoSceneObjectType = null;
        var _loc5_:int = 0;
        var _loc6_:GeoSceneObject = null;
        var _loc7_:* = false;
        var _loc8_:Boolean = false;
        var _loc1_:User = UserManager.user;
        var _loc2_:ArrayCustom = new ArrayCustom();
        var _loc3_:ArrayCustom = _loc1_.gameData.technologyCenter.GetNearestUnlearnedTechnologiesWithDrawings();
        for each(_loc4_ in _loc3_) {
            if (StaticDataManager.blackMarketData.priceByTechnologyId[_loc4_.id] != null) {
                _loc2_.addItem(_loc4_);
            }
        }
        _loc5_ = _loc1_.gameData.technologyCenter.technologies.length - 1;
        while (_loc5_ > 0) {
            _loc6_ = _loc1_.gameData.technologyCenter.technologies[_loc5_] as GeoSceneObject;
            _loc7_ = StaticDataManager.blackMarketData.priceByTechnologyId[_loc6_.objectType.id] != null;
            _loc8_ = TechnologyCenter.technologyRequiresDrawings(_loc6_.objectType);
            if (_loc7_ && _loc8_ && (_loc6_.getLevel() > 0 || _loc6_.buildingInProgress)) {
                _loc2_.addItem(_loc6_.objectType);
            }
            _loc5_--;
        }
        return _loc2_;
    }

    public static function getCurrentDefensiveTechLevel():int {
        var _loc6_:GeoSceneObject = null;
        var _loc1_:User = UserManager.user;
        if (GameType.isTotalDomination) {
            _loc6_ = _loc1_.gameData.technologyCenter.getTechnology(1089);
            if (_loc6_.getLevel() > 0 || _loc6_.buildingInProgress) {
                return 5;
            }
        }
        var _loc2_:GeoSceneObject = _loc1_.gameData.technologyCenter.getTechnology(1075);
        if (_loc2_.getLevel() > 0 || _loc2_.buildingInProgress) {
            return 4;
        }
        var _loc3_:GeoSceneObject = _loc1_.gameData.technologyCenter.getTechnology(1074);
        if (_loc3_.getLevel() > 0 || _loc3_.buildingInProgress) {
            return 3;
        }
        var _loc4_:GeoSceneObject = _loc1_.gameData.technologyCenter.getTechnology(1073);
        if (_loc4_.getLevel() > 0 || _loc4_.buildingInProgress) {
            return 2;
        }
        var _loc5_:GeoSceneObject = _loc1_.gameData.technologyCenter.getTechnology(1072);
        if (_loc5_.getLevel() > 0 || _loc5_.buildingInProgress) {
            return 1;
        }
        return 0;
    }

    public static function getBuildingIdsAvailable():Array {
        var _loc1_:int = getCurrentDefensiveTechLevel();
        return StaticDataManager.blackMarketData.defensiveBuildingTypeIdsByLevel[_loc1_];
    }

    public static function canBuyBuilding(param1:int):Boolean {
        var _loc2_:User = UserManager.user;
        var _loc3_:StaticBlackMarketData = StaticDataManager.blackMarketData;
        if (_loc2_.gameData.account.level < _loc3_.buildingsMinimalUserLevel) {
            return false;
        }
        if (_loc2_.gameData.blackMarketData.buildingsPurchasesCount >= _loc3_.buildingsPurchasesDailyLimit) {
            return false;
        }
        if (_loc3_.totalLimitBySceneObjectTypeId[param1] == null) {
            return false;
        }
        var _loc4_:int = _loc2_.gameData.blackMarketData.boughtCountBySceneObjectTypeId[param1] == null ? 0 : int(_loc2_.gameData.blackMarketData.boughtCountBySceneObjectTypeId[param1]);
        if (_loc4_ >= _loc3_.totalLimitBySceneObjectTypeId[param1]) {
            return false;
        }
        return true;
    }

    private static function BuyBuildingOffer(param1:User, param2:GeoSceneObject, param3:Number):void {
        param2.id = param3;
        param2.constructionInfo.level = 1;
        param2.constructionInfo.constructionStartTime = null;
        param2.constructionInfo.constructionFinishTime = null;
        var _loc4_:UserBlackMarketData = param1.gameData.blackMarketData;
        var _loc5_:int = param2.objectType.id;
        _loc4_.buildingsPurchasesCount++;
        if (_loc4_.boughtCountBySceneObjectTypeId[_loc5_] == null) {
            _loc4_.boughtCountBySceneObjectTypeId[_loc5_] = 1;
        }
        else {
            _loc4_.boughtCountBySceneObjectTypeId[_loc5_]++;
        }
    }

    private static function BuyTroopsOffer(param1:User, param2:int, param3:int):void {
        var _loc4_:Troops = new Troops();
        _loc4_.countByType[param2] = param3;
        var _loc5_:GeoSceneObjectType = StaticDataManager.getObjectType(param2);
        if (_loc5_.troopsInfo.groupId != TroopsGroupId.MISSILE) {
            UnitUtility.AddTroopsToBunker(param1, _loc4_);
        }
        else {
            param1.gameData.troopsData.missileStorage.addTroops(_loc4_);
        }
        if (_loc5_.troopsInfo.supportParameters != null) {
            param1.gameData.blackMarketData.strategyTroopsPurchasesCount++;
        }
        else {
            param1.gameData.blackMarketData.troopsPurchasesCount++;
            UserStatsManager.troopsBuilt(param1, _loc4_);
        }
    }

    private static function BuyDrawingOffer(param1:User, param2:int, param3:int):void {
        var _loc4_:DrawingPart = new DrawingPart();
        _loc4_.typeId = param2;
        _loc4_.part = param3;
        param1.gameData.drawingArchive.addDrawingPart(_loc4_);
        if (getPrice(param2).blackCrystals == 0) {
            param1.gameData.blackMarketData.drawingsPurchasesCount++;
        }
    }

    public static function where(param1:ArrayCustom, param2:Function):ArrayCustom {
        var _loc4_:* = undefined;
        var _loc3_:ArrayCustom = new ArrayCustom();
        for each(_loc4_ in param1) {
            if (param2(_loc4_)) {
                _loc3_.addItem(_loc4_);
            }
        }
        return _loc3_;
    }

    public function set sotId(param1:int):void {
        this._sotId = param1;
    }

    public function get sotId():int {
        return this._sotId;
    }

    public function set count(param1:int):void {
        this._number = param1;
    }

    public function get count():int {
        return this._number;
    }

    override public function execute():void {
        new JsonCallCmd("BlackMarket.Buy", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = UserManager.user;
            var _loc3_:* = StaticDataManager.getObjectType(_sotId);
            var _loc4_:* = param1.o != null && param1.o.p != null ? Resources.fromDto(param1.o.p) : getPrice(_sotId);
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                if (_loc3_.drawingInfo != null) {
                    BuyDrawingOffer(_loc2_, _sotId, _number);
                }
                else if (_loc3_.troopsInfo != null) {
                    BuyTroopsOffer(_loc2_, _sotId, _number);
                    TroopsManager.refreshAllianceMissionData(_loc3_, _number);
                    QuestCompletionPeriodic.tryComplete(ComplexSource.fromTroopsType(_sotId, _number), [PeriodicQuestPrototypeId.TrainTroops]);
                }
                else if (_loc3_.buildingInfo != null) {
                    BuyBuildingOffer(_loc2_, _building, param1.o.i);
                    QuestCompletionPeriodic.tryComplete(ComplexSource.fromSceneObject(_building), [PeriodicQuestPrototypeId.BuildBuilding]);
                }
                _loc2_.gameData.questData.addCollectibleItemsFromBMI(_loc4_.goldMoney);
                _loc2_.gameData.account.resources.substract(_loc4_);
                _loc2_.gameData.blackMarketData.dirty = true;
                _loc2_.gameData.resetBuyStatusBySceneObject();
                _loc2_.gameData.updateObjectsBuyStatus(true);
            }
            TournamentBonusManager.applyUserPointsDiff(param1.o.g);
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
