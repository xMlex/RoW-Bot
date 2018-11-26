package model.data.locations.mines {
import common.ArrayCustom;

public class LocationNoteMineData {


    public var typeId:int;

    public var resourceTotal:Number;

    public var timeFound:Date;

    public var timeToLiveDays:Number;

    public var maxArtifactIssueCost:Number;

    public var collectedResourceLimit:Number;

    public var collectionTimeDelayHours:Number;

    public var attackersMinimalLevel:Number;

    public var attackersMaximalLevel:Number;

    public var freeFrom:Date;

    public var resources:Number;

    public function LocationNoteMineData() {
        super();
    }

    public static function fromDto(param1:*):LocationNoteMineData {
        var _loc2_:LocationNoteMineData = new LocationNoteMineData();
        _loc2_.typeId = param1.t;
        _loc2_.resourceTotal = param1.r;
        _loc2_.timeFound = param1.f == null ? null : new Date(param1.f);
        _loc2_.timeToLiveDays = param1.l;
        _loc2_.collectedResourceLimit = param1.b;
        _loc2_.collectionTimeDelayHours = param1.d;
        _loc2_.maxArtifactIssueCost = param1.m == null ? Number(Number.NaN) : Number(param1.m);
        _loc2_.attackersMinimalLevel = param1.n == null ? Number(Number.NaN) : Number(param1.n);
        _loc2_.attackersMaximalLevel = param1.x == null ? Number(Number.NaN) : Number(param1.x);
        _loc2_.freeFrom = param1.df == null ? null : new Date(param1.df);
        _loc2_.resources = param1.dr == null ? Number(Number.NaN) : Number(param1.dr);
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
            "f": (this.timeFound == null ? null : this.timeFound.time),
            "l": this.timeToLiveDays,
            "b": this.collectedResourceLimit,
            "d": this.collectionTimeDelayHours,
            "m": (!!isNaN(this.maxArtifactIssueCost) ? null : this.maxArtifactIssueCost),
            "n": (!!isNaN(this.attackersMinimalLevel) ? null : this.attackersMinimalLevel),
            "x": (!!isNaN(this.attackersMaximalLevel) ? null : this.attackersMaximalLevel),
            "df": (this.freeFrom == null ? null : this.freeFrom.time),
            "dr": (!!isNaN(this.resources) ? null : this.resources)
        };
        return _loc1_;
    }
}
}
