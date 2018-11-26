package model.logic.quests.data {
import model.data.UserPrize;
import model.data.quests.Scale;
import model.data.wisdomSkills.LocalTexts;
import model.logic.dtoSerializer.DtoDeserializer;

public class CollectibleThemedItemsEvent {


    private var _pointBonuses:Scale;

    private var _ratingBonuses:Scale;

    private var _itemIcons:String;

    private var _itemRares:Object;

    private var _itemName:String;

    private var _itemDescription:String;

    private var _itemsOnUpgradingBuildings:Array;

    private var _itemsOnUpgradingTechnologies:Array;

    private var _itemsOnBMPurchases:Array;

    public function CollectibleThemedItemsEvent() {
        super();
    }

    public static function fromDto(param1:*):CollectibleThemedItemsEvent {
        var _loc2_:CollectibleThemedItemsEvent = new CollectibleThemedItemsEvent();
        _loc2_._pointBonuses = param1.cp == null ? null : Scale.fromDto(param1.cp, UserPrize.fromDto);
        _loc2_._ratingBonuses = param1.cr == null ? null : Scale.fromDto(param1.cr, UserPrize.fromDto);
        _loc2_._itemIcons = param1.ii;
        _loc2_._itemRares = DtoDeserializer.toObject(param1.ir, LocalTexts.fromDto);
        _loc2_._itemName = param1.gn == null ? null : param1.gn.c;
        _loc2_._itemDescription = param1.gd == null ? null : param1.gd.c;
        _loc2_._itemsOnUpgradingBuildings = DtoDeserializer.toArray(param1.bb, PartItemsByProbability.fromDto);
        _loc2_._itemsOnUpgradingTechnologies = DtoDeserializer.toArray(param1.bt, PartItemsByProbability.fromDto);
        _loc2_._itemsOnBMPurchases = DtoDeserializer.toArray(param1.bm, PartItemsByProbability.fromDto);
        return _loc2_;
    }

    public function get pointBonuses():Scale {
        return this._pointBonuses;
    }

    public function get ratingBonuses():Scale {
        return this._ratingBonuses;
    }

    public function get itemIcons():String {
        return this._itemIcons;
    }

    public function get itemRares():Object {
        return this._itemRares;
    }

    public function get itemName():String {
        return this._itemName;
    }

    public function get itemDescription():String {
        return this._itemDescription;
    }

    public function get itemsOnUpgradingBuildings():Array {
        return this._itemsOnUpgradingBuildings;
    }

    public function get itemsOnUpgradingTechnologies():Array {
        return this._itemsOnUpgradingTechnologies;
    }

    public function get itemsOnBMPurchases():Array {
        return this._itemsOnBMPurchases;
    }
}
}
