package model.logic.sale.bonusItem.blocks {
import model.logic.sale.bonusItem.IAppliableFilling;
import model.logic.sale.bonusItem.dynamicFilling.ICountFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.IFillingElement;

public class CountFillingBlock implements IAppliableFilling {


    private var _count:int;

    public function CountFillingBlock(param1:int) {
        super();
        this._count = param1;
    }

    public function get type():int {
        return FillingBlocksTypeEnum.COUNT;
    }

    public function apply(param1:IFillingElement):void {
        var _loc2_:ICountFillingElement = param1 as ICountFillingElement;
        if (_loc2_ == null) {
            return;
        }
        _loc2_.fillCount(this._count);
    }
}
}
