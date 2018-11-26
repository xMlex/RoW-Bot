package model.logic.blackMarketItems {
import model.logic.dtoSerializer.ObjectDeserializer;

public class FortificationPackage {


    public var newLevel:int;

    public var buildingsToBuild:Object;

    public var pointsToAdd:Number;

    public function FortificationPackage() {
        super();
    }

    public static function fromDto(param1:*):FortificationPackage {
        var _loc2_:FortificationPackage = new FortificationPackage();
        _loc2_.newLevel = param1.l;
        _loc2_.buildingsToBuild = new ObjectDeserializer(param1.b).deserialize();
        _loc2_.pointsToAdd = param1.p;
        return _loc2_;
    }
}
}
