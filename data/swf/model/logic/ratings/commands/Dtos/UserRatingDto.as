package model.logic.ratings.commands.Dtos {
public class UserRatingDto {


    public var AllTimePoints:Number;

    public function UserRatingDto() {
        super();
    }

    public static function fromDto(param1:*, param2:Boolean = false):UserRatingDto {
        var _loc3_:UserRatingDto = new UserRatingDto();
        _loc3_.AllTimePoints = param1.n < 0 && !param2 ? Number(0) : Number(param1.n);
        return _loc3_;
    }
}
}
