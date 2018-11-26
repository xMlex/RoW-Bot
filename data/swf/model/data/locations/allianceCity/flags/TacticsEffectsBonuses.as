package model.data.locations.allianceCity.flags {
public class TacticsEffectsBonuses {


    public var tournamentPrototypeId:Number;

    public var maxDebuffsNumber:int;

    public var expirationDate:Date;

    public var league:int;

    public var buffsCount:int;

    public var debuffsCount:int;

    public function TacticsEffectsBonuses() {
        super();
    }

    public static function fromDto(param1:*):TacticsEffectsBonuses {
        var _loc2_:TacticsEffectsBonuses = new TacticsEffectsBonuses();
        _loc2_.tournamentPrototypeId = param1.t;
        if (param1.m == 0) {
            _loc2_.maxDebuffsNumber = 0;
        }
        else {
            _loc2_.maxDebuffsNumber = !!param1.m ? int(param1.m) : -1;
        }
        _loc2_.expirationDate = !!param1.e ? new Date(param1.e) : null;
        _loc2_.league = param1.l;
        _loc2_.buffsCount = param1.b;
        _loc2_.debuffsCount = param1.d;
        return _loc2_;
    }

    public static function fromDtos(param1:*):Array {
        var dto:* = undefined;
        var dtos:* = param1;
        var a:Array = [];
        for each(dto in dtos) {
            a.push(fromDto(dto));
        }
        a.sort(function (param1:TacticsEffectsBonuses, param2:TacticsEffectsBonuses):int {
            if (param1.tournamentPrototypeId > param2.tournamentPrototypeId) {
                return -1;
            }
            if (param2.tournamentPrototypeId > param1.tournamentPrototypeId) {
                return 1;
            }
            return 0;
        });
        return a;
    }

    public function get isImmunity():Boolean {
        return this.maxDebuffsNumber == 0;
    }
}
}
