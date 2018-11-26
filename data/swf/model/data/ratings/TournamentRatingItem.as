package model.data.ratings {
import model.data.UserPrize;

public class TournamentRatingItem {


    public var userId:Number;

    public var position:int;

    public var points:Number;

    public var reward:UserPrize;

    public var tag:int;

    public function TournamentRatingItem(param1:Number, param2:int, param3:Number, param4:UserPrize) {
        super();
        this.userId = param1;
        this.position = param2;
        this.points = param3;
        this.reward = param4;
    }
}
}
