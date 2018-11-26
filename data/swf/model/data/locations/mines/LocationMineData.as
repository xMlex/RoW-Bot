package model.data.locations.mines {
import common.ArrayCustom;

public class LocationMineData {


    public var typeId:int;

    public var resourceTotal:Number;

    public var resourceTypeId:int;

    public var timeFound:Date;

    public var timeToLiveDays:Number;

    public var collectedResourceLimit:Number;

    public var collectionTimeDelayHours:Number;

    public var lastCollectionTime:Date;

    public var maxArtifactIssueCost:Number;

    public var lastArtifactIssuedDate:Date;

    public var attackersMinimalLevel:Number;

    public var attackersMaximalLevel:Number;

    public var dynamicMineData:DynamicMineData;

    public function LocationMineData() {
        super();
    }

    public static function fromDto(param1:*):LocationMineData {
        var _loc2_:LocationMineData = new LocationMineData();
        _loc2_.typeId = param1.t;
        _loc2_.resourceTotal = param1.r;
        _loc2_.resourceTypeId = param1.h == null ? -1 : int(param1.h);
        _loc2_.timeFound = param1.f == null ? null : new Date(param1.f);
        _loc2_.timeToLiveDays = param1.l;
        _loc2_.collectedResourceLimit = param1.b;
        _loc2_.collectionTimeDelayHours = param1.d;
        _loc2_.lastCollectionTime = param1.s == null ? null : new Date(param1.s);
        _loc2_.maxArtifactIssueCost = param1.m == null ? Number(Number.NaN) : Number(param1.m);
        _loc2_.lastArtifactIssuedDate = param1.a == null ? null : new Date(param1.a);
        _loc2_.attackersMinimalLevel = param1.n == null ? Number(Number.NaN) : Number(param1.n);
        _loc2_.attackersMaximalLevel = param1.x == null ? Number(Number.NaN) : Number(param1.x);
        _loc2_.dynamicMineData = param1.e == null ? null : DynamicMineData.fromDto(param1.e);
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
        var _loc3_:LocationMineData = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "t": this.typeId,
            "r": this.resourceTotal,
            "h": this.resourceTypeId,
            "f": (this.timeFound == null ? null : this.timeFound.time),
            "l": this.timeToLiveDays,
            "b": this.collectedResourceLimit,
            "d": this.collectionTimeDelayHours,
            "s": (this.lastCollectionTime == null ? null : this.lastCollectionTime.time),
            "m": (!!isNaN(this.maxArtifactIssueCost) ? null : this.maxArtifactIssueCost),
            "a": (this.lastArtifactIssuedDate == null ? null : this.lastArtifactIssuedDate.time),
            "n": (!!isNaN(this.attackersMinimalLevel) ? null : this.attackersMinimalLevel),
            "x": (!!isNaN(this.attackersMaximalLevel) ? null : this.attackersMaximalLevel)
        };
        return _loc1_;
    }
}
}
