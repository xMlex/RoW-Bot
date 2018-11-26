package model.logic.sale {
import model.logic.sale.bonusItem.IAppliableFilling;
import model.logic.sale.bonusItem.dynamicFilling.IFillingElement;

public class BonusItem {


    private var _parameters:Object;

    public function BonusItem() {
        super();
        this._parameters = {};
    }

    public function getParameter(param1:int):IAppliableFilling {
        return this._parameters[param1];
    }

    public function addProperty(param1:IAppliableFilling):BonusItem {
        this._parameters[param1.type] = param1;
        return this;
    }

    public function applyAll(param1:IFillingElement):void {
        var _loc2_:IAppliableFilling = null;
        for each(_loc2_ in this._parameters) {
            _loc2_.apply(param1);
        }
    }
}
}
