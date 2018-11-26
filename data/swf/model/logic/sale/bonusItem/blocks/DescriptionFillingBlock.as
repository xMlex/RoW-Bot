package model.logic.sale.bonusItem.blocks {
import model.logic.sale.bonusItem.IAppliableFilling;
import model.logic.sale.bonusItem.dynamicFilling.IDescriptionFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.IFillingElement;

public class DescriptionFillingBlock implements IAppliableFilling {


    private var _description:String;

    public function DescriptionFillingBlock(param1:String) {
        super();
        this._description = param1;
    }

    public function get type():int {
        return FillingBlocksTypeEnum.DESCRIPTION;
    }

    public function apply(param1:IFillingElement):void {
        var _loc2_:IDescriptionFillingElement = param1 as IDescriptionFillingElement;
        if (_loc2_ == null) {
            return;
        }
        _loc2_.fillDescription(this._description);
    }
}
}
