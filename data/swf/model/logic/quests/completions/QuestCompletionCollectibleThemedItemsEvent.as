package model.logic.quests.completions {
import model.logic.StaticDataManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketItems.CollectibleThemedItem;
import model.logic.dtoSerializer.DtoDeserializer;
import model.logic.quests.data.CollectibleThemedItemSourceEnum;
import model.logic.quests.data.PartItemsByProbability;

public class QuestCompletionCollectibleThemedItemsEvent {

    private static const CLASS_NAME:String = "QuestCompletionCollectibleThemedItemsEvent";

    public static const DATA_CHANGED:String = CLASS_NAME + "DataChanged";


    public var gatheredUserItems:Array;

    public var userPoints:int;

    public var userRatingPosition:int;

    public var eventStartDate:Date;

    public var eventEndDate:Date;

    public var availableItemsInSector:Object;

    public var itemsInSectorLastRefreshed:Date;

    public var availableItemsOnMap:Object;

    public var itemsOnMapLastRefreshed:Date;

    public function QuestCompletionCollectibleThemedItemsEvent() {
        super();
    }

    public static function fromDto(param1:*):QuestCompletionCollectibleThemedItemsEvent {
        if (param1 == null) {
            return null;
        }
        var _loc2_:QuestCompletionCollectibleThemedItemsEvent = new QuestCompletionCollectibleThemedItemsEvent();
        _loc2_.gatheredUserItems = DtoDeserializer.toArray(param1.ui);
        _loc2_.userPoints = param1.up;
        _loc2_.userRatingPosition = param1.rp;
        _loc2_.eventStartDate = param1.sd == null ? null : new Date(param1.sd);
        _loc2_.eventEndDate = param1.ed == null ? null : new Date(param1.ed);
        _loc2_.availableItemsInSector = DtoDeserializer.toObject(param1.cs);
        _loc2_.itemsInSectorLastRefreshed = param1.cst == null ? null : new Date(param1.cst);
        _loc2_.availableItemsOnMap = DtoDeserializer.toObject(param1.cm);
        _loc2_.itemsOnMapLastRefreshed = !!null ? null : new Date(param1.cmt);
        return _loc2_;
    }

    public function collectItems(param1:Array, param2:int, param3:int = 0):void {
        var _loc4_:PartItemsByProbability = null;
        var _loc5_:int = 0;
        if (param1 == null) {
            return;
        }
        var _loc6_:int = 0;
        while (_loc6_ < param1.length) {
            _loc4_ = param1[_loc6_];
            _loc5_ = Math.round(param2 * _loc4_.itemsPartInPercent / 100);
            this.collectItem(_loc4_.blackMarketItemId, _loc5_, param3);
            _loc6_++;
        }
    }

    public function collectItem(param1:int, param2:int, param3:int = 0):void {
        var _loc7_:Object = null;
        var _loc8_:CollectibleThemedItem = null;
        var _loc4_:BlackMarketItemRaw = StaticDataManager.blackMarketData.itemsById[param1];
        if (_loc4_ == null || _loc4_.collectibleThemedItems == null) {
            return;
        }
        var _loc5_:Array = _loc4_.collectibleThemedItems;
        var _loc6_:int = 0;
        while (_loc6_ < _loc5_.length) {
            _loc8_ = _loc5_[0];
            this.gatheredUserItems.push(_loc8_);
            this.userPoints = this.userPoints + _loc8_.itemWeight * _loc8_.count * param2;
            _loc6_++;
        }
        switch (param3) {
            case CollectibleThemedItemSourceEnum.MAP:
                _loc7_ = this.availableItemsOnMap;
                break;
            case CollectibleThemedItemSourceEnum.SECTOR:
                _loc7_ = this.availableItemsInSector;
        }
        if (_loc7_ != null && _loc7_[param1] != null) {
            _loc7_[param1] = _loc7_[param1] - param2;
            if (_loc7_[param1] <= 0) {
                delete _loc7_[param1];
            }
        }
    }
}
}
