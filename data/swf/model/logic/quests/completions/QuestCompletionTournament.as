package model.logic.quests.completions {
import flash.utils.Dictionary;

public class QuestCompletionTournament {

    private static const CLASS_NAME:String = "QuestCompletionTournament";

    public static const DATA_CHANGED:String = CLASS_NAME + "Changed";


    public var dirty:Boolean;

    public var userLeague:int;

    public var userGroup:int;

    public var gatheredUserPoints:Dictionary;

    public var gatheredAlliancePoints:Number;

    public var allianceUserPoints:Number;

    public var gatheredOverallPoints:Number;

    public var allianceOverallTag:int;

    public var allianceRatingPosition:int;

    public var ratingPosition:int;

    public var superLeagueRatingPosition:int;

    public var allianceLeague:int;

    public var allianceMembersCount:Number;

    public var tournamentStartDate:Date;

    public var tournamentEndDate:Date;

    public function QuestCompletionTournament() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionTournament {
        var _loc3_:* = undefined;
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionTournament = new QuestCompletionTournament();
        _loc2_.userLeague = param1.l;
        _loc2_.userGroup = param1.g == null ? -1 : int(param1.g);
        _loc2_.gatheredUserPoints = new Dictionary();
        if (param1.gp != null) {
            for each(_loc3_ in param1.gp) {
                _loc2_.gatheredUserPoints[_loc3_.s] = _loc3_.p;
            }
        }
        _loc2_.gatheredAlliancePoints = param1.ga;
        _loc2_.allianceUserPoints = param1.au;
        _loc2_.gatheredOverallPoints = param1.go;
        _loc2_.allianceLeague = param1.al;
        _loc2_.ratingPosition = param1.rp < 0 ? int(param1.rp) : int(param1.rp + 1);
        _loc2_.superLeagueRatingPosition = param1.slp < 0 ? int(param1.slp) : int(param1.slp + 1);
        _loc2_.allianceOverallTag = param1.rt;
        _loc2_.allianceRatingPosition = param1.arp < 0 ? int(param1.arp) : int(param1.arp + 1);
        _loc2_.allianceMembersCount = param1.amc;
        _loc2_.tournamentStartDate = new Date(param1.sd);
        _loc2_.tournamentEndDate = new Date(param1.ed);
        return _loc2_;
    }
}
}
