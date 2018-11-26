package model.data.effects {
public class EffectSource {

    public static const NONE:int = 0;

    public static const BlackMarketItem:int = 1;

    public static const Dragon:int = 2;

    public static const TemporarySector:int = 4;

    public static const GiftPointsProgram:int = 8;

    public static const ALL:int = BlackMarketItem | Dragon | TemporarySector | GiftPointsProgram;


    public function EffectSource() {
        super();
    }
}
}
