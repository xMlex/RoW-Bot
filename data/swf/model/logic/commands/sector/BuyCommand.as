package model.logic.commands.sector {
import model.data.Resources;
import model.data.User;
import model.data.UserGameData;
import model.data.normalization.Normalizer;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.BuildingTypeId;
import model.data.scenes.types.info.TroopsTypeId;
import model.data.users.BuyStatus;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.enums.BlackMarketPackType;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.googleAnalytics.GoogleAnalyticsEventTracker;
import model.logic.googleAnalytics.conditions.ConditionNonDeposerOver30Lv;
import model.logic.googleAnalytics.conditions.user.ConditionExceptTotalDominationOnFB;
import model.logic.googleAnalytics.types.ActionType;
import model.logic.googleAnalytics.types.CategoryType;
import model.logic.googleAnalytics.types.LabelType;
import model.logic.ratings.TournamentBonusManager;

public class BuyCommand extends BaseCmd {


    private var _sceneObject:GeoSceneObject;

    private var _sceneObjectToUpdate:GeoSceneObject;

    private var _goldBuy:Boolean;

    private var _buyInstantly:Boolean;

    private var requestDto;

    public function BuyCommand(param1:GeoSceneObject, param2:GeoSceneObject = null, param3:Boolean = false, param4:Boolean = false) {
        super();
        this._sceneObject = param1;
        this._sceneObjectToUpdate = param2 != null ? param2 : param1;
        this._goldBuy = param3;
        this._buyInstantly = param4;
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "o": this._sceneObject.toDto(),
            "g": this._goldBuy,
            "n": this._buyInstantly
        });
    }

    private static function utilize(param1:User, param2:GeoSceneObject):void {
        var _loc3_:UserGameData = param1.gameData;
        var _loc4_:GeoSceneObjectType = _loc3_.getRequiredDrawingType(param2.objectType);
        if (_loc4_ == null) {
            return;
        }
        var _loc5_:GeoSceneObject = _loc3_.drawingArchive.getDrawing(_loc4_.id);
        if (_loc5_ == null || !_loc5_.drawingInfo.isCollected()) {
            throw new Error("Could not find required drawing or drawing is not completed");
        }
        _loc5_.drawingInfo.utilize();
        _loc3_.drawingArchive.raiseDrawingPartsChanged();
    }

    override public function execute():void {
        this.googleAnalyticsTrack(this._sceneObject);
        new JsonCallCmd("Buy", this.requestDto, "POST").ifResult(function (param1:*):void {
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
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = param1.o.i;
                _loc3_ = param1.o.t == null ? null : new Date(param1.o.t);
                _loc4_ = param1.o.f == null ? null : new Date(param1.o.f);
                _loc5_ = Resources.fromDto(param1.o.p);
                _sceneObjectToUpdate.id = _loc2_;
                if (_sceneObjectToUpdate.buildingInfo != null || _sceneObjectToUpdate.technologyInfo != null) {
                    _sceneObjectToUpdate.constructionObjInfo.constructionStartTime = _loc3_;
                    _sceneObjectToUpdate.constructionObjInfo.constructionFinishTime = _loc4_;
                    _sceneObjectToUpdate.buyStatus = BuyStatus.OBJECT_OF_SAME_GROUP_IN_PROGRESS;
                }
                if (_sceneObjectToUpdate.type && (_sceneObjectToUpdate.type.id == BuildingTypeId.FinancialCorporation || _sceneObjectToUpdate.type.id == BuildingTypeId.BuildingIdHospital)) {
                    _loc6_ = StaticDataManager.getObjectType(_sceneObjectToUpdate.type.id);
                    _loc7_ = _sceneObjectToUpdate.getNextLevel();
                    _loc8_ = UserManager.user.gameData.getBuildingUpgradeBonus(_loc6_, _loc7_);
                    if (_loc8_ != -1) {
                        UserManager.user.gameData.blackMarketData.boughtCountByItemPackId[BlackMarketPackType.UPGRADE_BUILDING] = UserManager.user.gameData.blackMarketData.boughtCountByItemPackId[BlackMarketPackType.UPGRADE_BUILDING] - _loc8_;
                        UserManager.user.gameData.blackMarketData.dirty = true;
                    }
                }
                if (_sceneObjectToUpdate.type && _sceneObjectToUpdate.type.id == BuildingTypeId.LogisticsCenter) {
                    _loc9_ = _sceneObjectToUpdate.getSaleableLevelInfo().constructionBlockPrize;
                    UserManager.user.gameData.invitationData.constructionBlockCount = UserManager.user.gameData.invitationData.constructionBlockCount - _loc9_;
                }
                if (_sceneObjectToUpdate.type.id == BuildingTypeId.RobotRepair && UserManager.user.gameData.constructionData.currentRepariRobotsCount < _sceneObjectToUpdate.objectType.saleableInfo.limit) {
                    UserManager.user.gameData.constructionData.currentRepariRobotsCount++;
                }
                if (_sceneObjectToUpdate.technologyInfo != null) {
                    if (_sceneObject.constructionInfo.level == 0) {
                        utilize(UserManager.user, _sceneObjectToUpdate);
                    }
                    UserManager.user.gameData.technologyCenter.recalcTechnologies();
                    _loc6_ = StaticDataManager.getObjectType(_sceneObjectToUpdate.type.id);
                    _loc7_ = _sceneObjectToUpdate.getNextLevel();
                    _loc10_ = UserManager.user.gameData.getTechnologyUpgradeBonus(_loc6_, _loc7_);
                    if (_loc10_ != null) {
                        _loc11_ = !!_loc10_.isHighLevel ? BlackMarketPackType.UPGRADE_TECHNOLOGY_02 : BlackMarketPackType.UPGRADE_TECHNOLOGY_01;
                        UserManager.user.gameData.blackMarketData.boughtCountByItemPackId[_loc11_] = UserManager.user.gameData.blackMarketData.boughtCountByItemPackId[_loc11_] - _loc10_.requiredItemsCount;
                        UserManager.user.gameData.blackMarketData.dirty = true;
                    }
                }
                if (_sceneObjectToUpdate.buildingInfo != null) {
                    UserManager.user.gameData.sector.recalcBuildings();
                }
                if (_sceneObjectToUpdate.troopsInfo != null) {
                    UserManager.user.gameData.troopsData.troopsFactory.addOrder(_sceneObjectToUpdate.type as GeoSceneObjectType, _sceneObjectToUpdate.troopsInfo.count, _loc3_, _loc4_);
                }
                if (_sceneObjectToUpdate.drawingInfo != null) {
                    UserManager.user.gameData.resetBuyStatusBySceneObject();
                }
                UserManager.user.gameData.account.resources.substract(_loc5_);
                if (_sceneObjectToUpdate.type.id == TroopsTypeId.InfantryUnit1 || _sceneObjectToUpdate.type.id == TroopsTypeId.InfantryUnit1Gold) {
                    UserManager.user.gameData.constructionData.buildTrooperFaster = false;
                }
                if (_sceneObjectToUpdate.type.id == TroopsTypeId.InfantryUnit2 || _sceneObjectToUpdate.type.id == TroopsTypeId.InfantryUnit2Gold) {
                    UserManager.user.gameData.constructionData.buildDogFaster = false;
                }
                if (_sceneObjectToUpdate.type.id == TroopsTypeId.AirUnit1 || _sceneObjectToUpdate.type.id == TroopsTypeId.AirUnit1Gold) {
                    UserManager.user.gameData.constructionData.buildReconFaster = false;
                }
                TournamentBonusManager.applyUserPointsDiff(param1.o.g);
                Normalizer.normalize(UserManager.user);
                UserManager.user.gameData.constructionData.availableWorkersChanged = true;
            }
            if (_onResult != null) {
                _onResult(_sceneObjectToUpdate);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }

    private function googleAnalyticsTrack(param1:GeoSceneObject):void {
        var _loc2_:String = null;
        if (!param1) {
            return;
        }
        var _loc3_:Number = param1.objectType.id;
        if (param1.buildingInfo) {
            _loc2_ = LabelType.BUILDING;
        }
        else if (param1.technologyInfo) {
            _loc2_ = LabelType.TECHNOLOGY;
        }
        else if (param1.troopsInfo) {
            _loc2_ = LabelType.UNITS;
            _loc3_ = param1.troopsInfo.count;
        }
        else {
            return;
        }
        var _loc4_:String = param1.constructionInfo.level > 0 ? ActionType.UPGRADED : ActionType.CONSTRUCTED;
        new GoogleAnalyticsEventTracker(CategoryType.NON_DEPOSER_OVER_30_LV, _loc4_, _loc2_, _loc3_).condition(new ConditionNonDeposerOver30Lv()).condition(new ConditionExceptTotalDominationOnFB()).track();
    }
}
}
