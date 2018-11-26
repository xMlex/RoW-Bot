package model.data.locations {
import common.ArrayCustom;
import common.GameType;
import common.ObjectUtil;

import flash.geom.Rectangle;

import model.data.GeneralNote;
import model.data.locations.allianceCity.LocationCityData;
import model.data.locations.mines.IMineInfo;
import model.data.locations.mines.LocationNoteMineData;
import model.data.locations.mines.MineKindId;
import model.data.locations.mines.MineType;
import model.data.locations.towers.LocationNoteTowerData;
import model.data.map.MapPos;
import model.logic.LocationManager;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;

public class LocationNote extends GeneralNote implements IMineInfo {


    public var segmentId:int;

    public var revision:Number;

    public var _occupantAllianceId:Number;

    private var _occupationStartTime:Date;

    public var mineInfo:LocationNoteMineData;

    public var towerInfo:LocationNoteTowerData;

    public var allianceCityInfo:LocationCityData;

    public var mapElementRect:Rectangle;

    public var mapImageSource:String;

    public var finalized:Boolean;

    public var _towerMapPos:MapPos;

    public function LocationNote() {
        super();
    }

    public static function fromDto(param1:*):LocationNote {
        var _loc2_:LocationNote = new LocationNote();
        _loc2_.id = param1.i;
        _loc2_.segmentId = param1.g;
        _loc2_.revision = param1.v;
        _loc2_.mapPos = MapPos.fromDto(param1.m);
        _loc2_.name = param1.a;
        _loc2_.occupantUserId = param1.o == null ? Number(NaN) : Number(param1.o);
        _loc2_._occupantAllianceId = param1.c == null ? Number(NaN) : Number(param1.c);
        _loc2_._occupationStartTime = param1.d == null ? null : new Date(param1.d);
        _loc2_.mineInfo = param1.n == null ? null : LocationNoteMineData.fromDto(param1.n);
        _loc2_.towerInfo = param1.t == null ? null : LocationNoteTowerData.fromDto(param1.t);
        _loc2_.allianceCityInfo = param1.l == null ? null : LocationCityData.fromDto(param1.l);
        _loc2_.finalized = param1.f;
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

    public function get towerMapPos():MapPos {
        if (this._towerMapPos == null) {
            if (!GameType.isNords) {
                this._towerMapPos = new MapPos(Math.round(mapPos.x / 100) * 100, Math.round(mapPos.y / 100) * 100);
            }
            else {
                this._towerMapPos = new MapPos(mapPos.x * 4, mapPos.y * 4);
            }
        }
        return this._towerMapPos;
    }

    override public function get level():int {
        if (this.towerInfo) {
            return this.towerInfo.level;
        }
        if (this.allianceCityInfo) {
            return this.allianceCityInfo.level;
        }
        return 0;
    }

    public function get occupantId():Number {
        var _loc1_:Number = NaN;
        if (this.towerInfo) {
            _loc1_ = this._occupantAllianceId;
        }
        if (this.allianceCityInfo) {
            _loc1_ = this.allianceCityInfo.allianceId;
        }
        return _loc1_;
    }

    public function get lastDowngradeDate():Date {
        var _loc1_:Date = null;
        if (this.allianceCityInfo) {
            _loc1_ = this.allianceCityInfo.timeDowngrade;
        }
        return _loc1_;
    }

    public function get isTower():Boolean {
        return this.towerInfo != null;
    }

    public function get isMine():Boolean {
        return this.mineInfo != null;
    }

    public function get isStorage():Boolean {
        return this.mineInfo != null && !isNaN(this.mineInfo.resources);
    }

    public function get isAllianceCity():Boolean {
        return this.allianceCityInfo != null;
    }

    public function get isAvpStorage():Boolean {
        if (!GameType.isMilitary || !this.isStorage) {
            return false;
        }
        var _loc1_:MineType = StaticDataManager.mineData.getMineType(this.mineTypeId);
        return _loc1_ && _loc1_.kind == MineKindId.AVP_MONEY;
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

    public function set occupationStartTime(param1:Date):void {
        this._occupationStartTime = param1;
    }

    public function get mineTypeId():int {
        return this.mineInfo.typeId;
    }

    public function get mineKindId():int {
        return StaticDataManager.mineData.getMineType(this.mineInfo.typeId).kind;
    }

    public function get resourceTotal():Number {
        return this.mineInfo.resourceTotal;
    }

    public function get maxArtifactIssueCost():Number {
        return this.mineInfo.maxArtifactIssueCost;
    }

    public function get timeFound():Date {
        return this.mineInfo.timeFound;
    }

    public function get timeToLiveDays():Number {
        return this.mineInfo.timeToLiveDays;
    }

    public function get collectedResourceLimit():Number {
        return this.mineInfo.collectedResourceLimit;
    }

    public function get collectionTimeDelayHours():Number {
        return this.mineInfo.collectionTimeDelayHours;
    }

    public function mapPosInitialized():Boolean {
        return mapPos != null;
    }

    public function get storageIsExpired():Boolean {
        return this.isStorage && (this.mineInfo.resources == 0 || isNaN(occupantUserId) && ServerTimeManager.serverTimeNow.time >= this.mineInfo.freeFrom.time + LocationManager.dynamicMinesConfiguration.freeInactivityTimeoutHours * 60 * 60 * 1000);
    }

    public function clone():LocationNote {
        return ObjectUtil.trueClone(this) as LocationNote;
    }
}
}
