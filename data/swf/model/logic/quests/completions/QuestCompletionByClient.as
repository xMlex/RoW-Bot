package model.logic.quests.completions {
import model.data.quests.QuestPrototypeId;

public class QuestCompletionByClient extends CompletionCompleter {

    public static const Code_None:int = 0;

    public static const Code_OpenAchievements:int = 5;

    public static const Code_OpenRatings:int = 6;

    public static const Code_OpenProfile:int = 7;

    public static const Code_OpenMail:int = 8;

    public static const Code_OpenAdviser:int = 9;

    public static const Code_OpenFullScreen:int = 10;

    public static const Code_OpenHelp:int = 19;

    public static const Code_OpenBlackMarket:int = 20;

    public static const Code_OpenRadar:int = 21;

    public static const Code_OpenUserDemo:int = 30;

    public static const Code_OpenUserBeginner:int = 31;

    public static const Code_OpenUserEnemy:int = 32;

    public static const Code_OpenSceneObject:int = 50;

    public static const Code_OpenTreasure:int = 60;

    public static const Code_AddKnownUser:int = 100;

    public static const Code_LikeFacebook:int = 110;

    public static const Code_OkJoinGroup:int = 111;

    public static const Code_MrJoinGroup:int = 112;

    public static const Code_VkJoinGroup:int = 113;

    public static const Code_ForumJoin:int = 151;

    public static const Code_VkAddToMenu:int = 163;

    public static const Code_OkCreateGift:int = 174;

    public static const Code_OpenAlbumJesperKyd:int = 175;

    public static const Code_PostBattleReplay:int = 186;

    public static const Code_AvpShowTempleOnGlobalMap:int = 200;

    public static const Code_AvpVisitTemple:int = 201;

    public static const Code_AvpBuildAvpLab:int = 202;

    public static const Code_AvpShowUnits:int = 203;

    public static const Code_AvpUpgradeBuilding:int = 204;

    public static const Code_AvpShowExtraUnits:int = 205;

    public static const Code_AvpShowAvpMines:int = 206;

    public static const Code_AvpShowStoryRaids:int = 207;

    public static const Code_AvpShowStrategyUnits:int = 208;

    public static const Code_AvpOutro:int = 209;

    public static const Code_OpenAllianceCity:int = 210;

    public static const Code_OpenLotteryWindow:int = 211;

    public static const Code_VisitTroopsTierUpgradeInfo:int = 213;


    public var code:int;

    public var param:Number;

    public function QuestCompletionByClient() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionByClient {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionByClient = new QuestCompletionByClient();
        _loc2_.code = param1.c;
        _loc2_.param = param1.p;
        return _loc2_;
    }

    public static function tryComplete(param1:int, param2:Number = 0):void {
        var code:int = param1;
        var param:Number = param2;
        tryCompleteQuestCompletions(function (param1:QuestCompletion):Boolean {
            var _loc2_:QuestCompletionByClient = param1.byClient;
            return _loc2_ != null && _loc2_.code == code && _loc2_.param == param;
        });
    }

    public static function codeByQuestPrototypeID(param1:int):int {
        switch (param1) {
            case QuestPrototypeId.AvpIntro:
                return Code_AvpShowTempleOnGlobalMap;
            case QuestPrototypeId.AvpTemple:
                return Code_AvpVisitTemple;
            case QuestPrototypeId.AvpBuildLab:
                return Code_AvpBuildAvpLab;
            case QuestPrototypeId.AvpShowLab:
                return Code_AvpShowUnits;
            case QuestPrototypeId.AvpShowUnit:
                return Code_AvpShowExtraUnits;
            case QuestPrototypeId.AvpUpgradeBuilding:
                return Code_AvpUpgradeBuilding;
            case QuestPrototypeId.AvpShowRadar:
                return Code_AvpShowAvpMines;
            case QuestPrototypeId.AvpMissions:
                return Code_AvpShowStoryRaids;
            case QuestPrototypeId.AvpStrategy:
                return Code_AvpShowStrategyUnits;
            case QuestPrototypeId.AvpOutro:
                return Code_AvpOutro;
            default:
                return param1;
        }
    }

    public function equal(param1:QuestCompletionByClient):Boolean {
        if (!param1) {
            return false;
        }
        if (param1.code != this.code) {
            return false;
        }
        if (param1.param != this.param) {
            return false;
        }
        return true;
    }
}
}
