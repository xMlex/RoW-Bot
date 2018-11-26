package model.data.alliances.city {
import flash.utils.Dictionary;

import gameObjects.observableObject.ObservableObject;

import model.modules.allianceCity.data.resourceHistory.AllianceResources;
import model.modules.allianceCity.data.resourceHistory.AllianceResourcesHistory;
import model.modules.allianceCity.data.resourceHistory.ResourceHistoryItems.HistoryItem;

public class AllianceCityData extends ObservableObject {

    public static const CLASS_NAME:String = "AllianceCityData";

    public static const ALLIANCE_CITY_DATA_CHANGED:String = CLASS_NAME + "DataChanged";


    public var allianceCityId:Number;

    public var renamingForbidden:Boolean;

    public var resources:AllianceResources;

    public var lastTransactionId:Number;

    public var resourcesHistory:AllianceResourcesHistory;

    public var prototypeIds:Array;

    public var permittedUserIds:Array;

    public var enemyDowngrades:Dictionary;

    public var dirty:Boolean = false;

    public function AllianceCityData() {
        super();
    }

    public static function fromDro(param1:*):AllianceCityData {
        var _loc3_:int = 0;
        var _loc4_:Number = NaN;
        var _loc5_:* = undefined;
        var _loc2_:AllianceCityData = new AllianceCityData();
        _loc2_.allianceCityId = param1.i;
        _loc2_.renamingForbidden = param1.r;
        _loc2_.resources = param1.s == null ? new AllianceResources() : AllianceResources.fromDto(param1.s);
        _loc2_.lastTransactionId = param1.l;
        _loc2_.resourcesHistory = param1.t == null ? new AllianceResourcesHistory() : AllianceResourcesHistory.fromDto(param1.t);
        _loc2_.checkResourceHistoryBalance();
        if (param1.p != null) {
            _loc2_.prototypeIds = [];
            for each(_loc3_ in param1.p) {
                _loc2_.prototypeIds.push(_loc3_);
            }
        }
        if (param1.u != null) {
            _loc2_.permittedUserIds = [];
            for each(_loc4_ in param1.u) {
                _loc2_.permittedUserIds.push(_loc4_);
            }
        }
        _loc2_.enemyDowngrades = new Dictionary();
        if (param1 != null && param1.d != null) {
            for (_loc5_ in param1.d) {
                _loc2_.enemyDowngrades[_loc5_] = param1.d[_loc5_];
            }
        }
        return _loc2_;
    }

    private function checkResourceHistoryBalance():void {
        var _loc4_:HistoryItem = null;
        var _loc5_:HistoryItem = null;
        if (!this.resourcesHistory.items || this.resourcesHistory.items.length == 0) {
            return;
        }
        var _loc1_:int = this.resourcesHistory.items.length - 1;
        var _loc2_:HistoryItem = HistoryItem(this.resourcesHistory.items[_loc1_]);
        _loc2_.balance = this.resources.clone();
        var _loc3_:int = this.resourcesHistory.items.length - 1;
        while (_loc3_ > 0) {
            _loc4_ = this.resourcesHistory.items[_loc3_ - 1];
            _loc5_ = this.resourcesHistory.items[_loc3_];
            _loc4_.balance = _loc5_.getBalanceWithoutMee();
            _loc3_--;
        }
    }

    public function updateDate(param1:AllianceCityData):void {
        this.allianceCityId = param1.allianceCityId;
        this.renamingForbidden = param1.renamingForbidden;
        this.resources = param1.resources;
        this.lastTransactionId = param1.lastTransactionId;
        this.resourcesHistory = param1.resourcesHistory;
        this.prototypeIds = param1.prototypeIds;
        this.permittedUserIds = param1.permittedUserIds;
        this.enemyDowngrades = param1.enemyDowngrades;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(ALLIANCE_CITY_DATA_CHANGED);
        }
    }
}
}
