package model.logic.blackMarketModel.builders {
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.ItemTypeResolver;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.core.SectorSkinItem;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;

public class SectorSkinBuilder implements IBlackMarketItemBuilder {

    private static var _resolver:ItemTypeResolver = new ItemTypeResolver();


    public function SectorSkinBuilder() {
        super();
    }

    public function build(param1:BlackMarketItemRaw):BlackMarketItemBase {
        var _loc2_:SectorSkinItem = new SectorSkinItem();
        _loc2_.price = param1.price;
        _loc2_.iconUrl = param1.iconUrl;
        _loc2_.name = param1.name;
        _loc2_.fullName = param1.name;
        _loc2_.itemType = _resolver.resolve(param1);
        _loc2_.newUntil = param1.newUntil;
        _loc2_.saleProhibited = param1.saleProhibited;
        _loc2_.defencePoints = param1.sectorSkinType.defenceBonusPoints;
        _loc2_.requiredLevel = param1.sectorSkinType.requiredLevel;
        _loc2_.isTemporary = param1.sectorSkinType.isTemporary;
        _loc2_.isForBankSells = param1.sectorSkinType.isForBankSells;
        _loc2_.id = param1.sectorSkinType.id;
        _loc2_.skinTypeId = param1.sectorSkinType.id;
        return _loc2_;
    }
}
}
