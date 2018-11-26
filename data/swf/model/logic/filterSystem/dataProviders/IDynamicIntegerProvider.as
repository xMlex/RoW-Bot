package model.logic.filterSystem.dataProviders {
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicInteger;

public interface IDynamicIntegerProvider {


    function get value():IDynamicInteger;
}
}
