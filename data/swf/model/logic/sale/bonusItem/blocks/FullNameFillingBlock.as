package model.logic.sale.bonusItem.blocks {
import model.logic.sale.bonusItem.IAppliableFilling;
import model.logic.sale.bonusItem.dynamicFilling.IFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.IFullNameFillingElement;

public class FullNameFillingBlock implements IAppliableFilling {


    private var _fullName:String;

    public function FullNameFillingBlock(param1:String) {
        super();
        this._fullName = param1;
    }

    public function get type():int {
        return FillingBlocksTypeEnum.FULL_NAME;
    }

    public function apply(param1:IFillingElement):void {
        var _loc2_:IFullNameFillingElement = param1 as IFullNameFillingElement;
        if (_loc2_ == null) {
            return;
        }
        _loc2_.fillFullName(this._fullName);
    }
}
}
