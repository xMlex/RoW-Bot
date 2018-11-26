package model.logic.blackMarketModel.interfaces {
import model.logic.blackMarketItems.BlackMarketItemRaw;

public interface IBlackMarketTypeResolver {


    function resolve(param1:BlackMarketItemRaw):int;
}
}
