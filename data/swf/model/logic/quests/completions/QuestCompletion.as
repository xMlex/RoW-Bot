package model.logic.quests.completions {
public class QuestCompletion {

    public static const State_InProgress:int = 0;

    public static const State_Completed:int = 9;


    public var stateId:int;

    public var byClient:QuestCompletionByClient;

    public var byBuilding:QuestCompletionByBuilding;

    public var byTechnology:QuestCompletionByTechnology;

    public var byTroops:QuestCompletionByTroops;

    public var byDraw:QuestCompletionByDraw;

    public var byChristmasGifts:QuestCompletionGiftBoxes;

    public var byServer:QuestCompletionByServer;

    public var byBattle:QuestCompletionByBattle;

    public var globalMission:GlobalMissionCurrentState;

    public var raidLocation:QuestCompletionRaidLocation;

    public var byFarming:QuestCompletionByFarming;

    public var wizardProgress:QuestCompletionWizardProgress;

    public var pvp:QuestCompletionPvP;

    public var daily:QuestCompletionDaily;

    public var miniGameUserLevel:QuestCompletionMiniGame;

    public var byAchievements:QuestCompletionByStats;

    public var tournament:QuestCompletionTournament;

    public var byFirstDeposit:QuestCompletionByFirstDeposit;

    public var resourceConversion:QuestCompletionResourceConversion;

    public var dynamicMine:QuestCompletionDynamicMine;

    public var byAbility:QuestCompletionByAbility;

    public var byGlobalDeadline:QuestCompletionByGlobalDeadline;

    public var periodic:QuestCompletionPeriodic;

    public var collectibleThemedItemsEvent:QuestCompletionCollectibleThemedItemsEvent;

    public function QuestCompletion() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletion {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletion = new QuestCompletion();
        _loc2_.stateId = param1.s;
        _loc2_.byClient = QuestCompletionByClient.fromDto(param1.c);
        _loc2_.byBuilding = QuestCompletionByBuilding.fromDto(param1.b);
        _loc2_.byTechnology = QuestCompletionByTechnology.fromDto(param1.t);
        _loc2_.byTroops = QuestCompletionByTroops.fromDto(param1.p);
        _loc2_.byDraw = QuestCompletionByDraw.fromDto(param1.d);
        _loc2_.byChristmasGifts = QuestCompletionGiftBoxes.fromDto(param1.r);
        _loc2_.byServer = QuestCompletionByServer.fromDto(param1.e);
        _loc2_.byBattle = QuestCompletionByBattle.fromDto(param1.f);
        _loc2_.globalMission = GlobalMissionCurrentState.fromDto(param1.g);
        _loc2_.raidLocation = QuestCompletionRaidLocation.fromDto(param1.o);
        _loc2_.byFarming = QuestCompletionByFarming.fromDto(param1.a);
        _loc2_.wizardProgress = QuestCompletionWizardProgress.fromDto(param1.w);
        _loc2_.pvp = QuestCompletionPvP.fromDto(param1.y);
        _loc2_.daily = QuestCompletionDaily.fromDto(param1.l);
        _loc2_.miniGameUserLevel = QuestCompletionMiniGame.fromDto(param1.z);
        _loc2_.byAchievements = QuestCompletionByStats.fromDto(param1.x);
        _loc2_.tournament = QuestCompletionTournament.fromDto(param1.u);
        _loc2_.byFirstDeposit = QuestCompletionByFirstDeposit.fromDto(param1.i);
        _loc2_.resourceConversion = QuestCompletionResourceConversion.fromDto(param1.v);
        _loc2_.dynamicMine = QuestCompletionDynamicMine.fromDto(param1.n);
        _loc2_.byAbility = QuestCompletionByAbility.fromDto(param1.m);
        _loc2_.byGlobalDeadline = QuestCompletionByGlobalDeadline.fromDto(param1.q);
        _loc2_.periodic = QuestCompletionPeriodic.fromDto(param1.pq);
        _loc2_.collectibleThemedItemsEvent = QuestCompletionCollectibleThemedItemsEvent.fromDto(param1.ct);
        return _loc2_;
    }

    public static function fromDtos(param1:*):Array {
        var _loc3_:* = undefined;
        if (param1 == null) {
            return null;
        }
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public function isEqual(param1:QuestCompletion):Boolean {
        if (this.byClient && !this.byClient.equal(param1.byClient)) {
            return false;
        }
        if (this.byBuilding && !this.byBuilding.equal(param1.byBuilding)) {
            return false;
        }
        if (this.byTechnology && !this.byTechnology.equal(param1.byTechnology)) {
            return false;
        }
        if (this.byTroops && !this.byTroops.equal(param1.byTroops)) {
            return false;
        }
        if (this.byDraw && !this.byDraw.equal(param1.byDraw)) {
            return false;
        }
        if (this.byChristmasGifts && !this.byChristmasGifts.equal(param1.byChristmasGifts)) {
            return false;
        }
        if (this.byServer && !this.byServer.equal(param1.byServer)) {
            return false;
        }
        if (this.byBattle && !this.byBattle.equal(param1.byBattle)) {
            return false;
        }
        if (this.periodic && !this.periodic.equal(param1.periodic)) {
            return false;
        }
        return true;
    }

    public function isWon():Boolean {
        if (this.byBuilding) {
            return this.byBuilding.isCompleted();
        }
        if (this.byTroops) {
            return this.byTroops.isCompleted();
        }
        return this.stateId == State_Completed;
    }
}
}
