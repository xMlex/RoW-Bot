package model.data.globalEvent {
import model.logic.quests.data.Quest;

public class GlobalEventQuestData {


    public var upcomingEventName:String;

    public var upcomingEventText:String;

    public var upcomingEventPictureUrl:String;

    public var quest:Quest;

    public function GlobalEventQuestData() {
        super();
    }

    public static function fromDto(param1:*):GlobalEventQuestData {
        var _loc2_:GlobalEventQuestData = new GlobalEventQuestData();
        _loc2_.upcomingEventName = !!param1.un ? param1.un.c : "";
        _loc2_.upcomingEventText = param1.ut;
        _loc2_.upcomingEventPictureUrl = param1.up;
        _loc2_.quest = Quest.fromDto(param1.q);
        return _loc2_;
    }
}
}
