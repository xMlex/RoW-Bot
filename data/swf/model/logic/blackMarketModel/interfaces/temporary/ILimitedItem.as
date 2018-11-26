package model.logic.blackMarketModel.interfaces.temporary {
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicDate;

public interface ILimitedItem {


    function get saleEndDate():IDynamicDate;

    function get saleStartDate():IDynamicDate;
}
}
