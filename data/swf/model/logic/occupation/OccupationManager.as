package model.logic.occupation {
import common.ArrayCustom;
import common.DateUtil;

import configs.Global;

import flash.utils.Dictionary;

import model.data.User;
import model.data.users.UserNote;
import model.logic.ServerTimeManager;
import model.logic.UserNoteManager;
import model.logic.occupation.data.OccupationState;
import model.logic.occupation.data.OccupiedUserNote;

public class OccupationManager {

    public static var occupiedUserNotes:Dictionary = new Dictionary();


    public function OccupationManager() {
        super();
    }

    public static function initialize(param1:Array):void {
        var _loc2_:ArrayCustom = null;
        if (param1 != null) {
            _loc2_ = OccupiedUserNote.fromDtos(param1);
            updateOccupiedUserNotes(_loc2_);
        }
    }

    public static function getOccupiedUserNote(param1:Number):OccupiedUserNote {
        var _loc3_:UserNote = null;
        var _loc2_:OccupiedUserNote = occupiedUserNotes[param1];
        if (_loc2_ == null) {
            _loc3_ = UserNoteManager.getById(param1);
            _loc2_ = new OccupiedUserNote();
            _loc2_.userId = param1;
            _loc2_.lastVisitDate = ServerTimeManager.serverTimeNow;
            _loc2_.level = _loc3_.level;
        }
        return _loc2_;
    }

    public static function getRobberyValue(param1:OccupiedUserNote):int {
        return Math.floor(OccupationManager.getCollectingResourcesPerHour(param1.level, OccupationManager.getCollectingCoeff(ServerTimeManager.serverTimeNow, param1.lastVisitDate)));
    }

    public static function getCollectingResourcesPerHour(param1:int, param2:Number):Number {
        var _loc3_:Number = Math.min(Global.serverSettings.occupation.maximumCollectedResourcesPerHour, 100 + param1 * 5);
        return _loc3_ * param2;
    }

    public static function getCollectingCoeff(param1:Date, param2:Date):Number {
        var _loc3_:Number = (DateUtil.getDatePart(param1).time - DateUtil.getDatePart(param2).time) / (1000 * 60 * 60 * 24);
        return _loc3_ < 3 ? Number(1) : Number(1 - 0.25 * Math.min(3, _loc3_ - 2));
    }

    public static function updateOccupiedUserNotes(param1:ArrayCustom):void {
        var _loc2_:OccupiedUserNote = null;
        if (occupiedUserNotes == null) {
            occupiedUserNotes = new Dictionary();
        }
        for each(_loc2_ in param1) {
            occupiedUserNotes[_loc2_.userId] = _loc2_;
        }
    }

    public static function getMiningCoefficient(param1:User):* {
        var _loc2_:Boolean = Global.serverSettings.occupation.enabled && param1.gameData.occupationData != null && param1.gameData.occupationData.ownOccupationInfo != null && param1.gameData.occupationData.ownOccupationInfo.state == OccupationState.COLLECTING;
        return {
            "typeId": (!_loc2_ ? -1 : param1.gameData.occupationData.ownOccupationInfo.resourceTypeId),
            "coeff": (!_loc2_ ? 1 : Global.serverSettings.occupation.occupiedUserMiningCoeff)
        };
    }
}
}
