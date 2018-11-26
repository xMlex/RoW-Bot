package model.data.map.unitMoving {
public class MapPosBlockExtensions {


    public function MapPosBlockExtensions() {
        super();
    }

    public static function getBlockId(param1:int, param2:int, param3:int = 1):int {
        return param3 == 1 ? param1 << 16 | param2 & 65535 : round(param1, param3) << 16 | round(param2, param3) & 65535;
    }

    private static function round(param1:int, param2:int):int {
        return param1 >= 0 ? int(param1 / param2) : int((param1 - param2 + 1) / param2);
    }
}
}
