package model.data.scenes.types.info {
import common.queries.util.query;

public class BlackMarketUnionTypeIds {

    public static const RESET_DAILY_CRYSTAL:int = BlackMarketItemsTypeId.ResetDailyQuestVip;

    public static const RESET_DAILY_BLACK_CRYSTAL:int = BlackMarketItemsTypeId.ResetDailyQuestVipBlack;

    public static const AUTOHIDE_4H_CRYSTAL:int = BlackMarketItemsTypeId.EffectUserAutoMoveTroopsBunker4H;

    public static const AUTOHIDE_4H_BLACK_CRYSTAL:int = BlackMarketItemsTypeId.EffectUserAutoMoveTroopsBunker4HBlack;

    public static const GAIN_ATTACK_10P_4H_CRYSTAL:int = BlackMarketItemsTypeId.EffectUserAttackPowerBonus10P;

    public static const GAIN_ATTACK_10P_4H_BLACK_CRYSTAL:int = BlackMarketItemsTypeId.EffectUserAttackPowerBonus10PBlack;

    public static const GAIN_DEFENCE_10P_4H_CRYSTAL:int = BlackMarketItemsTypeId.EffectUserDefensePowerBonus10P;

    public static const GAIN_DEFENCE_10P_4H_BLACK_CRYSTAL:int = BlackMarketItemsTypeId.EffectUserDefensePowerBonus10PBlack;

    public static const FULL_PROTECTION_8H_CRYSTAL:int = BlackMarketItemsTypeId.EffectUserFullProtection8H;

    public static const FULL_PROTECTION_8H_BLACK_CRYSTAL:int = BlackMarketItemsTypeId.EffectUserFullProtection8HBlack;

    public static const PROTECTION_INTELLIGENCE_1D_CRYSTAL:int = BlackMarketItemsTypeId.EffectUserProtectionIntelligence1D;

    public static const PROTECTION_INTELLIGENCE_1D_BLACK_CRYSTAL:int = BlackMarketItemsTypeId.EffectUserProtectionIntelligence1DBlack;

    public static const FAKE_ARMY_8H_CRYSTAL:int = BlackMarketItemsTypeId.EffectUserUserFakeArmy200P8H;

    public static const FAKE_ARMY_8H_BLACK_CRYSTAL:int = BlackMarketItemsTypeId.EffectUserUserFakeArmy200P8HBlack;

    public static const SECTOR_DEFENCE_POWER_BONUS_4H_CRYSTAL:int = BlackMarketItemsTypeId.EffectSectorDefensePowerBonus10P4H;

    public static const SECTOR_DEFENCE_POWER_BONUS_4H_BLACK_CRYSTAL:int = BlackMarketItemsTypeId.EffectSectorDefensePowerBonus10P4HBlack;

    public static const DYNAMIC_MINES_BONUS_MINING_25P_CRYSTAL:int = BlackMarketItemsTypeId.EffectDynamicMinesBonusMining25P1D;

    public static const DYNAMIC_MINES_BONUS_MINING_25P_BLACK_CRYSTAL:int = BlackMarketItemsTypeId.EffectDynamicMinesBonusMining25P1DBlack;

    private static const UNIONS_LIST:Array = [new BlackMarketUnionType(RESET_DAILY_CRYSTAL, RESET_DAILY_BLACK_CRYSTAL), new BlackMarketUnionType(AUTOHIDE_4H_CRYSTAL, AUTOHIDE_4H_BLACK_CRYSTAL), new BlackMarketUnionType(GAIN_ATTACK_10P_4H_CRYSTAL, GAIN_ATTACK_10P_4H_BLACK_CRYSTAL), new BlackMarketUnionType(GAIN_DEFENCE_10P_4H_CRYSTAL, GAIN_DEFENCE_10P_4H_BLACK_CRYSTAL), new BlackMarketUnionType(FULL_PROTECTION_8H_CRYSTAL, FULL_PROTECTION_8H_BLACK_CRYSTAL), new BlackMarketUnionType(PROTECTION_INTELLIGENCE_1D_CRYSTAL, PROTECTION_INTELLIGENCE_1D_BLACK_CRYSTAL), new BlackMarketUnionType(FAKE_ARMY_8H_CRYSTAL, FAKE_ARMY_8H_BLACK_CRYSTAL), new BlackMarketUnionType(SECTOR_DEFENCE_POWER_BONUS_4H_CRYSTAL, SECTOR_DEFENCE_POWER_BONUS_4H_BLACK_CRYSTAL), new BlackMarketUnionType(DYNAMIC_MINES_BONUS_MINING_25P_CRYSTAL, DYNAMIC_MINES_BONUS_MINING_25P_BLACK_CRYSTAL)];


    public function BlackMarketUnionTypeIds() {
        super();
    }

    public static function getUnionWithItemTypeId(param1:int):BlackMarketUnionType {
        var itemTypeId:int = param1;
        return query(UNIONS_LIST).firstOrDefault(function (param1:BlackMarketUnionType):Boolean {
            return param1.hasItemTypeId(itemTypeId);
        });
    }
}
}
