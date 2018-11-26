package model.logic.quests.data {
public class QuestPlatformEnum {

    public static const None:int = 0;

    public static const Web:int = 1;

    public static const IOS:int = 2;

    public static const Android:int = 4;

    public static const Mobile:int = IOS | Android;

    public static const All:int = Mobile | Web;


    public function QuestPlatformEnum() {
        super();
    }
}
}
