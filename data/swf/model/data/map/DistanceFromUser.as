package model.data.map {
import model.logic.UserManager;

public class DistanceFromUser extends Distance {


    public function DistanceFromUser(param1:MapPos) {
        super(UserManager.user.gameData.mapPos, param1);
    }
}
}
