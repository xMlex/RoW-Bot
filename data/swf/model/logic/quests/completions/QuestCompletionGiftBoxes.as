package model.logic.quests.completions {
public class QuestCompletionGiftBoxes extends CompletionCompleter {


    public var countRequired:int;

    public var countGathered:int;

    public function QuestCompletionGiftBoxes() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionGiftBoxes {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionGiftBoxes = new QuestCompletionGiftBoxes();
        _loc2_.countRequired = param1.r;
        _loc2_.countGathered = param1.b;
        return _loc2_;
    }

    public static function tryComplete(param1:int = 1):void {
        var countGathered:int = param1;
        tryCompleteQuestCompletions(function (param1:QuestCompletion):Boolean {
            var _loc2_:QuestCompletionGiftBoxes = param1.byChristmasGifts;
            if (_loc2_ == null) {
                return false;
            }
            _loc2_.countGathered = _loc2_.countGathered + countGathered;
            return countGathered >= _loc2_.countRequired;
        });
    }

    public function get isSuccess():Boolean {
        return this.countRequired == this.countGathered;
    }

    public function equal(param1:QuestCompletionGiftBoxes):Boolean {
        if (!param1) {
            return false;
        }
        if (param1.countRequired != this.countRequired) {
            return false;
        }
        if (param1.countGathered != this.countGathered) {
            return false;
        }
        return true;
    }
}
}
