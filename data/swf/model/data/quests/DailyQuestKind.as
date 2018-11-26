package model.data.quests {
public class DailyQuestKind {

    public static const Daily:int = 1;

    public static const Alliance:int = 2;

    public static const Vip:int = 3;


    public function DailyQuestKind() {
        super();
    }

    public static function toObject():Object {
        var _loc1_:Object = {};
        _loc1_[Daily] = null;
        _loc1_[Alliance] = null;
        _loc1_[Vip] = null;
        return _loc1_;
    }
}
}
