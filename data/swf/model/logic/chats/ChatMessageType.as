package model.logic.chats {
public class ChatMessageType {

    public static const VIP_AGENT_MESSAGE:int = 0;

    public static const ENEMY_REQUEST_ACCEPTED:int = 1;

    public static const WAR_REQUEST_ACCEPT:int = 2;

    public static const WAR_REQUEST_DECLINED:int = 3;

    public static const WAR_CANCELED:int = 4;

    public static const CHALLENGE_REQUEST_ACCEPT:int = 5;

    public static const CHALLENGE_REQUEST_DECLINED:int = 6;

    public static const CHALLENGE_FINISHED:int = 7;

    public static const TOWER_OCCUPIED:int = 10;

    public static const TOWER_UPGRADED:int = 11;

    public static const TOWER_SLOTS_AVAILABLE:int = 12;

    public static const ALLIANCE_ACHIEVEMENT_RECEIVED:int = 20;

    public static const WEEKLY_RATING_UPDATED:int = 30;

    public static const RESOURCE_MINES_ADDED:int = 31;

    public static const ARTIFACT_MINES_ADDED:int = 32;

    public static const USER_MESSAGE:int = 33;

    public static const TOWERS_ADDED:int = 34;

    public static const PVP_RATING_WINNER:int = 35;

    public static const CHAT_BAN:int = 36;

    public static const LOYALTY_SPECIAL_DAY_ACHIEVED:int = 37;

    public static const ALLIANCE_TOURNAMENT_FLAG_RETURNED:int = 100;

    public static const ALLIANCE_TOURNAMENT_EFFECT_APPLIED:int = 101;

    public static const ALLIANCE_TOURNAMENT_EFFECT_SENT:int = 102;

    public static const ALLIANCE_TOURNAMENT_FLAG_STOLEN:int = 103;


    public function ChatMessageType() {
        super();
    }
}
}
