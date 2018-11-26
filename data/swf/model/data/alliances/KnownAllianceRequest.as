package model.data.alliances {
import common.ArrayCustom;

public class KnownAllianceRequest {


    public var allianceId:Number;

    public var type:int;

    public var initDate:Date;

    public function KnownAllianceRequest() {
        super();
    }

    public static function fromDto(param1:*):KnownAllianceRequest {
        var _loc2_:KnownAllianceRequest = new KnownAllianceRequest();
        _loc2_.allianceId = param1.a;
        _loc2_.type = param1.t;
        _loc2_.initDate = param1.e == null ? null : new Date(param1.e);
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

    public function get isEnemy():Boolean {
        return this.type == AllianceRelationshipType.Enemy;
    }

    public function get isWar():Boolean {
        return this.type == AllianceRelationshipType.War;
    }

    public function get isFriend():Boolean {
        return this.type == AllianceRelationshipType.Friend;
    }

    public function get isPeace():Boolean {
        return this.type == AllianceRelationshipType.Peace;
    }

    public function get isChallenge():Boolean {
        return this.type == AllianceRelationshipType.Challenge;
    }
}
}
