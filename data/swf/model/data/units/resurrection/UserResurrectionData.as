package model.data.units.resurrection {
import common.queries.util.query;

import gameObjects.observableObject.ObservableObject;

import model.data.users.troops.Troops;
import model.logic.ServerTimeManager;

public class UserResurrectionData extends ObservableObject {

    public static const CLASS_NAME:String = "UserResurrectionData";

    public static const LOSSES_DATA_CHANGED:String = CLASS_NAME + "LossesDataChanged";


    public var dirtyNormalized:Boolean;

    public var resurrectionKits:Array;

    public function UserResurrectionData() {
        this.resurrectionKits = [];
        super();
    }

    public static function fromDto(param1:*):UserResurrectionData {
        var _loc2_:UserResurrectionData = new UserResurrectionData();
        if (param1 != null) {
            _loc2_.resurrectionKits = ResurrectionKit.fromDtos(param1.r);
        }
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dirtyNormalized) {
            this.dirtyNormalized = false;
            dispatchEvent(LOSSES_DATA_CHANGED);
        }
    }

    public function getLossesByType(param1:int):Troops {
        var _loc4_:ResurrectionKit = null;
        var _loc2_:Troops = new Troops();
        var _loc3_:Array = this.getResurrectionKitsByLoosesType(param1);
        if (_loc3_.length > 0) {
            for each(_loc4_ in _loc3_) {
                _loc2_.addTroops(_loc4_.losses);
            }
        }
        return _loc2_;
    }

    public function getResurrectionKitsByLoosesType(param1:int):Array {
        var lossesType:int = param1;
        return query(this.resurrectionKits).where(function (param1:ResurrectionKit):Boolean {
            return param1.lossesType == lossesType && param1.expirationDate > ServerTimeManager.serverTimeNow;
        }).toArray();
    }

    public function removeTroopsFromResurrectionKitsByType(param1:Troops, param2:int):void {
        var troopsByType:* = undefined;
        var countToRestore:int = 0;
        var resurrectionKit:ResurrectionKit = null;
        var countInKit:int = 0;
        var troops:Troops = param1;
        var lossesType:int = param2;
        var resurrectionKits:Array = query(this.resurrectionKits).where(function (param1:ResurrectionKit):Boolean {
            return param1.lossesType == lossesType && param1.expirationDate > ServerTimeManager.serverTimeNow;
        }).orderBy(function (param1:ResurrectionKit):* {
            return param1.expirationDate.time;
        }).toArray();
        for (troopsByType in troops.countByType) {
            countToRestore = troops.countByType[troopsByType];
            if (countToRestore != 0) {
                for each(resurrectionKit in resurrectionKits) {
                    countInKit = resurrectionKit.losses.countByType[troopsByType];
                    if (countInKit >= countToRestore) {
                        resurrectionKit.losses.countByType[troopsByType] = countInKit - countToRestore;
                        break;
                    }
                    if (countInKit > 0) {
                        resurrectionKit.losses.countByType[troopsByType] = 0;
                        countToRestore = countToRestore - countInKit;
                    }
                }
            }
        }
        this.dirtyNormalized = true;
    }
}
}
