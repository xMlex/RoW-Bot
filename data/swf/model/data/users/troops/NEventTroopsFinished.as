package model.data.users.troops {
import common.DateUtil;

import model.data.User;
import model.data.effects.EffectTypeId;
import model.data.normalization.NEventUser;
import model.data.normalization.Normalizer;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.units.Unit;
import model.data.users.acceleration.ConstructionData;
import model.logic.StaticDataManager;
import model.logic.UserStatsManager;
import model.logic.quests.completions.QuestCompletionByTroops;
import model.logic.quests.completions.QuestCompletionPeriodic;
import model.logic.quests.periodicQuests.ComplexSource;
import model.logic.quests.periodicQuests.enums.PeriodicQuestPrototypeId;
import model.logic.units.UnitUtility;

public class NEventTroopsFinished extends NEventUser {


    private var _factory:TroopsFactory;

    private var _order:TroopsOrder;

    public function NEventTroopsFinished(param1:TroopsFactory, param2:TroopsOrder, param3:Date) {
        super(param3);
        this._factory = param1;
        this._order = param2;
    }

    override protected function postProcess(param1:User, param2:Date):void {
        var _loc6_:Unit = null;
        var _loc7_:int = 0;
        var _loc8_:Boolean = false;
        var _loc9_:TroopsOrder = null;
        var _loc3_:GeoSceneObjectType = StaticDataManager.getObjectType(this._order.typeId);
        var _loc4_:int = 0;
        if (this._order.boostNormalizationTime) {
            this._order.boostNormalizationTime = null;
            _loc4_ = this.processBoost(param1, param2);
            if (_loc4_ == 0) {
                return;
            }
        }
        else {
            param1.gameData.constructionData.setConstructionPeriod(this._order, time);
            this._order.constructionObjInfo.progressPercentage = 100;
            _loc4_ = !this._order.finishAll ? 1 : int(this._order.pendingCount);
        }
        this._order.pendingCount = this._order.pendingCount - _loc4_;
        var _loc5_:Troops = Troops.from(_loc3_.id, _loc4_);
        if (param1.gameData.effectData.isActiveEffect(EffectTypeId.UserAutoMoveTroopsBunker)) {
            _loc6_ = UnitUtility.FindOrCreateInBunkerUnit(param1);
            _loc6_.MergeTroopsPayloadByTroops(_loc5_);
        }
        else {
            _loc7_ = _loc3_.troopsInfo.groupId;
            _loc8_ = param1.gameData.sector.hasMoveTroopsToBunkerBonus(_loc7_);
            if (_loc8_) {
                _loc6_ = UnitUtility.FindOrCreateInBunkerUnit(param1);
                _loc6_.MergeTroopsPayloadByTroops(_loc5_);
            }
            else {
                param1.gameData.troopsData.troops.addTroops(_loc5_);
            }
        }
        UserStatsManager.troopsBuilt2(param1, _loc3_, _loc4_);
        QuestCompletionByTroops.tryComplete(_loc3_.id, _loc4_);
        QuestCompletionPeriodic.tryComplete(ComplexSource.fromTroopsType(_loc3_.id, _loc4_), [PeriodicQuestPrototypeId.TrainTroops]);
        if (this._order.pendingCount == 0) {
            this._factory.finishOrder(this._order);
            this._factory.removeOrder(this._order);
            _loc9_ = this._factory.getFirstOrder(_loc3_.troopsInfo.groupId);
            if (_loc9_ != null) {
                param1.gameData.constructionData.setConstructionPeriod(_loc9_, time);
                param1.gameData.troopsData.troopsFactory.orderSetTime(_loc3_.troopsInfo.groupId);
            }
        }
        this._order.dirtyNormalized = true;
    }

    private function processBoost(param1:User, param2:Date):int {
        var _loc10_:Number = NaN;
        var _loc3_:ConstructionData = param1.gameData.constructionData;
        var _loc4_:Number = _loc3_.getConstructionTicks(this._order) / 1000;
        var _loc5_:Number = 0;
        var _loc6_:Number = this._order.constructionBoost;
        this._order.constructionBoost = 0;
        var _loc7_:Number = DateUtil.getTimeBetween(param2, this._order.constructionInfo.constructionFinishTime) / 1000;
        if (_loc6_ < _loc7_) {
            _loc5_ = this._order.constructionInfo.constructionFinishTime.time - _loc6_ * 1000;
            this._order.constructionInfo.constructionFinishTime = new Date(_loc5_);
            _loc10_ = this._order.constructionInfo.constructionStartTime.time - _loc6_ * 1000;
            this._order.constructionInfo.constructionStartTime = new Date(_loc10_);
            return 0;
        }
        var _loc8_:int = 1;
        _loc6_ = _loc6_ - _loc7_;
        while (_loc6_ > _loc4_ && this._order.pendingCount > _loc8_) {
            _loc8_++;
            _loc6_ = _loc6_ - _loc4_;
        }
        if (this._order.pendingCount == _loc8_) {
            this._order.constructionBoost = _loc6_;
            return _loc8_;
        }
        _loc5_ = param2.time + (_loc4_ - _loc6_) * 1000;
        var _loc9_:Date = new Date(_loc5_);
        this._order.constructionInfo.constructionFinishTime = Normalizer.normalizeTime(_loc9_);
        this._order.constructionInfo.constructionStartTime = new Date(this._order.constructionInfo.constructionFinishTime.time - _loc4_ * 1000);
        return _loc8_;
    }
}
}
