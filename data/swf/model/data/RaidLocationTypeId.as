package model.data {
public class RaidLocationTypeId {

    public static var RaidersCampTypeId:int = 1;

    public static var AbandonedBaseTypeId:int = 2;

    public static var RuinsOfMetropolisTypeId:int = 3;

    public static var MutantsLairTypeId:int = 4;

    public static var TrackingStation:int = 5;

    public static var ShipSkeleton:int = 6;

    public static var OilDerrick:int = 7;

    public static var SecretBunker:int = 8;

    public static var RefugeeCampTypeId:int = 9;

    public static var SettlementTypeId:int = 10;

    public static var BunkerTypeId:int = 11;

    public static var DominionTypeId:int = 12;

    public static var AttackingLocation1:int = 13;

    public static var DefensiveLocation1:int = 14;

    public static var AttackingLocation2:int = 15;

    public static var DefensiveLocation2:int = 16;

    public static var AttackingLocation3:int = 17;

    public static var DefensiveLocation3:int = 18;

    public static var AttackingLocation4:int = 19;

    public static var DefensiveLocation4:int = 20;

    public static var AttackingLocation5:int = 21;

    public static var DefensiveLocation5:int = 22;

    public static var AttackingLocation6:int = 23;

    public static var DefensiveLocation6:int = 24;

    public static var AttackingLocation7:int = 25;

    public static var DefensiveLocation7:int = 26;

    public static var AttackingLocation8:int = 27;

    public static var DefensiveLocation8:int = 28;

    public static var AttackingLocation9:int = 29;

    public static var DefensiveLocation9:int = 30;

    public static var AttackingLocation10:int = 31;

    public static var DefensiveLocation10:int = 32;

    public static var AttackingLocation11:int = 33;

    public static var DefensiveLocation11:int = 34;

    public static var AttackingLocation12:int = 35;

    public static var DefensiveLocation12:int = 36;

    public static var AttackingLocation13:int = 37;

    public static var DefensiveLocation13:int = 38;

    public static var AttackingLocation14:int = 39;

    public static var DefensiveLocation14:int = 40;

    public static var AttackingLocation15:int = 41;

    public static var DefensiveLocation15:int = 42;

    public static var AttackingLocation16:int = 43;

    public static var DefensiveLocation16:int = 44;

    public static var AttackingLocation17:int = 45;

    public static var DefensiveLocation17:int = 46;

    public static var AttackingLocation18:int = 47;

    public static var DefensiveLocation18:int = 48;

    public static var AttackingLocation19:int = 49;

    public static var DefensiveLocation19:int = 50;

    public static var AttackingLocation20:int = 51;

    public static var DefensiveLocation20:int = 52;

    public static var AttackingLocation21:int = 53;

    public static var DefensiveLocation21:int = 54;

    public static var AttackingLocation22:int = 55;

    public static var DefensiveLocation22:int = 56;

    public static var AttackingLocation23:int = 57;

    public static var DefensiveLocation23:int = 58;

    public static var AttackingLocation24:int = 59;

    public static var DefensiveLocation24:int = 60;

    public static var AlienStep1Attacking:int = 200;

    public static var AlienStep2Attacking:int = 201;

    public static var AlienStep3Attacking:int = 202;

    public static var AlienStep4Attacking:int = 203;

    public static var AlienStep5Attacking:int = 204;

    public static var AlienStep6Attacking:int = 205;

    public static var AlienStep7Attacking:int = 206;

    public static var AlienStep8Attacking:int = 207;

    public static var AlienStep9Attacking:int = 208;

    public static var AlienStep10Attacking:int = 209;

    public static var AlienStep11Attacking:int = 210;

    public static var AlienStep12Attacking:int = 211;

    public static var AlienStep1Defensive:int = 220;

    public static var AlienStep2Defensive:int = 221;

    public static var AlienStep3Defensive:int = 222;

    public static var AlienStep4Defensive:int = 223;

    public static var AlienStep5Defensive:int = 224;

    public static var AlienStep6Defensive:int = 225;

    public static var AlienStep7Defensive:int = 226;

    public static var AlienStep8Defensive:int = 227;

    public static var AlienStep9Defensive:int = 228;

    public static var AlienStep10Defensive:int = 229;

    public static var AlienStep11Defensive:int = 230;

    public static var AlienStep12Defensive:int = 231;

    public static var PredatorStep1Attacking:int = 240;

    public static var PredatorStep2Attacking:int = 241;

    public static var PredatorStep3Attacking:int = 242;

    public static var PredatorStep4Attacking:int = 243;

    public static var PredatorStep5Attacking:int = 244;

    public static var PredatorStep6Attacking:int = 245;

    public static var PredatorStep7Attacking:int = 246;

    public static var PredatorStep8Attacking:int = 247;

    public static var PredatorStep9Attacking:int = 248;

    public static var PredatorStep10Attacking:int = 249;

    public static var PredatorStep11Attacking:int = 250;

    public static var PredatorStep12Attacking:int = 251;

    public static var PredatorStep1Defensive:int = 260;

    public static var PredatorStep2Defensive:int = 261;

    public static var PredatorStep3Defensive:int = 262;

    public static var PredatorStep4Defensive:int = 263;

    public static var PredatorStep5Defensive:int = 264;

    public static var PredatorStep6Defensive:int = 265;

    public static var PredatorStep7Defensive:int = 266;

    public static var PredatorStep8Defensive:int = 267;

    public static var PredatorStep9Defensive:int = 268;

    public static var PredatorStep10Defensive:int = 269;

    public static var PredatorStep11Defensive:int = 270;

    public static var PredatorStep12Defensive:int = 271;

    public static var Defensive5:int = 100;

    public static var Defensive6:int = 101;

    public static var Defensive7:int = 102;


    public function RaidLocationTypeId() {
        super();
    }

    public static function isAlienAttacking(param1:int):Boolean {
        return param1 >= RaidLocationTypeId.AlienStep1Attacking && param1 <= RaidLocationTypeId.AlienStep12Attacking;
    }

    public static function isAlienDefensive(param1:int):Boolean {
        return param1 >= RaidLocationTypeId.AlienStep1Defensive && param1 <= RaidLocationTypeId.AlienStep12Defensive;
    }

    public static function isPredatorAttacking(param1:int):Boolean {
        return param1 >= RaidLocationTypeId.PredatorStep1Attacking && param1 <= RaidLocationTypeId.PredatorStep12Attacking;
    }

    public static function isPredatorDefensive(param1:int):Boolean {
        return param1 >= RaidLocationTypeId.PredatorStep1Defensive && param1 <= RaidLocationTypeId.PredatorStep12Defensive;
    }

    public static function isAvp(param1:int):Boolean {
        return RaidLocationTypeId.isAlienAttacking(param1) || RaidLocationTypeId.isAlienDefensive(param1) || RaidLocationTypeId.isPredatorAttacking(param1) || RaidLocationTypeId.isPredatorDefensive(param1);
    }
}
}
