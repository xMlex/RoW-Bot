package model.logic.blackMarketModel.validation.interfaces {
import model.logic.blackMarketModel.core.BlackMarketItemBase;

public interface IBlackMarketValidator {


    function validate(param1:BlackMarketItemBase):Boolean;

    function concat(param1:IBlackMarketValidator):void;
}
}
