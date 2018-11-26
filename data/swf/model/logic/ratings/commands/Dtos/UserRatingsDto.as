package model.logic.ratings.commands.Dtos {
public class UserRatingsDto {


    public var AttackerRating:UserRatingDto;

    public var DefenderRating:UserRatingDto;

    public var RobberRating:UserRatingDto;

    public var OccupantRating:UserRatingDto;

    public var RaidsRating:UserRatingDto;

    public function UserRatingsDto() {
        super();
    }

    public static function fromDto(param1:*):UserRatingsDto {
        var _loc2_:UserRatingsDto = new UserRatingsDto();
        _loc2_.AttackerRating = UserRatingDto.fromDto(param1.a);
        _loc2_.DefenderRating = UserRatingDto.fromDto(param1.d);
        _loc2_.RobberRating = UserRatingDto.fromDto(param1.r, true);
        _loc2_.OccupantRating = UserRatingDto.fromDto(param1.o);
        _loc2_.RaidsRating = UserRatingDto.fromDto(param1.b);
        return _loc2_;
    }
}
}
