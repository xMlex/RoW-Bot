package model.data.alliances.clanPurchases {
import gameObjects.observableObject.ObservableObject;

import model.logic.dtoSerializer.DtoDeserializer;

public class AlliancePurchaseData extends ObservableObject {

    private static const CLASS_NAME:String = "AlliancePurchaseData";

    public static const DATA_CHANGED:String = CLASS_NAME + "_DataChanged";


    public var gachaChestsCollection:Array;

    public var lastReceivedGachaChestIndex:int;

    private var _dirty:Boolean;

    public function AlliancePurchaseData() {
        super();
    }

    public static function fromDto(param1:*):AlliancePurchaseData {
        var _loc2_:AlliancePurchaseData = new AlliancePurchaseData();
        if (param1 != null) {
            _loc2_.gachaChestsCollection = DtoDeserializer.toArray(param1.g, AllianceGachaChestInfo.fromDto);
            _loc2_.lastReceivedGachaChestIndex = param1.l;
        }
        return _loc2_;
    }

    public function update(param1:AlliancePurchaseData):void {
        if (param1 == null) {
            return;
        }
        this.gachaChestsCollection = param1.gachaChestsCollection;
        this.lastReceivedGachaChestIndex = param1.lastReceivedGachaChestIndex;
        this._dirty = true;
    }

    public function dispatchEvents():void {
        if (this._dirty) {
            this._dirty = false;
            dispatchEvent(DATA_CHANGED);
        }
    }
}
}
