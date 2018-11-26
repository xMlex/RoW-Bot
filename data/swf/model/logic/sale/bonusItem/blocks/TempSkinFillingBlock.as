package model.logic.sale.bonusItem.blocks {
import model.data.SectorSkinType;
import model.data.temporarySkins.TemporarySkin;
import model.logic.StaticDataManager;
import model.logic.sale.bonusItem.IAppliableFilling;
import model.logic.sale.bonusItem.dynamicFilling.IFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.ITempSkinFillingElement;

public class TempSkinFillingBlock implements IAppliableFilling {


    private var _tempSkin:TemporarySkin;

    public function TempSkinFillingBlock(param1:TemporarySkin) {
        super();
        this._tempSkin = param1;
    }

    public function get type():int {
        return FillingBlocksTypeEnum.TEMPORARY_SKIN;
    }

    public function apply(param1:IFillingElement):void {
        var _loc2_:ITempSkinFillingElement = param1 as ITempSkinFillingElement;
        if (_loc2_ == null) {
            return;
        }
        var _loc3_:SectorSkinType = StaticDataManager.getSectorSkinType(this._tempSkin.skinTypeId);
        _loc2_.fillSkinPoints(_loc3_.defenceBonusPoints);
        _loc2_.fillEffectsCount(this._tempSkin.additionalEffectInfos.length);
    }
}
}
