package model.logic.sale.bonusItem.blocks {
import model.logic.sale.bonusItem.IAppliableFilling;
import model.logic.sale.bonusItem.dynamicFilling.IFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.IResourcesCountFillingElement;

public class ResourcesCountFillingBlock implements IAppliableFilling {


    private var _resourcesCount:int;

    public function ResourcesCountFillingBlock(param1:int) {
        super();
        this._resourcesCount = param1;
    }

    public function get type():int {
        return FillingBlocksTypeEnum.RESOURCES_COUNT;
    }

    public function apply(param1:IFillingElement):void {
        var _loc2_:IResourcesCountFillingElement = param1 as IResourcesCountFillingElement;
        if (_loc2_ == null) {
            return;
        }
        _loc2_.fillResourcesCount(this._resourcesCount >= 1000 ? this._resourcesCount / 1000 + "K" : this._resourcesCount.toString());
    }
}
}
