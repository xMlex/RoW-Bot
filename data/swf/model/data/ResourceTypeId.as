package model.data {
public class ResourceTypeId {

    public static const MONEY:int = 0;

    public static const URANIUM:int = 1;

    public static const TITANITE:int = 2;

    public static const GOLD_MONEY:int = 3;

    public static const BIOCHIPS:int = 4;

    public static const BLACK_CRYSTALS:int = 6;

    public static const BUILDING_UPGRADE:int = 7;

    public static const TECHNOLOGY_UPGRADE:int = 8;

    public static const TECHNOLOGY_UPGRADE_2:int = 9;

    public static const AVP_MONEY:int = 10;

    public static const CONSTRUCTION_ITEMS:int = 11;

    public static const RESOURCE_TYPE_BIOPLAZMA:Number = 5;

    public static const IDOLS:Number = 12;

    public static const LEVEL_UP_POINTS:Number = 13;

    public static var showDefaultResources:Array = [ResourceTypeId.MONEY, ResourceTypeId.URANIUM, ResourceTypeId.TITANITE, ResourceTypeId.BIOCHIPS, ResourceTypeId.GOLD_MONEY, ResourceTypeId.BLACK_CRYSTALS, ResourceTypeId.AVP_MONEY, ResourceTypeId.CONSTRUCTION_ITEMS, ResourceTypeId.IDOLS];


    public function ResourceTypeId() {
        super();
    }
}
}
