package model.logic.filterSystem.dataProviders {
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicInteger;

public interface IIDCountProvider {


    function get id():int;

    function get value():IDynamicInteger;
}
}
