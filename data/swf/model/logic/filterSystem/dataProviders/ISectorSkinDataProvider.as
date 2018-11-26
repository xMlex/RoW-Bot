package model.logic.filterSystem.dataProviders {
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicInteger;
import model.logic.blackMarketModel.refreshableBehaviours.SkinState;

public interface ISectorSkinDataProvider extends IIDProvider {


    function get groupType():int;

    function get skinState():SkinState;

    function get count():IDynamicInteger;

    function get defencePoints():int;
}
}
