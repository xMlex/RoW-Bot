package model.logic.sale.bonusItem.blocks {
import model.logic.sale.bonusItem.IAppliableFilling;
import model.logic.sale.bonusItem.dynamicFilling.IActionFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.IFillingElement;
import model.logic.tournament.IActionInvoker;

public class ActionFillingBlock implements IAppliableFilling {


    private var _action:IActionInvoker;

    public function ActionFillingBlock(param1:IActionInvoker) {
        super();
        this._action = param1;
    }

    public function get action():IActionInvoker {
        return this._action;
    }

    public function get type():int {
        return FillingBlocksTypeEnum.ACTION;
    }

    public function apply(param1:IFillingElement):void {
        var _loc2_:IActionFillingElement = param1 as IActionFillingElement;
        if (_loc2_ == null) {
            return;
        }
        _loc2_.fillAction(this._action);
    }
}
}
