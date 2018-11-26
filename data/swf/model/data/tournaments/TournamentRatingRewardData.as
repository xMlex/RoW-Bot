package model.data.tournaments {
import model.data.UserPrize;

public class TournamentRatingRewardData {


    public var ratingPosition:int = 0;

    public var premierRatingPosition:int = 0;

    public var userReward:UserPrize;

    public var nextUserReward:UserPrize;

    public var premierUserReward:UserPrize;

    public var nextPremierUserReward:UserPrize;

    public function TournamentRatingRewardData() {
        super();
    }
}
}
