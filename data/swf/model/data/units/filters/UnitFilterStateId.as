package model.data.units.filters {
public class UnitFilterStateId {

    public static const Any:int = -1;

    public static const Incoming:int = 1;

    public static const Outgoing:int = 2;

    public static const InThisSector:int = 4;

    public static const InOtherSector:int = 8;

    public static const Moving:int = Incoming | Outgoing;


    public function UnitFilterStateId() {
        super();
    }
}
}
