package model.logic.quests.data {
public class PartItemsByProbability {


    private var _probabilityPercent:int;

    private var _itemsPartInPercent:int;

    private var _blackMarketItemId:int;

    public function PartItemsByProbability() {
        super();
    }

    public static function fromDto(param1:*):PartItemsByProbability {
        var _loc2_:PartItemsByProbability = new PartItemsByProbability();
        _loc2_._probabilityPercent = param1.p;
        _loc2_._itemsPartInPercent = param1.v;
        _loc2_._blackMarketItemId = param1.i;
        return _loc2_;
    }

    public function get probabilityPercent():int {
        return this._probabilityPercent;
    }

    public function get itemsPartInPercent():int {
        return this._itemsPartInPercent;
    }

    public function get blackMarketItemId():int {
        return this._blackMarketItemId;
    }
}
}
