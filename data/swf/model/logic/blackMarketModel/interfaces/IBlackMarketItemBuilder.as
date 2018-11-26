package model.logic.blackMarketModel.interfaces {
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.core.BlackMarketItemBase;

public interface IBlackMarketItemBuilder {


    function build(param1:BlackMarketItemRaw):BlackMarketItemBase;
}
}
