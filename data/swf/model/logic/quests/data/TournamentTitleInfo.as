package model.logic.quests.data {
public class TournamentTitleInfo {


    public var name:String;

    public function TournamentTitleInfo() {
        super();
    }

    public static function fromDto(param1:*):TournamentTitleInfo {
        var _loc2_:TournamentTitleInfo = new TournamentTitleInfo();
        _loc2_.name = param1.c;
        return _loc2_;
    }
}
}
