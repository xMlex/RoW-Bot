package model.data.scenes.types.info {
import common.ArrayCustom;

import model.data.Resources;

public class ArtifactTypeInfo {


    public var kindId:int;

    public var level:Number;

    public var rareness:int;

    public var activeDays:int;

    public var issueCost:Number;

    public var affectedTypes:Array;

    public var attackBonus:Number;

    public var defenseBonus:Number;

    public var intelligenceBonus:Number;

    public var movementSpeedBonus:Number;

    public var constructionSpeedBonus:Number;

    public var priceBonus:Number;

    public var carryingCapacityBonus:Number;

    public var techResearchSpeedBonus:Number;

    public var sectorDefenseBonus:Number;

    public var sectorIntelligenceDefenseBonus:Number;

    public var resourcesMiningBonus:Resources;

    public var resourcesConsumptionBonus:Number;

    public var sellingPrice:Resources;

    public var name:String;

    public function ArtifactTypeInfo() {
        super();
    }

    public static function fromDto(param1:*):ArtifactTypeInfo {
        if (param1 == null) {
            return null;
        }
        var _loc2_:ArtifactTypeInfo = new ArtifactTypeInfo();
        _loc2_.kindId = param1.k;
        _loc2_.level = param1.l;
        _loc2_.rareness = param1.r;
        _loc2_.activeDays = param1.d == null ? 0 : int(param1.d);
        _loc2_.issueCost = param1.c;
        _loc2_.affectedTypes = param1.at;
        _loc2_.attackBonus = param1.ab == null ? Number(Number.NaN) : Number(param1.ab);
        _loc2_.defenseBonus = param1.db == null ? Number(Number.NaN) : Number(param1.db);
        _loc2_.intelligenceBonus = param1.rb == null ? Number(Number.NaN) : Number(param1.rb);
        _loc2_.movementSpeedBonus = param1.mv == null ? Number(Number.NaN) : Number(param1.mv);
        _loc2_.constructionSpeedBonus = param1.cb == null ? Number(Number.NaN) : Number(param1.cb);
        _loc2_.priceBonus = param1.pp == null ? Number(Number.NaN) : Number(param1.pp);
        _loc2_.carryingCapacityBonus = param1.cc == null ? Number(Number.NaN) : Number(param1.cc);
        _loc2_.techResearchSpeedBonus = param1.tb == null ? Number(Number.NaN) : Number(param1.tb);
        _loc2_.sectorDefenseBonus = param1.sb == null ? Number(Number.NaN) : Number(param1.sb);
        _loc2_.sectorIntelligenceDefenseBonus = param1.ib == null ? Number(Number.NaN) : Number(param1.ib);
        _loc2_.resourcesMiningBonus = Resources.fromDto(param1.xb);
        _loc2_.resourcesConsumptionBonus = param1.yb == null ? Number(Number.NaN) : Number(param1.yb);
        _loc2_.sellingPrice = param1.p == null ? null : Resources.fromDto(param1.p);
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
}
}
