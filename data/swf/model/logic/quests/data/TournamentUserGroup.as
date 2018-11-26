package model.logic.quests.data {
import model.data.quests.Scale;

public class TournamentUserGroup {


    public var bonuses:Scale;

    public var leaguesCount:int;

    public var minLeagueSize:int;

    public var maxLeagueSize:int;

    public function TournamentUserGroup() {
        super();
    }

    public static function fromDto(param1:*):TournamentUserGroup {
        var _loc2_:TournamentUserGroup = new TournamentUserGroup();
        _loc2_.bonuses = param1.b == null ? null : Scale.fromDto(param1.b);
        _loc2_.leaguesCount = param1.c;
        _loc2_.minLeagueSize = param1.n;
        _loc2_.maxLeagueSize = param1.x;
        return _loc2_;
    }

    public static function fromDtos(param1:*):Array {
        var _loc3_:* = undefined;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
