package model.data.scenes.types.info {
import common.ArrayCustom;

import model.data.Resources;
import model.data.scenes.types.info.troops.BattleBehaviour;
import model.data.scenes.types.info.troops.BattleParameters;

public class TroopsLevelInfo {


    private var _battleParameters:BattleParameters;

    public var resources:Resources;

    public var battleBehaviour:BattleBehaviour;

    public var speed:Number;

    public var resourcesCapacity:Number;

    public var antigen:Number;

    public var defensePoints:Number;

    public var attackPoints:Number;

    public function TroopsLevelInfo() {
        super();
    }

    public static function fromDto(param1:*):TroopsLevelInfo {
        if (param1 == null) {
            return null;
        }
        var _loc2_:TroopsLevelInfo = new TroopsLevelInfo();
        _loc2_.resources = Resources.fromDto(param1.r);
        _loc2_._battleParameters = BattleParameters.fromDto(param1.b);
        _loc2_.speed = param1.s;
        _loc2_.resourcesCapacity = param1.c;
        _loc2_.antigen = param1.a;
        _loc2_.battleBehaviour = BattleBehaviour.fromDto(param1.h);
        _loc2_.attackPoints = param1.n;
        _loc2_.defensePoints = param1.z;
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

    public function get attackPower():Number {
        return this._battleParameters.attack;
    }

    public function get reconPower():Number {
        return this.defenseAerospacePower;
    }

    public function get defenseParameters():ArrayCustom {
        return this._battleParameters.defense;
    }

    public function get defenseInfantryPower():Number {
        return this._battleParameters.defense[0].defense;
    }

    public function get defenseArmouredPower():Number {
        return this._battleParameters.defense[1].defense;
    }

    public function get defenseArtilleryPower():Number {
        return this._battleParameters.defense[2].defense;
    }

    public function get defenseAerospacePower():Number {
        return this._battleParameters.defense[3].defense;
    }

    public function get hasDefenseAvpPower():Boolean {
        return this._battleParameters.defense[4] != undefined;
    }

    public function get defenseAvpPower():Number {
        return this._battleParameters.defense[4].defense;
    }
}
}
