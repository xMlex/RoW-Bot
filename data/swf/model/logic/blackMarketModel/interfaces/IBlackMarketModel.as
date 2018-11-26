package model.logic.blackMarketModel.interfaces {
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.interfaces.temporary.IInitializable;

public interface IBlackMarketModel extends IInitializable, IItemsByTypeProvider {


    function getItems():Vector.<BlackMarketItemBase>;
}
}
