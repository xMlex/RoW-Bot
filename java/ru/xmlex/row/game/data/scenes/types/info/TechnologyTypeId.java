package ru.xmlex.row.game.data.scenes.types.info;

/**
 * Created by xMlex on 21.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public enum TechnologyTypeId {

    None(0),
    CommandCenter(1050),
    Parade(1051),
    TradeGate(1052),
    TroopsAmount(1098),
    ArmySize(1099),
    Сontraband(1054),
    TransportService(1053),
    ChamberOfCommerce(1054);

    public final static TechnologyTypeId[] VALUES = values();

    private final int id;

    TechnologyTypeId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public static TechnologyTypeId getById(int id) {
        for (TechnologyTypeId e : VALUES)
            if (e.getId() == id)
                return e;
        return None;
    }
}
