package model.logic.blackMarketModel {
import common.ArrayCustom;
import common.GameType;

import configs.Global;

import model.data.SectorSkinType;
import model.logic.BlackMarketTroopsType;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketItems.BlackMarketItemsNode;
import model.logic.blackMarketModel.dataAdapters.BuildingAdapter;
import model.logic.blackMarketModel.dataAdapters.CaravansCapacityBoostAdapter;
import model.logic.blackMarketModel.dataAdapters.DrawingAdapter;
import model.logic.blackMarketModel.dataAdapters.ExtraFavoriteUsersBoostAdapter;
import model.logic.blackMarketModel.dataAdapters.NanopodAdapter;
import model.logic.blackMarketModel.dataAdapters.SaleConsumptionAdapter;
import model.logic.blackMarketModel.dataAdapters.SkinTypeAdapter;
import model.logic.blackMarketModel.dataAdapters.UnitAdapter;
import model.logic.commands.sector.BuyBlackMarketOfferCmd;

public class BlackMarketDataInitializer {

    private static var _skinAdapter:SkinTypeAdapter;

    private static var _unitAdapter:UnitAdapter;

    private static var _buildingAdapter:BuildingAdapter;

    private static var _drawingAdapter:DrawingAdapter;

    private static var _nanopodAdapter:NanopodAdapter;

    private static var _favoriteBoostAdapter:ExtraFavoriteUsersBoostAdapter;

    private static var _caravansAdapter:CaravansCapacityBoostAdapter;

    private static var _saleConsumptionAdapter:SaleConsumptionAdapter;


    public function BlackMarketDataInitializer() {
        super();
    }

    public static function initialize():void {
        initializeCtors();
        initializeSectorSkinTypes();
        initializeUnits();
        initializeBuildings();
        initializeDrawings();
        initializeNanopods();
        initializeFavoriteBoosts();
        initializeCaravans();
        initializeConsumptions();
        initializeConstructionPoints();
    }

    private static function initializeCtors():void {
        _skinAdapter = new SkinTypeAdapter();
        _unitAdapter = new UnitAdapter();
        _buildingAdapter = new BuildingAdapter();
        _drawingAdapter = new DrawingAdapter();
        _nanopodAdapter = new NanopodAdapter();
        _favoriteBoostAdapter = new ExtraFavoriteUsersBoostAdapter();
        _caravansAdapter = new CaravansCapacityBoostAdapter();
        _saleConsumptionAdapter = new SaleConsumptionAdapter();
    }

    private static function addWithNullCheck(param1:BlackMarketItemRaw):void {
        if (param1 != null) {
            StaticDataManager.blackMarketData.items.push(param1);
        }
    }

    private static function initializeSectorSkinTypes():void {
        var _loc3_:SectorSkinType = null;
        var _loc4_:BlackMarketItemRaw = null;
        var _loc1_:ArrayCustom = StaticDataManager.getSectorSkinTypes();
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_.length) {
            _loc3_ = _loc1_[_loc2_] as SectorSkinType;
            _loc4_ = _skinAdapter.adapt(_loc3_);
            addWithNullCheck(_loc4_);
            _loc2_++;
        }
    }

    private static function initializeUnits():void {
        var _loc3_:BlackMarketTroopsType = null;
        var _loc4_:BlackMarketItemRaw = null;
        var _loc1_:ArrayCustom = StaticDataManager.blackMarketData.troopTypes;
        var _loc2_:int = 0;
        while (_loc2_ < StaticDataManager.blackMarketData.troopTypes.length) {
            _loc3_ = _loc1_[_loc2_] as BlackMarketTroopsType;
            _loc4_ = _unitAdapter.adapt(_loc3_);
            addWithNullCheck(_loc4_);
            _loc2_++;
        }
    }

    private static function initializeBuildings():void {
        var _loc3_:Array = null;
        var _loc4_:int = 0;
        var _loc5_:BlackMarketItemRaw = null;
        var _loc1_:Array = StaticDataManager.blackMarketData.defensiveBuildingTypeIdsByLevel;
        if (!_loc1_) {
            return;
        }
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_.length) {
            _loc3_ = _loc1_[_loc2_] as Array;
            _loc4_ = 0;
            while (_loc4_ < _loc3_.length) {
                _loc5_ = _buildingAdapter.adapt(_loc3_[_loc4_]);
                if (_loc5_) {
                    _loc5_.buildingTechLevel = _loc2_;
                    addWithNullCheck(_loc5_);
                }
                _loc4_++;
            }
            _loc2_++;
        }
    }

    private static function initializeDrawings():void {
        var _loc4_:BlackMarketItemRaw = null;
        var _loc1_:Array = BuyBlackMarketOfferCmd.getAvailableTechnologies();
        var _loc2_:Array = BuyBlackMarketOfferCmd.getBlackCrystalAllTechnologies();
        if (Global.BLACK_CRYSTALS_ENABLED && _loc2_ && _loc2_.length > 0) {
            _loc1_ = _loc1_.concat(_loc2_);
        }
        var _loc3_:int = 0;
        while (_loc3_ < _loc1_.length) {
            _loc4_ = _drawingAdapter.adapt(_loc1_[_loc3_]);
            addWithNullCheck(_loc4_);
            _loc3_++;
        }
    }

    private static function initializeNanopods():void {
        var _loc1_:BlackMarketItemRaw = _nanopodAdapter.adapt();
        addWithNullCheck(_loc1_);
    }

    private static function initializeFavoriteBoosts():void {
        var _loc3_:BlackMarketItemRaw = null;
        var _loc1_:Array = StaticDataManager.blackMarketData.extraFavoriteUsersBoosts;
        if (!_loc1_) {
            return;
        }
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_.length) {
            _loc3_ = _favoriteBoostAdapter.adapt(_loc1_[_loc2_]);
            addWithNullCheck(_loc3_);
            _loc2_++;
        }
    }

    private static function initializeCaravans():void {
        var _loc3_:BlackMarketItemRaw = null;
        if (GameType.isTotalDomination) {
            return;
        }
        var _loc1_:Array = StaticDataManager.blackMarketData.caravansCapacityBoosts;
        if (!_loc1_) {
            return;
        }
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_.length) {
            _loc3_ = _caravansAdapter.adapt(_loc1_[_loc2_]);
            addWithNullCheck(_loc3_);
            _loc2_++;
        }
    }

    private static function initializeConsumptions():void {
        var _loc1_:Vector.<BlackMarketItemRaw> = _saleConsumptionAdapter.getSaleConsumptionData();
        if (!_loc1_) {
            return;
        }
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_.length) {
            addWithNullCheck(_loc1_[_loc2_]);
            StaticDataManager.blackMarketData.itemsById[_loc1_[_loc2_].id] = _loc1_[_loc2_];
            _loc2_++;
        }
    }

    private static function initializeConstructionPoints():void {
        var _loc1_:BlackMarketItemsNode = null;
        if (StaticDataManager.blackMarketData.itemsById[1600] == null) {
            return;
        }
        if (UserManager.user.gameData.invitationData) {
            _loc1_ = new BlackMarketItemsNode();
            _loc1_.paidCount = UserManager.user.gameData.invitationData.constructionBlockCount;
            UserManager.user.gameData.blackMarketData.boughtItems[1600] = _loc1_;
        }
    }
}
}
