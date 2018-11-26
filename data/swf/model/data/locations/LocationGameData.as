package model.data.locations {
import common.ArrayCustom;

import flash.events.Event;
import flash.events.EventDispatcher;

import model.data.effects.LightEffectItem;
import model.data.locations.allianceCity.LocationAllianceCityData;
import model.data.locations.mines.IMineInfo;
import model.data.locations.mines.LocationMineData;
import model.data.locations.world.LocationWorldData;
import model.data.map.MapPos;
import model.logic.StaticDataManager;

public class LocationGameData implements IMineInfo {

    private static const CLASS_NAME:String = "LocationGameData";

    public static const MAP_POS_CHANGED:String = CLASS_NAME + "MapPosChanged";


    public var revision:Number;

    public var normalizationTime:Date;

    public var mapPos:MapPos;

    public var name:String;

    private var _occupantUserId:Number;

    private var _occupantAllianceId:Number;

    private var _occupationStartTime:Date;

    public var mineData:LocationMineData;

    public var towerData:LocationTowerData;

    public var worldData:LocationWorldData;

    public var allianceCityData:LocationAllianceCityData;

    public var locationStatsData:LocationStatsData;

    public var effectsDuringOccupation:ArrayCustom;

    public var mapPosDirty:Boolean;

    public var events:EventDispatcher;

    public function LocationGameData() {
        this.events = new EventDispatcher();
        super();
    }

    public static function fromDto(param1:*):LocationGameData {
        var _loc2_:LocationGameData = new LocationGameData();
        _loc2_.revision = param1.r;
        _loc2_.normalizationTime = param1.t == null ? null : new Date(param1.t);
        _loc2_.mapPos = MapPos.fromDto(param1.m);
        _loc2_.name = param1.n;
        _loc2_._occupantUserId = param1.o == null ? Number(Number.NaN) : Number(param1.o);
        _loc2_._occupantAllianceId = param1.c == null ? Number(Number.NaN) : Number(param1.c);
        _loc2_._occupationStartTime = param1.d == null ? null : new Date(param1.d);
        _loc2_.mineData = param1.md == null ? null : LocationMineData.fromDto(param1.md);
        _loc2_.worldData = param1.wd == null ? null : LocationWorldData.fromDto(param1.wd);
        _loc2_.towerData = param1.td == null ? null : LocationTowerData.fromDto(param1.td);
        _loc2_.allianceCityData = param1.cd == null ? null : LocationAllianceCityData.fromDto(param1.cd);
        _loc2_.locationStatsData = param1.sd == null ? null : LocationStatsData.fromDto(param1.sd);
        _loc2_.effectsDuringOccupation = param1.e == null ? null : LightEffectItem.fromDtos(param1.e);
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function toDtos(param1:ArrayCustom):Array {
        var _loc3_:LocationGameData = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function get occupantUserId():Number {
        return this._occupantUserId;
    }

    public function set occupantUserId(param1:Number):void {
        this._occupantUserId = param1;
    }

    public function get occupantAllianceId():Number {
        return this._occupantAllianceId;
    }

    public function set occupantAllianceId(param1:Number):void {
        this._occupantAllianceId = param1;
    }

    public function get occupationStartTime():Date {
        return this._occupationStartTime;
    }

    public function get isStorage():Boolean {
        return this.mineData && this.mineData.dynamicMineData != null;
    }

    public function get mineTypeId():int {
        return this.mineData.typeId;
    }

    public function get mineKindId():int {
        return StaticDataManager.mineData.getMineType(this.mineData.typeId).kind;
    }

    public function get resourceTotal():Number {
        return this.mineData.resourceTotal;
    }

    public function get maxArtifactIssueCost():Number {
        return this.mineData.maxArtifactIssueCost;
    }

    public function get timeFound():Date {
        return this.mineData.timeFound;
    }

    public function get timeToLiveDays():Number {
        return this.mineData.timeToLiveDays;
    }

    public function get collectedResourceLimit():Number {
        return this.mineData.collectedResourceLimit;
    }

    public function get collectionTimeDelayHours():Number {
        return this.mineData.collectionTimeDelayHours;
    }

    public function toDto():* {
        var _loc1_:* = {
            "r": this.revision,
            "t": (this.normalizationTime == null ? null : this.normalizationTime.time),
            "m": (this.mapPos == null ? null : this.mapPos.toDto()),
            "n": this.name,
            "o": (!!isNaN(this._occupantUserId) ? null : this._occupantUserId),
            "c": (!!isNaN(this._occupantAllianceId) ? null : this._occupantAllianceId),
            "d": (this._occupationStartTime == null ? null : this._occupationStartTime.time),
            "md": (this.mineData == null ? null : this.mineData.toDto()),
            "td": (this.towerData == null ? null : this.towerData.toDto()),
            "wd": (this.worldData == null ? null : this.worldData.toDto()),
            "cd": (this.allianceCityData == null ? null : this.allianceCityData.toDto()),
            "e": (this.effectsDuringOccupation == null ? null : this.effectsDuringOccupation.toDtos())
        };
        return _loc1_;
    }

    public function dispatchEvents():void {
        if (this.mapPosDirty) {
            this.mapPosDirty = false;
            this.events.dispatchEvent(new Event(MAP_POS_CHANGED));
        }
    }
}
}
