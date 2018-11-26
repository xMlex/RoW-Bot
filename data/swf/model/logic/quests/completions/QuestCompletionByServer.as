package model.logic.quests.completions {
public class QuestCompletionByServer {

    public static const ChangeSectorName:int = 1;

    public static const SaveWarcamp:int = 2;

    public static const AddClanMember:int = 5;

    public static const SellDrawingPart:int = 11;

    public static const ResurrectUnit:int = 12;

    public static const ResurrectFreeUnit:int = 13;

    public static const CreateOrAcceptTradingOffer:int = 15;

    public static const SendTroopsUnit:int = 20;

    public static const SendTradingUnitWithResources:int = 21;

    public static const SendTradingUnitWithDrawing:int = 22;

    public static const RetrievedTroopsFromBunker:int = 23;

    public static const SentUnitToBunker:int = 24;

    public static const CaptureMine:int = 25;

    public static const CollectResourcesFromMine:int = 26;

    public static const CollectResourcesFromLocalStorage:int = 27;

    public static const CollectResourcesFromOccupiedSector:int = 28;

    public static const SendTroopsToBunker:int = 29;

    public static const CreateAcademy:int = 31;

    public static const CraftGem:int = 32;

    public static const CreateAlliance:int = 33;

    public static const UseInventoryItem:int = 35;

    public static const UpgradeItem:int = 36;

    public static const UnsealItem:int = 37;

    public static const ChangeCharacterName:int = 38;

    public static const SelectCharacter:int = 39;

    public static const PowderItem:int = 40;

    public static const BeatMonster:int = 41;

    public static const ActivateDragon:int = 42;

    public static const ChangeDragonName:int = 43;

    public static const CompleteResourceConversionJob:int = 41;


    public var code:int;

    public var param:Number;

    public function QuestCompletionByServer() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionByServer {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionByServer = new QuestCompletionByServer();
        _loc2_.code = param1.c;
        _loc2_.param = param1.p;
        return _loc2_;
    }

    public function equal(param1:QuestCompletionByServer):Boolean {
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
