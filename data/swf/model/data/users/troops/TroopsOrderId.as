package model.data.users.troops {
public class TroopsOrderId {

    public static const All:int = -1;

    public static const None:int = -1;

    public static const Attack:int = 1;

    public static const Robbery:int = 2;

    public static const Occupation:int = 3;

    public static const Intelligence:int = 4;

    public static const Reinforcement:int = 5;

    public static const MissileStrike:int = 6;

    public static const Bunker:int = 7;

    public static const Return:int = 9;

    public static const Resources:int = 1006;

    public static const Draws:int = 1007;

    public static const Caravan:int = 1008;

    public static const CaravanEmpty:int = 1009;


    public function TroopsOrderId() {
        super();
    }

    public static function isAttacking(param1:int):Boolean {
        return param1 == Robbery || param1 == Occupation;
    }

    public static function isAggressive(param1:int):Boolean {
        return param1 == Robbery || param1 == Occupation || param1 == Attack || param1 == MissileStrike;
    }
}
}
