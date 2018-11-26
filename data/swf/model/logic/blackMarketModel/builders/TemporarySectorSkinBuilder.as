package model.logic.blackMarketModel.builders {
import model.data.Resources;
import model.data.SectorSkinType;
import model.data.temporarySkins.TemporarySkin;
import model.logic.ServerManager;
import model.logic.StaticDataManager;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.SectorSkinItem;
import model.logic.blackMarketModel.enums.BlackMarketItemType;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class TemporarySectorSkinBuilder implements IBlackMarketItemBuilder {


    public function TemporarySectorSkinBuilder() {
        super();
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:TemporarySkin = param1.temporarySkinData;
        var _loc3_:SectorSkinType = StaticDataManager.getSectorSkinType(_loc2_.skinTypeId);
        var _loc4_:SectorSkinItem = new SectorSkinItem();
        _loc4_.price = !!_loc3_.price ? _loc3_.price : param1.price;
        _loc4_.iconUrl = ServerManager.buildContentUrl(_loc3_.urlShop);
        _loc4_.itemType = BlackMarketItemType.TEMPORARY_SKIN;
        _loc4_.name = _loc3_.name;
        _loc4_.fullName = _loc3_.name;
        _loc4_.newUntil = _loc3_.newUntil;
        _loc4_.defencePoints = _loc3_.defenceBonusPoints;
        _loc4_.requiredLevel = _loc3_.requiredLevel;
        _loc4_.saleProhibited = param1.saleProhibited;
        _loc4_.buyInBank = param1.buyInBank;
        _loc4_.isTemporary = true;
        _loc4_.temporarySkinData = _loc2_;
        _loc4_.id = param1.id;
        _loc4_.skinTypeId = _loc3_.id;
        return _loc4_;
    }
}
}
