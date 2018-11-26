package model.logic.commands.sector {
import common.ArrayCustom;
import common.DateUtil;
import common.GameType;

import configs.Global;

import flash.utils.Dictionary;

import integration.SocialNetworkIdentifier;

import model.data.Resources;
import model.data.User;
import model.data.UserGameData;
import model.data.acceleration.types.BoostTypeId;
import model.data.acceleration.types.ResourceConsumptionBonusBoostType;
import model.data.acceleration.types.ResourceMiningBoostType;
import model.data.normalization.Normalizer;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.scenes.types.info.SaleableLevelInfo;
import model.data.scenes.types.info.TroopsTypeId;
import model.data.users.UserAccount;
import model.data.users.acceleration.ConstructionData;
import model.data.users.troops.TroopsFactory;
import model.data.users.troops.TroopsOrder;
import model.data.users.troops.TroopsTierObjLevelInfo;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.quests.data.QuestState;
import model.logic.skills.data.Skill;
import model.modules.allianceHelp.data.user.UserAllianceHelpData;
import model.modules.allianceHelp.data.user.UserAllianceHelpRequest;
import model.modules.dragonAbilities.data.Ability;

public class BuyBoostCmd extends BaseCmd {

    public static const TIME_FREE_BOOST:int = 5;

    private static var isPiratesPortal:Boolean = GameType.isPirates && (SocialNetworkIdentifier.isSZ || SocialNetworkIdentifier.isPortalClusters);

    private static var earlyIncubatorUnits:Array = [TroopsTypeId.EarlyIncubatorUnit1, TroopsTypeId.EarlyIncubatorUnit1Gold, TroopsTypeId.EarlyIncubatorUnit2, TroopsTypeId.EarlyIncubatorUnit2Gold, TroopsTypeId.EarlyIncubatorUnit3, TroopsTypeId.EarlyIncubatorUnit3Gold, TroopsTypeId.EarlyIncubatorUnit4, TroopsTypeId.EarlyIncubatorUnit4Gold];


    private var _boostTypeId:int;

    private var _objectId:Number;

    private var _resourceBoostPercentage:Number;

    private var _boostAutoRenewal:Boolean;

    private var _itemId:int;

    private var _activatedItemCount:int;

    private var requestDto;

    public function BuyBoostCmd(param1:int, param2:Number = -1, param3:int = -1, param4:Boolean = false, param5:int = 0, param6:int = 1) {
        var _loc8_:Object = null;
        super();
        this.requestDto = null;
        this._boostTypeId = param1;
        this._objectId = param2;
        this._resourceBoostPercentage = param3;
        this._boostAutoRenewal = param4;
        this._itemId = param5;
        this._activatedItemCount = param6;
        var _loc7_:* = {};
        _loc7_.t = this._boostTypeId;
        if (this._objectId != -1) {
            _loc7_.i = this._objectId;
            if (this._boostTypeId == BoostTypeId.INSTANT_BUILDING) {
                _loc8_ = UserManager.user.gameData.sector.getBuilding(this._objectId);
            }
            else if (this._boostTypeId == BoostTypeId.INSTANT_TECHNOLOGY) {
                _loc8_ = UserManager.user.gameData.technologyCenter.getTechnology(this._objectId as int);
            }
            else if (this._boostTypeId == BoostTypeId.INSTANT_ITEM_POWDERING || this._boostTypeId == BoostTypeId.INSTANT_ITEM_UPGRADE) {
                _loc8_ = UserManager.user.gameData.inventoryData.inventoryItemsById[this._objectId];
            }
            else if (this._boostTypeId == BoostTypeId.DRAGON_ABILITY) {
                _loc8_ = UserManager.user.gameData.dragonData.getAbilityById(this._objectId);
            }
            else if (this._boostTypeId == BoostTypeId.INSTANT_TROOPS_TIER_UPGRADE) {
                _loc8_ = UserManager.user.gameData.troopsData.tiersLevelInfoByTierId[this._objectId];
            }
            if (this._boostTypeId != BoostTypeId.INSTANT_TROOPS_ORDER && this._boostTypeId != BoostTypeId.INSTANT_TROOPS_QUEUE && this._boostTypeId != BoostTypeId.INSTANT_TROOPS_QUEUE_AVAILABLE && this._boostTypeId != BoostTypeId.DAILY_QUEST && this._boostTypeId != BoostTypeId.INSTANT_SKILL && this._boostTypeId != BoostTypeId.INSTANT_ITEM_POWDERING && this._boostTypeId != BoostTypeId.DRAGON_ABILITY && this._boostTypeId != BoostTypeId.INSTANT_TROOPS_TIER_UPGRADE && this._boostTypeId != BoostTypeId.INSTANT_ITEM_UPGRADE) {
                _loc7_.l = (_loc8_ as GeoSceneObject).getLevel() + 1;
            }
        }
        if (param5 > 0) {
            _loc7_.b = param5;
        }
        if (this._resourceBoostPercentage != -1) {
            _loc7_.r = this._resourceBoostPercentage;
        }
        _loc7_.a = this._boostAutoRenewal;
        _loc7_.c = this._activatedItemCount;
        _loc7_.f = Global.FREE_BOOST_ENABLED;
        this.requestDto = UserRefreshCmd.makeRequestDto(_loc7_);
    }

    public static function getInstantObjectPrice(param1:User, param2:int, param3:Number, param4:Boolean = false):Resources {
        var _loc9_:TroopsFactory = null;
        var _loc10_:TroopsOrder = null;
        var _loc11_:Number = NaN;
        var _loc12_:Number = NaN;
        var _loc13_:TroopsFactory = null;
        var _loc14_:TroopsOrder = null;
        var _loc15_:GeoSceneObjectType = null;
        var _loc16_:GeoSceneObject = null;
        var _loc17_:Number = NaN;
        var _loc18_:Number = NaN;
        var _loc19_:Number = NaN;
        var _loc20_:Number = NaN;
        var _loc21_:TroopsFactory = null;
        var _loc22_:Array = null;
        var _loc23_:UserAccount = null;
        var _loc24_:Resources = null;
        var _loc25_:int = 0;
        var _loc26_:TroopsOrder = null;
        var _loc27_:GeoSceneObject = null;
        var _loc28_:Number = NaN;
        var _loc29_:Number = NaN;
        var _loc30_:Number = NaN;
        var _loc31_:Skill = null;
        var _loc32_:Number = NaN;
        var _loc33_:Ability = null;
        var _loc34_:Date = null;
        var _loc35_:Number = NaN;
        var _loc36_:TroopsTierObjLevelInfo = null;
        var _loc37_:Number = NaN;
        var _loc38_:Boolean = false;
        var _loc39_:int = 0;
        var _loc40_:SaleableLevelInfo = null;
        var _loc41_:GeoSceneObjectType = null;
        var _loc42_:Boolean = false;
        var _loc43_:int = 0;
        var _loc44_:SaleableLevelInfo = null;
        if (param2 == BoostTypeId.INSTANT_TROOPS_ORDER) {
            if (GameType.isNords && !param4) {
                _loc9_ = param1.gameData.troopsData.troopsFactory;
                _loc10_ = _loc9_.getOrder(param3);
                _loc11_ = StaticDataManager.getObjectType(_loc10_.typeId).saleableInfo.getLevelInfo(1).constructionSeconds * 1000;
                _loc12_ = (_loc10_.constructionInfo.constructionStartTime.time + _loc11_ * _loc10_.pendingCount - ServerTimeManager.serverTimeNow.time) / 1000 / 60;
                if (_loc12_ <= TIME_FREE_BOOST) {
                    return new Resources();
                }
            }
            if (!GameType.isElves && !GameType.isMilitary && !GameType.isSparta && !GameType.isNords && !isPiratesPortal) {
                return StaticDataManager.instantTroopsOrderPrice;
            }
            _loc13_ = param1.gameData.troopsData.troopsFactory;
            _loc14_ = _loc13_.getOrder(param3);
            if (_loc14_ != null) {
                _loc15_ = StaticDataManager.getObjectType(_loc14_.typeId);
                _loc16_ = UserManager.user.gameData.buyingData.getBuyingObject(_loc15_);
                _loc17_ = UserManager.user.gameData.getConstructionSecondsWithoutEffects(_loc16_) * 1000;
                _loc18_ = (_loc14_.constructionInfo.constructionStartTime.time + _loc17_ * _loc14_.pendingCount - ServerTimeManager.serverTimeNow.time) / 1000 / 60 / 60;
                _loc19_ = earlyIncubatorUnits.lastIndexOf(_loc14_.typeId) != -1 ? Number(22) : Number(StaticDataManager.instantTroopsOrderPricePerHour);
                _loc20_ = _loc18_ * _loc19_;
                if (_loc20_ < StaticDataManager.instantTroopsOrderMinPrice) {
                    _loc20_ = StaticDataManager.instantTroopsOrderMinPrice;
                }
                return Resources.fromGoldMoney(_loc20_);
            }
        }
        else if (param2 == BoostTypeId.INSTANT_TROOPS_QUEUE || param2 == BoostTypeId.INSTANT_TROOPS_QUEUE_AVAILABLE) {
            _loc21_ = param1.gameData.troopsData.troopsFactory;
            _loc22_ = _loc21_.getOrders(param3);
            _loc23_ = UserManager.user.gameData.account;
            _loc24_ = new Resources();
            if (_loc22_.length > 0) {
                _loc25_ = _loc22_.length;
                if (!GameType.isElves && !GameType.isMilitary && !GameType.isSparta && !GameType.isNords && !isPiratesPortal) {
                    if (param2 == BoostTypeId.INSTANT_TROOPS_QUEUE_AVAILABLE) {
                        _loc25_ = int(_loc23_.resources.goldMoney / _loc24_.goldMoney * _loc22_.length);
                    }
                    _loc24_ = Resources.scale(StaticDataManager.instantTroopsOrderPrice, _loc25_);
                    return _loc24_;
                }
                for each(_loc26_ in _loc22_) {
                    _loc27_ = UserManager.user.gameData.buyingData.getBuyingObjectByTypeId(_loc26_.typeId);
                    _loc28_ = UserManager.user.gameData.getConstructionSecondsWithoutEffects(_loc27_) * 1000;
                    if (_loc26_.constructionInfo.constructionStartTime != null) {
                        _loc29_ = _loc26_.constructionInfo.constructionStartTime.time + _loc28_ * _loc26_.pendingCount - ServerTimeManager.serverTimeNow.time;
                    }
                    else {
                        _loc29_ = _loc28_ * _loc26_.totalCount;
                    }
                    _loc30_ = earlyIncubatorUnits.lastIndexOf(_loc26_.typeId) != -1 ? Number(22) : Number(StaticDataManager.instantTroopsOrderPricePerHour);
                    _loc24_.add(Resources.fromGoldMoney(_loc29_ * _loc30_ / 1000 / 60 / 60));
                }
                if (_loc24_.goldMoney < StaticDataManager.instantTroopsOrderMinPrice) {
                    _loc24_.goldMoney = StaticDataManager.instantTroopsOrderMinPrice;
                }
                return _loc24_;
            }
            return new Resources();
        }
        if (param2 == BoostTypeId.INSTANT_SKILL) {
            _loc31_ = param1.gameData.skillData.getSkill(param3);
            if (!_loc31_ || _loc31_.constructionInfo.constructionFinishTime == null) {
                return new Resources();
            }
            _loc32_ = _loc31_.constructionInfo.constructionFinishTime.time - ServerTimeManager.serverTimeNow.time;
            return getInstantObjectBoostPrice(param1, _loc32_, param4, true);
        }
        if (param2 == BoostTypeId.DRAGON_ABILITY) {
            _loc33_ = param1.gameData.dragonData.getAbilityById(param3);
            if (!_loc33_) {
                return new Resources();
            }
            _loc34_ = ConstructionData.getFinishAbilityTimeWithoutEffectBonus(_loc33_, param1.gameData.normalizationTime);
            _loc35_ = _loc34_ != null ? Number(_loc34_.time - ServerTimeManager.serverTimeNow.time) : Number(0);
            return getInstantObjectBoostPrice(param1, _loc35_);
        }
        if (param2 == BoostTypeId.INSTANT_TROOPS_TIER_UPGRADE) {
            _loc36_ = param1.gameData.troopsData.tiersLevelInfoByTierId[param3];
            if (_loc36_ == null || _loc36_.constructionInfo.constructionFinishTime == null) {
                return new Resources();
            }
            _loc37_ = _loc36_.constructionInfo.constructionFinishTime.time - ServerTimeManager.serverTimeNow.time;
            return getInstantObjectBoostPrice(param1, _loc37_, param4, true, true);
        }
        var _loc5_:GeoSceneObject = null;
        var _loc6_:Boolean = false;
        if (param2 == BoostTypeId.INSTANT_TECHNOLOGY) {
            _loc5_ = param1.gameData.technologyCenter.getTechnology(param3);
            _loc38_ = _loc5_.constructionInfo == null || _loc5_.constructionInfo.constructionFinishTime == null;
            _loc39_ = !!_loc38_ ? int(_loc5_.getLevel()) : int(_loc5_.getLevel() + 1);
            _loc40_ = _loc5_.objectType.saleableInfo.levelInfos[_loc39_ - 1];
            _loc6_ = _loc40_.isAdditionalLevel;
        }
        else if (param2 == BoostTypeId.INSTANT_BUILDING) {
            _loc5_ = param1.gameData.sector.getBuilding(param3);
            _loc41_ = StaticDataManager.getObjectType(_loc5_.type.id);
            if (_loc5_.buildingInfo == null || !_loc5_.buildingInfo.broken) {
                _loc42_ = _loc5_.constructionInfo == null || _loc5_.constructionInfo.constructionFinishTime == null;
                _loc43_ = !!_loc42_ ? int(_loc5_.getLevel()) : int(_loc5_.getLevel() + 1);
                _loc44_ = _loc41_.saleableInfo.levelInfos[_loc43_ - 1] as SaleableLevelInfo;
                _loc6_ = _loc44_.isAdditionalLevel;
            }
        }
        else if (param2 == BoostTypeId.INSTANT_ITEM_POWDERING || param2 == BoostTypeId.INSTANT_ITEM_UPGRADE) {
            _loc5_ = param1.gameData.inventoryData.inventoryItemsById[param3];
        }
        if (_loc5_ == null) {
            return new Resources();
        }
        var _loc7_:Date = ConstructionData.getFinishTimeWithoutEffectBonus(_loc5_, param1.gameData.normalizationTime);
        var _loc8_:Number = _loc7_ != null ? Number(_loc7_.time - ServerTimeManager.serverTimeNow.time) : Number(0);
        return getInstantObjectBoostPrice(param1, _loc8_, param4, false, _loc6_);
    }

    public static function getInstantUpgradePrice(param1:Number, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false):Resources {
        return getInstantObjectBoostPrice(UserManager.user, param1, param2, param3, param4);
    }

    private static function getInstantObjectBoostPrice(param1:User, param2:Number, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false, param6:Number = 0):Resources {
        var _loc9_:Number = NaN;
        if (param2 == 0) {
            return new Resources();
        }
        if (isFreeBoost(param3, param2)) {
            return new Resources();
        }
        if (GameType.isNords && !param4) {
            param2 = param2 - 5 * DateUtil.MILLISECONDS_PER_MINUTE;
        }
        var _loc7_:Number = param2 / DateUtil.MILLISECONDS_PER_HOUR;
        var _loc8_:Number = param2 / DateUtil.MILLISECONDS_PER_MINUTE;
        if (!Global.SINGLE_WORKER_ENABLED) {
            _loc9_ = calcSquare(_loc7_, param5);
            if (!param5) {
                _loc9_ = Math.min(StaticDataManager.boostMaxLimitGoldMoney, _loc9_);
            }
            return Resources.fromGoldMoney(_loc9_);
        }
        if (_loc7_ < 0) {
            _loc7_ = 1;
        }
        if (StaticDataManager.instantObjectPrice15Minutes != null) {
            if (_loc8_ >= 0 && _loc8_ < 15) {
                return StaticDataManager.instantObjectPrice15Minutes;
            }
            if (_loc8_ >= 15 && _loc8_ < 30) {
                return StaticDataManager.instantObjectPrice30Minutes;
            }
            if (_loc8_ >= 30 && _loc7_ < 1) {
                return StaticDataManager.instantObjectPrice1Hour;
            }
        }
        if (_loc7_ >= 0 && _loc7_ < 5) {
            return StaticDataManager.instantObjectPrice5Hours;
        }
        if (_loc7_ >= 5 && _loc7_ < 10) {
            return StaticDataManager.instantObjectPrice10Hours;
        }
        return StaticDataManager.instantObjectPrice10PlusHours;
    }

    private static function isFreeBoost(param1:Boolean, param2:Number):Boolean {
        var _loc3_:Boolean = false;
        var _loc4_:Number = param2 / DateUtil.MILLISECONDS_PER_MINUTE;
        if (Global.FREE_BOOST_ENABLED) {
            if (!param1 && _loc4_ <= TIME_FREE_BOOST) {
                _loc3_ = true;
            }
        }
        return _loc3_;
    }

    public static function calcSquare(param1:Number, param2:Boolean = false):Number {
        return normalizePrice(calcPricePerHourSquare(param1) * param1, param2);
    }

    public static function calcPricePerHourSquare(param1:Number):Number {
        var _loc2_:ArrayCustom = StaticDataManager.instantObjectHours;
        var _loc3_:ArrayCustom = StaticDataManager.instantObjectPricePerHour;
        var _loc4_:Number = _loc2_[0];
        var _loc5_:Number = _loc3_[0];
        var _loc6_:Number = _loc2_[_loc2_.length - 1];
        var _loc7_:Number = _loc3_[_loc3_.length - 1];
        if (param1 <= _loc4_) {
            return _loc5_;
        }
        if (param1 >= _loc6_) {
            return _loc7_;
        }
        var _loc8_:int = 1;
        while (_loc8_ < _loc3_.length) {
            if (param1 <= _loc2_[_loc8_]) {
                if (_loc8_ == _loc3_.length - 1) {
                    return calcYByTwoPoints(_loc2_[_loc8_ - 1], _loc3_[_loc8_ - 1], _loc2_[_loc8_], _loc3_[_loc8_], param1);
                }
                return calcYByThreePoints(_loc2_[_loc8_ - 1], _loc3_[_loc8_ - 1], _loc2_[_loc8_], _loc3_[_loc8_], _loc2_[_loc8_ + 1], _loc3_[_loc8_ + 1], param1);
            }
            _loc8_++;
        }
        return 0;
    }

    private static function calcYByTwoPoints(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number):Number {
        return (param5 - param1) * (param4 - param2) / (param3 - param1) + param2;
    }

    private static function calcYByThreePoints(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number):Number {
        var _loc8_:Number = (param6 - param2) * (param3 - param1) - (param4 - param2) * (param5 - param1);
        var _loc9_:Number = (param5 * param5 - param1 * param1) * (param3 - param1) - (param3 * param3 - param1 * param1) * (param5 - param1);
        var _loc10_:Number = _loc8_ / _loc9_;
        var _loc11_:Number = (param4 - param2 - _loc10_ * (param3 * param3 - param1 * param1)) / (param3 - param1);
        var _loc12_:Number = param2 - _loc10_ * param1 * param1 - _loc11_ * param1;
        return _loc10_ * param7 * param7 + _loc11_ * param7 + _loc12_;
    }

    public static function normalizePrice(param1:Number, param2:Boolean = false):Number {
        var _loc3_:Number = StaticDataManager.instantObjectMinPrice;
        var _loc4_:Number = !!param2 ? Number(Number.MAX_VALUE) : Number(StaticDataManager.instantObjectMaxPrice);
        if (param1 < _loc3_) {
            return _loc3_;
        }
        if (param1 > _loc4_) {
            return _loc4_;
        }
        var _loc5_:Number = Math.ceil(param1 / 5);
        _loc5_ = _loc5_ * 5;
        return _loc5_;
    }

    override public function execute():void {
        var obj:GeoSceneObject = null;
        var order:TroopsOrder = null;
        var ret:Boolean = false;
        if (this._boostTypeId == BoostTypeId.INSTANT_BUILDING || this._boostTypeId == BoostTypeId.INSTANT_TECHNOLOGY) {
            if (this._boostTypeId == BoostTypeId.INSTANT_BUILDING) {
                obj = UserManager.user.gameData.sector.getBuilding(this._objectId);
            }
            else {
                obj = UserManager.user.gameData.technologyCenter.getTechnology(this._objectId as int);
            }
            if (obj.getLevel() + 1 != this.requestDto.o.l) {
                ret = true;
            }
        }
        if (this._boostTypeId == BoostTypeId.INSTANT_TROOPS_ORDER) {
            order = UserManager.user.gameData.troopsData.troopsFactory.getOrder(this._objectId);
            if (order == null) {
                ret = true;
            }
        }
        if (ret == true) {
            if (_onFinally != null) {
                _onFinally();
            }
            return;
        }
        new JsonCallCmd("BuyBoost", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = Resources.fromDto(param1.o.r);
                _loc3_ = param1.o.c;
                _loc4_ = UserManager.user;
                _loc5_ = StaticDataManager.blackMarketData.itemsById[_itemId];
                switch (_boostTypeId) {
                    case BoostTypeId.INSTANT_BUILDING:
                    case BoostTypeId.INSTANT_TECHNOLOGY:
                    case BoostTypeId.INSTANT_TROOPS_ORDER:
                    case BoostTypeId.INSTANT_TROOPS_QUEUE:
                    case BoostTypeId.INSTANT_TROOPS_QUEUE_AVAILABLE:
                    case BoostTypeId.DAILY_QUEST:
                    case BoostTypeId.DRAGON_ABILITY:
                    case BoostTypeId.INSTANT_SKILL:
                    case BoostTypeId.INSTANT_ITEM_POWDERING:
                    case BoostTypeId.INSTANT_ITEM_UPGRADE:
                    case BoostTypeId.INSTANT_TROOPS_TIER_UPGRADE:
                        buyInstantObject(_loc2_, _loc5_, _loc3_, _activatedItemCount);
                        break;
                    case BoostTypeId.RESOURCES_TITANITE:
                    case BoostTypeId.RESOURCES_URANIUM:
                    case BoostTypeId.RESOURCES_MONEY:
                        buyResourceMiningAcceleration(new Date(param1.o.u), _loc2_);
                        break;
                    case BoostTypeId.RESOURCES_CONSUMPTION_MONEY:
                    case BoostTypeId.RESOURCES_CONSUMPTION_TITANITE:
                    case BoostTypeId.RESOURCES_CONSUMPTION_URANIUM:
                        buyResourceConsumptionBonusBoost(new Date(param1.o.u), _loc2_);
                }
                Normalizer.normalize(UserManager.user);
                if (_loc2_) {
                    _loc4_.gameData.account.resources.substract(_loc2_);
                }
                _loc4_.gameData.constructionData.updateAcceleration(_loc4_.gameData, _loc4_.gameData.normalizationTime);
                _loc4_.gameData.blackMarketData.dirty = true;
                _loc4_.gameData.questData.dirty = true;
                if (_loc4_.gameData.dragonData) {
                    _loc4_.gameData.dragonData.dirty = true;
                }
                _loc4_.gameData.updateObjectsBuyStatus(true);
                _loc4_.gameData.dispatchEvents();
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }

    private function buyInstantObject(param1:Resources, param2:BlackMarketItemRaw, param3:int, param4:int):void {
        var _loc7_:Date = null;
        var _loc8_:Number = NaN;
        var _loc10_:Skill = null;
        var _loc11_:Ability = null;
        var _loc12_:GeoSceneObject = null;
        var _loc13_:Date = null;
        var _loc14_:TroopsFactory = null;
        var _loc15_:TroopsOrder = null;
        var _loc16_:TroopsFactory = null;
        var _loc17_:Array = null;
        var _loc18_:TroopsOrder = null;
        var _loc19_:Number = NaN;
        var _loc20_:QuestState = null;
        var _loc21_:GeoSceneObject = null;
        var _loc22_:TroopsTierObjLevelInfo = null;
        var _loc5_:UserGameData = UserManager.user.gameData;
        var _loc6_:Number = 0;
        if (this._objectId == -1) {
            throw new Error("ObjectId should be supplied for object boost");
        }
        var _loc9_:Number = !!param2 ? Number(param2.boostData.timeSeconds * param4) : Number(0);
        switch (this._boostTypeId) {
            case BoostTypeId.INSTANT_SKILL:
                _loc10_ = _loc5_.skillData.getSkill(this._objectId);
                if (param2) {
                    _loc6_ = _loc10_.constructionInfo.constructionFinishTime.time - _loc9_ * 1000;
                    _loc7_ = new Date(_loc6_);
                    _loc10_.constructionInfo.constructionFinishTime = DateUtil.getTimeBetween(_loc7_, _loc5_.normalizationTime) < 0 ? _loc7_ : _loc5_.normalizationTime;
                    if (_loc10_.constructionInfo.constructionFinishTime > _loc5_.normalizationTime) {
                        _loc8_ = _loc10_.constructionInfo.constructionStartTime.time - _loc9_ * 1000;
                        _loc10_.constructionInfo.constructionStartTime = new Date(_loc8_);
                    }
                    this.updateBoughtData(param2.id, param4);
                    Normalizer.normalize(UserManager.user);
                }
                else {
                    _loc10_.constructionInfo.constructionFinishTime = _loc5_.normalizationTime;
                }
                break;
            case BoostTypeId.DRAGON_ABILITY:
                _loc11_ = _loc5_.dragonData.getAbilityById(this._objectId);
                if (param2 != null) {
                    _loc6_ = _loc11_.constructionObjInfo.constructionFinishTime.time - _loc9_ * 1000;
                    _loc7_ = new Date(_loc6_);
                    _loc11_.constructionObjInfo.constructionFinishTime = DateUtil.getTimeBetween(_loc7_, _loc5_.normalizationTime) < 0 ? _loc7_ : _loc5_.normalizationTime;
                    if (_loc11_.constructionObjInfo.constructionFinishTime > _loc5_.normalizationTime) {
                        _loc8_ = _loc11_.constructionObjInfo.constructionStartTime.time - _loc9_ * 1000;
                        _loc11_.constructionObjInfo.constructionStartTime = new Date(_loc8_);
                    }
                    this.updateBoughtData(param2.id, param4);
                    Normalizer.normalize(UserManager.user);
                }
                else {
                    _loc11_.constructionObjInfo.constructionFinishTime = _loc5_.normalizationTime;
                }
                break;
            case BoostTypeId.INSTANT_TECHNOLOGY:
            case BoostTypeId.INSTANT_BUILDING:
                if (this._boostTypeId == BoostTypeId.INSTANT_BUILDING) {
                    _loc12_ = _loc5_.sector.getBuilding(this._objectId);
                }
                else {
                    _loc12_ = _loc5_.technologyCenter.getTechnology(this._objectId as int);
                    if (param2 == null) {
                        _loc12_.constructionObjInfo.instantFinish = true;
                    }
                }
                if (_loc12_ == null) {
                    throw new Error("Object not found or not constructing");
                }
                if (this.requestDto.o.l == _loc12_.getLevel() + 1) {
                    if (param2 != null) {
                        _loc6_ = _loc12_.constructionInfo.constructionFinishTime.time - _loc9_ * 1000;
                        _loc7_ = new Date(_loc6_);
                        _loc13_ = DateUtil.getTimeBetween(_loc7_, _loc5_.normalizationTime) < 0 ? _loc7_ : _loc5_.normalizationTime;
                        _loc12_.constructionInfo.constructionFinishTime = _loc13_;
                        this.updateAllianceHelpRequestData(_loc12_, _loc13_);
                        if (_loc12_.constructionInfo.constructionFinishTime > _loc5_.normalizationTime) {
                            _loc8_ = _loc12_.constructionInfo.constructionStartTime.time - _loc9_ * 1000;
                            _loc12_.constructionInfo.constructionStartTime = new Date(_loc8_);
                        }
                        else {
                            _loc12_.constructionObjInfo.instantFinish = true;
                        }
                        this.updateBoughtData(param2.id, param4);
                        Normalizer.normalize(UserManager.user);
                    }
                    else {
                        _loc12_.constructionInfo.constructionFinishTime = _loc5_.normalizationTime;
                    }
                }
                break;
            case BoostTypeId.INSTANT_TROOPS_ORDER:
                _loc14_ = _loc5_.troopsData.troopsFactory;
                _loc15_ = _loc14_.getOrder(this._objectId);
                if (_loc15_ != null) {
                    if (param2 != null) {
                        _loc15_.constructionBoost = _loc9_;
                        _loc15_.boostNormalizationTime = _loc5_.normalizationTime;
                        this.updateBoughtData(param2.id, param4);
                        Normalizer.normalize(UserManager.user);
                    }
                    else {
                        _loc15_.constructionInfo.constructionFinishTime = _loc5_.normalizationTime;
                        _loc15_.finishAll = true;
                    }
                }
                break;
            case BoostTypeId.INSTANT_TROOPS_QUEUE:
            case BoostTypeId.INSTANT_TROOPS_QUEUE_AVAILABLE:
                _loc16_ = _loc5_.troopsData.troopsFactory;
                _loc17_ = _loc16_.getOrders(this._objectId, param3);
                if (param2) {
                    _loc19_ = _loc9_;
                    for each(_loc18_ in _loc17_) {
                        _loc18_.constructionBoost = _loc19_;
                        _loc18_.boostNormalizationTime = _loc5_.normalizationTime;
                        Normalizer.normalize(UserManager.user);
                        if (_loc18_.constructionBoost) {
                            _loc19_ = _loc18_.constructionBoost;
                            continue;
                        }
                        break;
                    }
                    this.updateBoughtData(param2.id, param4);
                }
                else {
                    for each(_loc18_ in _loc17_) {
                        _loc18_.constructionInfo.constructionFinishTime = _loc5_.normalizationTime;
                        _loc18_.finishAll = true;
                        Normalizer.normalize(UserManager.user);
                    }
                }
                break;
            case BoostTypeId.DAILY_QUEST:
                _loc20_ = _loc5_.questData.getQuestStateByQuestId(this._objectId);
                if (param2 != null) {
                    _loc6_ = _loc20_.timeDeadline.time - _loc9_ * 1000;
                    _loc7_ = new Date(_loc6_);
                    if (_loc20_) {
                        _loc20_.timeDeadline = DateUtil.getTimeBetween(_loc7_, _loc5_.normalizationTime) < 0 ? _loc7_ : _loc5_.normalizationTime;
                    }
                    if (_loc20_.timeDeadline > _loc5_.normalizationTime) {
                        _loc8_ = _loc20_.timeStarted.time - _loc9_ * 1000;
                        _loc20_.timeStarted = new Date(_loc8_);
                    }
                    this.updateBoughtData(param2.id, param4);
                    Normalizer.normalize(UserManager.user);
                }
                else if (_loc20_) {
                    _loc20_.timeDeadline = _loc5_.normalizationTime;
                }
                break;
            case BoostTypeId.INSTANT_ITEM_POWDERING:
            case BoostTypeId.INSTANT_ITEM_UPGRADE:
                _loc21_ = UserManager.user.gameData.inventoryData.inventoryItemsById[this._objectId];
                if (param2 != null) {
                    _loc6_ = _loc21_.constructionInfo.constructionFinishTime.time - _loc9_ * 1000;
                    _loc7_ = new Date(_loc6_);
                    _loc21_.constructionInfo.constructionFinishTime = DateUtil.getTimeBetween(_loc7_, _loc5_.normalizationTime) < 0 ? _loc7_ : _loc5_.normalizationTime;
                    if (_loc21_.constructionInfo.constructionFinishTime > _loc5_.normalizationTime) {
                        _loc8_ = _loc21_.constructionInfo.constructionStartTime.time - _loc9_ * 1000;
                        _loc21_.constructionInfo.constructionStartTime = new Date(_loc8_);
                    }
                    this.updateBoughtData(param2.id, param4);
                }
                else {
                    _loc21_.constructionObjInfo.constructionFinishTime = _loc5_.normalizationTime;
                }
                break;
            case BoostTypeId.INSTANT_TROOPS_TIER_UPGRADE:
                _loc22_ = UserManager.user.gameData.troopsData.tiersLevelInfoByTierId[this._objectId];
                if (param2 != null) {
                    _loc6_ = _loc22_.constructionInfo.constructionFinishTime.time - _loc9_ * 1000;
                    _loc7_ = new Date(_loc6_);
                    _loc22_.constructionInfo.constructionFinishTime = DateUtil.getTimeBetween(_loc7_, _loc5_.normalizationTime) < 0 ? _loc7_ : _loc5_.normalizationTime;
                    if (_loc22_.constructionInfo.constructionFinishTime > _loc5_.normalizationTime) {
                        _loc8_ = _loc22_.constructionInfo.constructionStartTime.time - _loc9_ * 1000;
                        _loc22_.constructionInfo.constructionStartTime = new Date(_loc8_);
                    }
                    else {
                        UserManager.user.gameData.troopsData.upgradeTierDirty = true;
                        _loc22_.finishUpgrade();
                        _loc22_.normalizeResourcesAfterUpgrade(this._objectId);
                    }
                    this.updateBoughtData(param2.id, param4);
                }
                else {
                    UserManager.user.gameData.troopsData.upgradeTierDirty = true;
                    _loc22_.finishUpgrade();
                    _loc22_.normalizeResourcesAfterUpgrade(this._objectId);
                }
                break;
            default:
                throw new Error("boostTypeId is out of range");
        }
    }

    private function updateAllianceHelpRequestData(param1:GeoSceneObject, param2:Date):void {
        var _loc5_:UserAllianceHelpRequest = null;
        if (!Global.ALLIANCE_HELP_ENABLED) {
            return;
        }
        if (param1.objectType.buildingInfo == null) {
            return;
        }
        var _loc3_:UserAllianceHelpData = UserManager.user.gameData.allianceData.allianceHelpData;
        if (_loc3_ == null) {
            return;
        }
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_.requests.length) {
            _loc5_ = _loc3_.requests[_loc4_];
            if (_loc5_.buildingInfo != null && _loc5_.buildingInfo.buildingId == param1.id) {
                _loc5_.validTill = param2;
                break;
            }
            _loc4_++;
        }
    }

    private function updateBoughtData(param1:int, param2:int):void {
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc3_:Dictionary = UserManager.user.gameData.blackMarketData.boughtItems;
        if (_loc3_[param1].freeCount + _loc3_[param1].paidCount == param2) {
            delete _loc3_[param1];
        }
        if (_loc3_[param1] != undefined) {
            _loc4_ = _loc3_[param1].freeCount > param2 ? int(param2) : int(_loc3_[param1].freeCount);
            _loc5_ = _loc3_[param1].paidCount > param2 - _loc4_ ? int(param2 - _loc4_) : int(_loc3_[param1].paidCount);
            if (_loc3_[param1].freeCount > 0) {
                _loc3_[param1].freeCount = _loc3_[param1].freeCount - _loc4_;
            }
            else {
                _loc3_[param1].paidCount = _loc3_[param1].paidCount - _loc5_;
            }
        }
    }

    private function buyResourceMiningAcceleration(param1:Date, param2:Resources):void {
        var _loc3_:ResourceMiningBoostType = StaticDataManager.getResourceMiningBoostType(this._boostTypeId, this._resourceBoostPercentage);
        var _loc4_:ConstructionData = UserManager.user.gameData.constructionData;
        _loc4_.addResourceMiningBoost(param1, _loc3_);
        _loc4_.resourceMiningBoostAutoRenewal = this._boostAutoRenewal;
    }

    private function buyResourceConsumptionBonusBoost(param1:Date, param2:Resources):void {
        var _loc3_:ResourceConsumptionBonusBoostType = StaticDataManager.getResourceConsumptionBonusBoostType(this._boostTypeId, this._resourceBoostPercentage);
        var _loc4_:ConstructionData = UserManager.user.gameData.constructionData;
        _loc4_.removeResourceConsumptionBonusBoost();
        _loc4_.addResourceConsumptionBonusBoost(param1, _loc3_);
        _loc4_.resourceConsumptionBonusBoostAutoRenewal = this._boostAutoRenewal;
    }
}
}
