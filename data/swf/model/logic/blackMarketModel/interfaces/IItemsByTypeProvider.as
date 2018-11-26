package model.logic.blackMarketModel.interfaces {
import model.logic.blackMarketModel.core.BlackMarketItemBase;

public interface IItemsByTypeProvider {


    function getItemsByType(param1:int):Vector.<BlackMarketItemBase>;
}
}
