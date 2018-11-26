package model.logic.sale.bonusItem.blocks {
import model.logic.sale.bonusItem.IAppliableFilling;
import model.logic.sale.bonusItem.dynamicFilling.IFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.IPointsFillingElement;

public class VipPointsFillingBlock implements IAppliableFilling {


    private var _points:int;

    public function VipPointsFillingBlock(param1:int) {
        super();
        this._points = param1;
    }

    public function get type():int {
        return FillingBlocksTypeEnum.POINTS;
    }

    public function apply(param1:IFillingElement):void {
        var _loc2_:IPointsFillingElement = param1 as IPointsFillingElement;
        if (_loc2_ == null) {
            return;
        }
        _loc2_.fillPoints(this._points.toString());
    }
}
}
