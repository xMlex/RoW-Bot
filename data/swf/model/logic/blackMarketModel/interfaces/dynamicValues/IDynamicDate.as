package model.logic.blackMarketModel.interfaces.dynamicValues {
import model.logic.blackMarketModel.interfaces.temporary.IRefreshable;

public interface IDynamicDate extends IRefreshable {


    function get isExpired():Boolean;

    function get value():Date;

    function set value(param1:Date):void;
}
}
