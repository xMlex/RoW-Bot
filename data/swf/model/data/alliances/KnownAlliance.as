package model.data.alliances {
import common.ArrayCustom;

import model.logic.ServerTimeManager;

public class KnownAlliance {


    public var allianceId:Number;

    public var knownAllianceInitiateInfo:KnownAllianceInitiateInfo;

    public var knownAllianceActiveInfo:KnownAllianceActiveInfo;

    public var knownAllianceTerminateInfo:KnownAllianceTerminateInfo;

    public function KnownAlliance() {
        super();
    }

    public static function createTerminateInfo(param1:Number, param2:Date):KnownAllianceTerminateInfo {
        var _loc3_:KnownAllianceTerminateInfo = new KnownAllianceTerminateInfo();
        _loc3_.terminatorAllianceId = param1;
        _loc3_.terminationDate = param2;
        return _loc3_;
    }

    public static function createInitiated(param1:Number, param2:int):KnownAlliance {
        var _loc3_:KnownAlliance = new KnownAlliance();
        _loc3_.allianceId = param1;
        _loc3_.knownAllianceInitiateInfo = createInitiateInfo(param2);
        return _loc3_;
    }

    public static function createInitiateInfo(param1:int):KnownAllianceInitiateInfo {
        var _loc2_:KnownAllianceInitiateInfo = new KnownAllianceInitiateInfo();
        _loc2_.type = param1;
        return _loc2_;
    }

    public static function createActiveInfo(param1:int):KnownAllianceActiveInfo {
        var _loc2_:KnownAllianceActiveInfo = new KnownAllianceActiveInfo();
        _loc2_.type = param1;
        return _loc2_;
    }

    public static function createActived(param1:Number, param2:int):KnownAlliance {
        var _loc3_:KnownAlliance = new KnownAlliance();
        _loc3_.allianceId = param1;
        _loc3_.knownAllianceActiveInfo = createActiveInfo(param2);
        return _loc3_;
    }

    public static function fromDto(param1:*):KnownAlliance {
        var _loc2_:KnownAlliance = new KnownAlliance();
        _loc2_.allianceId = param1.a == null ? Number(NaN) : Number(param1.a);
        _loc2_.knownAllianceInitiateInfo = param1.i == null ? null : KnownAllianceInitiateInfo.fromDto(param1.i);
        _loc2_.knownAllianceActiveInfo = param1.c == null ? null : KnownAllianceActiveInfo.fromDto(param1.c);
        _loc2_.knownAllianceTerminateInfo = param1.d == null ? null : KnownAllianceTerminateInfo.fromDto(param1.d);
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

    public function get isRequest():Boolean {
        return this.knownAllianceInitiateInfo != null;
    }

    public function get isActive():Boolean {
        return this.knownAllianceActiveInfo && (!this.knownAllianceTerminateInfo || this.knownAllianceTerminateInfo.terminationDate > ServerTimeManager.serverTimeNow);
    }

    public function get isTerminate():Boolean {
        return this.knownAllianceActiveInfo && this.knownAllianceTerminateInfo;
    }

    public function get isEnemy():Boolean {
        return this.knownAllianceInitiateInfo && this.knownAllianceInitiateInfo.type == AllianceRelationshipType.Enemy;
    }

    public function get isWar():Boolean {
        return this.knownAllianceInitiateInfo && this.knownAllianceInitiateInfo.type == AllianceRelationshipType.War;
    }

    public function get isChallenge():Boolean {
        return this.knownAllianceInitiateInfo && this.knownAllianceInitiateInfo.type == AllianceRelationshipType.Challenge;
    }

    public function get isFriend():Boolean {
        return this.knownAllianceInitiateInfo && this.knownAllianceInitiateInfo.type == AllianceRelationshipType.Friend;
    }

    public function get isPeace():Boolean {
        return this.knownAllianceInitiateInfo && this.knownAllianceInitiateInfo.type == AllianceRelationshipType.Peace;
    }

    public function get isActiveChallenge():Boolean {
        return this.knownAllianceActiveInfo && this.knownAllianceActiveInfo.type == AllianceRelationshipType.Challenge;
    }

    public function get isActiveEnemy():Boolean {
        return this.knownAllianceActiveInfo && this.knownAllianceActiveInfo.type == AllianceRelationshipType.Enemy;
    }

    public function get isActiveWar():Boolean {
        return this.knownAllianceActiveInfo && this.knownAllianceActiveInfo.type == AllianceRelationshipType.War;
    }

    public function get isActiveFriend():Boolean {
        return this.knownAllianceActiveInfo && this.knownAllianceActiveInfo.type == AllianceRelationshipType.Friend;
    }

    public function get isActivePeace():Boolean {
        return this.knownAllianceActiveInfo && this.knownAllianceActiveInfo.type == AllianceRelationshipType.Peace;
    }

    public function get isAlly():Boolean {
        return this.knownAllianceInitiateInfo && (this.knownAllianceInitiateInfo.type == AllianceRelationshipType.Friend || this.knownAllianceInitiateInfo.type == AllianceRelationshipType.Peace) || this.knownAllianceActiveInfo && (this.knownAllianceActiveInfo.type == AllianceRelationshipType.Friend || this.knownAllianceActiveInfo.type == AllianceRelationshipType.Peace);
    }
}
}
