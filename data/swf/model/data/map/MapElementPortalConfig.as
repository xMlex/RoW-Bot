package model.data.map {
public class MapElementPortalConfig {


    public function MapElementPortalConfig() {
        super();
    }

    public static function randomTeleportEnabled(param1:int):Boolean {
        if (param1 == MapElementsEnum.USER_NOTE) {
            return true;
        }
        return false;
    }
}
}
