package model.data.users.buildings {
import model.data.Resources;
import model.data.scenes.objects.GeoSceneObject;

public class LocalStorageBuilding {


    public var building:GeoSceneObject;

    public var miningPerHour:Resources;

    public var limit:Resources;

    public function LocalStorageBuilding() {
        super();
    }
}
}
