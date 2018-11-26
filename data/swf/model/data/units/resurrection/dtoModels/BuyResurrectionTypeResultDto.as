package model.data.units.resurrection.dtoModels {
import model.data.Resources;
import model.data.tournaments.TournamentStatistics;

public class BuyResurrectionTypeResultDto {


    public var tournamentUserPointsDiff:Array;

    public var price:Resources;

    public function BuyResurrectionTypeResultDto() {
        super();
    }

    public static function fromDto(param1:*):BuyResurrectionTypeResultDto {
        var _loc2_:BuyResurrectionTypeResultDto = new BuyResurrectionTypeResultDto();
        _loc2_.price = Resources.fromDto(param1.p);
        _loc2_.tournamentUserPointsDiff = TournamentStatistics.fromDtos(param1.g);
        return _loc2_;
    }
}
}
