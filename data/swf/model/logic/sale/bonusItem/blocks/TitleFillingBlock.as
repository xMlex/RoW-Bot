package model.logic.sale.bonusItem.blocks {
import model.logic.sale.bonusItem.IAppliableFilling;
import model.logic.sale.bonusItem.dynamicFilling.IFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.ITitleFillingElement;

public class TitleFillingBlock implements IAppliableFilling {


    private var _title:String;

    public function TitleFillingBlock(param1:String) {
        super();
        this._title = param1;
    }

    public function get type():int {
        return FillingBlocksTypeEnum.TITLE;
    }

    public function apply(param1:IFillingElement):void {
        var _loc2_:ITitleFillingElement = param1 as ITitleFillingElement;
        if (_loc2_ == null) {
            return;
        }
        _loc2_.fillTitle(this._title);
    }
}
}
