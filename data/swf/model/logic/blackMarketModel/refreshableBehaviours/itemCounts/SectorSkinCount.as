package model.logic.blackMarketModel.refreshableBehaviours.itemCounts {
import model.data.users.misc.UserSectorSkinData;
import model.logic.UserManager;
import model.logic.blackMarketModel.core.SectorSkinItem;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicInteger;
import model.logic.blackMarketModel.temporaryCore.DynamicStateObject;

public class SectorSkinCount extends DynamicStateObject implements IDynamicInteger {


    private var _item:SectorSkinItem;

    private var _value:int;

    public function SectorSkinCount(param1:SectorSkinItem) {
        super();
        this._item = param1;
    }

    public function get value():int {
        return this._value;
    }

    public function refresh():void {
        var _loc2_:Boolean = false;
        if (UserManager.user.gameData.sectorSkinsData == null) {
            this._value = 0;
            return;
        }
        var _loc1_:UserSectorSkinData = UserManager.user.gameData.sectorSkinsData;
        if (this._item.isTemporary && _loc1_.temporarySectorSkinData != null) {
            this._value = 0;
        }
        else {
            _loc2_ = _loc1_.checkSkinPurchased(this._item.id);
            this._value = !!_loc2_ ? 1 : 0;
        }
    }
}
}
