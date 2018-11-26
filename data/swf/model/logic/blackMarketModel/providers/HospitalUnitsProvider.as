package model.logic.blackMarketModel.providers {
import common.ArrayCustom;

import model.data.units.resurrection.enums.LossesType;
import model.data.users.troops.Troops;
import model.logic.UnitResurrectionHelper;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.dataAdapters.HospitalUnitAdapter;
import model.logic.blackMarketModel.interfaces.IRawItemsProvider;

public class HospitalUnitsProvider implements IRawItemsProvider {


    private var _adapter:HospitalUnitAdapter;

    public function HospitalUnitsProvider() {
        super();
        this._adapter = new HospitalUnitAdapter();
    }

    protected function get lossesType():int {
        return LossesType.PAID;
    }

    public function getRawItems():ArrayCustom {
        var _loc3_:* = null;
        var _loc4_:BlackMarketItemRaw = null;
        var _loc1_:Troops = this.getTroops();
        var _loc2_:ArrayCustom = new ArrayCustom();
        for (_loc3_ in _loc1_.countByType) {
            _loc4_ = this._adapter.adapt(int(_loc3_), _loc1_.countByType[_loc3_]);
            if (_loc4_) {
                _loc2_.addItem(_loc4_);
            }
        }
        return _loc2_;
    }

    private function getTroops():Troops {
        return UnitResurrectionHelper.getLossesByType(this.lossesType);
    }
}
}
