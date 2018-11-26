package model.logic.sale.bonusItem {
import model.logic.sale.bonusItem.dynamicFilling.IFillingElement;

public interface IAppliableFilling {


    function get type():int;

    function apply(param1:IFillingElement):void;
}
}
